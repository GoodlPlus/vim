import argparse
import hashlib
import http.client
import json
import random
import re
import urllib

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--engines", default=['baidu'], type=str)
    parser.add_argument("--source_language", default="auto", type=str)
    parser.add_argument("--target_language", default="zh", type=str)
    parser.add_argument("--id", type=str)
    parser.add_argument("--key", type=str)
    parser.add_argument("text", type=str)
    return parser.parse_args()

def join_param(param_dict):
    param_str = ''
    for key in sorted(param_dict.keys()):
        pair = '='.join([key, str(param_dict[key])])
        param_str += pair + '&'
    param_str = param_str[:-1]
    return param_str

def baidu_translate(args, translate_type = ''):
    param_dict = \
    {
        'q': args.text,
        'from': args.source_language,
        'to': args.target_language,
        'appid': args.id,
        'salt': str(random.randint(32768, 65536)),
        'secretKey': args.key,
    }

    if translate_type == "field":
        url = '/api/trans/vip/fieldtranslate/?'
        param_dict['domain'] = 'electronics'
        sign = param_dict['appid'] + param_dict['q'] + param_dict['salt'] + param_dict['domain'] + param_dict['secretKey']

    else:
        url = '/api/trans/vip/translate/?'
        sign = param_dict['appid'] + param_dict['q'] + param_dict['salt'] + param_dict['secretKey']

    param_dict['sign'] = hashlib.md5(sign.encode()).hexdigest()
    del param_dict['secretKey']
    param_dict['q'] = urllib.parse.quote_plus(param_dict['q'])
    url += join_param(param_dict)

    request(url)

def request(url):
    http_client = None
    try:
        http_client = http.client.HTTPConnection('api.fanyi.baidu.com', timeout=3)
        http_client.request('GET', url)

        response = http_client.getresponse()
        result_all = response.read().decode("utf-8")

        result = json.loads(result_all)
        print(result['trans_result'][0]['dst'])

    except Exception as e:
        print(e)

    finally:
        if http_client:
            http_client.close()

def tencent_translate(args):
    param_dict = \
    {
        'Action': 'TextTranslate',
        'Version': '2018-03-21',
        'Region': 'ap-beijing',
        'SourceText': args.text,
        'Source': args.source_language,
        'Target': args.target_language,
        'ProjectId': '0',
        'UntranslatedText': '',
        'secret_id': '',
        'secret_key': '',
    }

    url = join_param(param_dict)
    http_client = None

    try:
        http_client = http.client.HTTPSConnection('tmt.tencentcloudapi.com', timeout=3)
        http_client.request('GET', url)

        response = http_client.getresponse()
        result_all = response.read().decode("utf-8")
        print(result_all)

        result = json.loads(result_all)

    except Exception as e:
        print (e)

    finally:
        if http_client:
            http_client.close()


def text_preprocess(args):
    args.text = re.sub(r'\r', r'', args.text)
    args.text = re.sub(r'\t', r' ', args.text)

    args.text = re.sub(r'^\s+', r'', args.text)
    args.text = re.sub(r'\s+$', r'', args.text)
    args.text = re.sub(r'\s+', r' ', args.text)

    # optimization
#   args.text = re.sub(r'\n\s*\n', r'\n', args.text)
#   args.text = re.sub(r'[^\.]\n(.*\S+.*)', r'\1', args.text)

    args.text = re.sub(r'([a-z])([A-Z][a-z])', r'\1 \2', args.text)
    args.text = re.sub(r'([a-zA-Z])_([a-zA-Z])', r'\1 \2', args.text)

if __name__ == "__main__":
    args = get_args()
    text_preprocess(args)
    baidu_translate(args)
#   print(args.text)
#   baidu_translate(args, 'field')
#   tencent_translate(args)
