import argparse
import hashlib
import io
import json
import random
import re
import sys

import requests


class Translator:
    def __init__(self, args):
        self.args = args
        self.text_preprocess()
        sys.stdout = io.open(sys.stdout.fileno(), "w", encoding="utf-8")

    def text_preprocess(self):
        self.args.text = re.sub(r"\r", r"", self.args.text)
        self.args.text = re.sub(r"\t", r" ", self.args.text)

        self.args.text = re.sub(r"^\s+", r"", self.args.text)
        self.args.text = re.sub(r"\s+$", r"", self.args.text)
        self.args.text = re.sub(r"\s+", r" ", self.args.text)

        # optimization
        self.args.text = re.sub(r"\n\s*\n", r"\n", self.args.text)
        self.args.text = re.sub(r"[^\.]\n(.*\S+.*)", r"\1", self.args.text)

        self.args.text = re.sub(r"([a-z])([A-Z][a-z])", r"\1 \2", self.args.text)
        self.args.text = re.sub(r"([a-zA-Z])_([a-zA-Z])", r"\1 \2", self.args.text)

    def join_param(self, param_dict):
        param_str = ""
        for key in sorted(param_dict.keys()):
            pair = "=".join([key, str(param_dict[key])])
            param_str += pair + "&"
        param_str = param_str[:-1]
        return param_str


class DeepLTranslator(Translator):
    def __init__(self, args):
        super(DeepLTranslator, self).__init__(args)
        self.headers = {"Content-Type": "application/x-www-form-urlencoded"}

    def request(self, data):
        try:
            response = requests.post(
                "http://101.42.34.41:8080/translate", headers=self.headers, data=data
            )
            ret = response.json()
            print(ret["data"])

        except Exception as e:
            print(e)

    def translate(self):
        param_dict = {"text": self.args.text, "target_lang": self.args.target_language.upper()}
        data = json.dumps(param_dict)
        self.request(data)


class BaiduTranslator(Translator):
    def __init__(self, args):
        super(BaiduTranslator, self).__init__(args)
        self.id = "20210205000691244"
        self.key = "MTdFYn4lTj3ZFcDmmMMm"

    def request(self, url):
        response = requests.get(url)
        ret = response.json()
        print(ret["trans_result"][0]["dst"])


    def translate(self, translate_type=""):
        param_dict = {
            "q": self.args.text,
            "from": self.args.source_language,
            "to": self.args.target_language,
            "appid": self.id,
            "salt": str(random.randint(32768, 65536)),
            "secretKey": self.key,
        }
        url = "https://fanyi-api.baidu.com"

        if translate_type == "field":
            url += "/api/trans/vip/fieldtranslate/?"
            param_dict["domain"] = "electronics"
            sign = (
                param_dict["appid"]
                + param_dict["q"]
                + param_dict["salt"]
                + param_dict["domain"]
                + param_dict["secretKey"]
            )

        else:
            url += "/api/trans/vip/translate/?"
            sign = (
                param_dict["appid"] + param_dict["q"] + param_dict["salt"] + param_dict["secretKey"]
            )

        param_dict["sign"] = hashlib.md5(sign.encode()).hexdigest()
        del param_dict["secretKey"]
        url += self.join_param(param_dict)

        self.request(url)


class TencentTranslator(Translator):
    def __init__(self, args):
        super(TencentTranslator, self).__init__(args)

    def translate(self):
        param_dict = {
            "Action": "TextTranslate",
            "Version": "2018-03-21",
            "Region": "ap-beijing",
            "SourceText": self.args.text,
            "Source": self.args.source_language,
            "Target": self.args.target_language,
            "ProjectId": "0",
            "UntranslatedText": "",
            "secret_id": "",
            "secret_key": "",
        }

        # url = self.join_param(param_dict)
        # http_client = None

        # try:
        #     http_client = http.client.HTTPSConnection("tmt.tencentcloudapi.com", timeout=5)
        #     http_client.request("GET", url)

        #     response = http_client.getresponse()
        #     result_all = response.read().decode("utf-8")
        #     print(result_all)

        #     result = json.loads(result_all)

        # except Exception as e:
        #     print(e)

        # finally:
        #     if http_client:
        #         http_client.close()


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--engine", default="DeepL", type=str)
    parser.add_argument("--source_language", default="en", type=str)
    parser.add_argument("--target_language", default="zh", type=str)
    parser.add_argument("text", type=str)
    return parser.parse_args()


def get_translator(args):
    return eval(args.engine + "Translator")


if __name__ == "__main__":
    args = get_args()
    translator = get_translator(args)(args)
    translator.translate()
