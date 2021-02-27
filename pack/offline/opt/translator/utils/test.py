import time
import hashlib
import requests
import json
# from googletrans import Translator
import urllib
import hmac
import base64
from urllib.parse import quote
import time
import random

class UnitedTranslator(object):

	def __init__(self, dest):
		"""初始化数据

		Args:
			dest: 目标翻译语言
		"""
		self.lang_from = 'auto'
		self.lang_to = dest
		self.headers = {
			'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
		}

	def baidu_get_url_encoded_params(self, query_text):
		"""按api调用要求拼接url

		Args:
			query_text: 待翻译的文本

		Returns:
			符合调用接口要求的参数dict
		"""
		app_id = '你的app_id'
		app_secret = '你的app_secret'
		salt = str(round(time.time() * 1000))
		sign_raw = app_id + query_text + salt + app_secret
		sign = hashlib.md5(sign_raw.encode('utf8')).hexdigest()
		params = {
			'q': query_text,
			'from': self.lang_from,
			'to': self.lang_to,
			'appid': app_id,
			'salt': salt,
			'sign': sign
		}
		return params

	def baidu_parse(self, query_text):
		"""解析有道api返回的 json 数据

		Args:
			query_text: 待翻译的字符串文本

		Returns:
			翻译好的文本
		"""
		base_url = 'https://fanyi-api.baidu.com/api/trans/vip/translate'
		params = self.baidu_get_url_encoded_params(query_text)
		response = requests.get(base_url, headers=self.headers, params=params).text
		json_data = json.loads(response)
		res = [i['dst'] for i in json_data['trans_result']]
		trans_text = '\n\n'.join(res)
		# print('---baidu---')
		# print(trans_text)
		return trans_text

	def youdao_get_url_encoded_params(self, query_text):
		"""按api调用要求拼接url

		Args:
			query_text: 待翻译的文本

		Returns:
			符合调用接口要求的参数dict
		"""
		app_key = '你的app_key'
		app_secret = '你的app_secret'
		salt = str(round(time.time() * 1000))
		sign_raw = app_key + query_text + salt + app_secret
		sign = hashlib.md5(sign_raw.encode('utf8')).hexdigest()
		params = {
			'q': query_text,
			'from': self.lang_from,
			'to': self.lang_to,
			'appKey': app_key,
			'salt': salt,
			'sign': sign
		}
		return params

	def youdao_parse(self, query_text):
		"""解析有道api返回的 json 数据

		Args:
			query_text: 待翻译的字符串文本

		Returns:
			翻译好的文本
		"""
		base_url = 'https://openapi.youdao.com/api'
		params = self.youdao_get_url_encoded_params(query_text)
		response = requests.get(base_url, headers=self.headers, params=params).text
		json_data = json.loads(response)
		trans_text = json_data['translation'][0]
		# print('---youdao---')
		# print(trans_text)
		return trans_text

# 	def google_trans(self, query_text):
# 		lang_to = 'zh-CN' if self.lang_to == 'zh' else self.lang_to
# 		google_trans = Translator()
# 		result = google_trans.translate(query_text, dest=lang_to).text
# 		# print('---google---')
# 		# print(result)
# 		return result

	def tencent_get_url_encoded_params(self, query_text):
		action = 'TextTranslate'
		region = 'ap-guangzhou'
		timestamp = int(time.time())
		nonce = random.randint(1, 1e6)
		secret_id = 'AKIDAHxlIYRJyNVllZTXlumQq0vbKUNd6KaZ'
		secret_key = 'qw7UaUpPiN5XjeKkc7EL3lP6WrYTN1eT'  # my secret_key
		version = '2018-03-21'
		lang_from = self.lang_from
		lang_to = self.lang_to

		params_dict = {
			# 公共参数
			'Action': action,
			'Region': region,
			'Timestamp': timestamp,
			'Nonce': nonce,
			'SecretId': secret_id,
			'Version': version,
			# 接口参数
			'ProjectId': 0,
			'Source': lang_from,
			'Target': lang_to,
			'SourceText': query_text
		}
		# 对参数排序，并拼接请求字符串
		params_str = ''
		for key in sorted(params_dict.keys()):
			pair = '='.join([key, str(params_dict[key])])
			params_str += pair + '&'
		params_str = params_str[:-1]
		# 拼接签名原文字符串
		signature_raw = 'GETtmt.tencentcloudapi.com/?' + params_str
		# 生成签名串，并进行url编码
		hmac_code = hmac.new(bytes(secret_key, 'utf8'), signature_raw.encode('utf8'), hashlib.sha1).digest()
		sign = quote(base64.b64encode(hmac_code))
		# 添加签名请求参数
		params_dict['Signature'] = sign
		# 将 dict 转换为 list 并拼接为字符串
		temp_list = []
		for k, v in params_dict.items():
			temp_list.append(str(k) + '=' + str(v))
		params_data = '&'.join(temp_list)
		print("params_data")
		print(params_data)
		return params_data

	def tencent_parse(self, query_text):
		url_with_args = 'https://tmt.tencentcloudapi.com/?' + self.tencent_get_url_encoded_params(query_text)
		res = requests.get(url_with_args, headers=self.headers)
		json_res = json.loads(res.text)
		print(json_res)
		trans_text = json_res['Response']['TargetText']
		return trans_text

	def translate(self, query_text):
		youdao_res = self.youdao_parse(query_text)
# 		google_res = self.google_trans(query_text)
		baidu_res = self.baidu_parse(query_text)
		result = {
			'youdao': youdao_res,
# 			'google': google_res,
			'baidu': baidu_res
		}
		return result


# 接口调用示例

# 中译英
t1 = UnitedTranslator('en')
zh_text = \
'''
自从2008年以来，Python3横空出世并慢慢进化。Python3的流行一直被认为需要很长一段时间。 事实上，到我写这本书的2013年，绝大部分的Python程序员仍然在生产环境中使用的是版本2系列， 最主要是因为Python3不向后兼容。毫无疑问，对于工作在遗留代码上的每个程序员来讲，向后兼容是不得不考虑的问题。 但是放眼未来，你就会发现Python3给你带来不一样的惊喜。
正如Python3代表未来一样，新的《Python Cookbook》版本相比较之前的版本有了一个全新的改变。 最重要的是，这个意味着本书是一本非常前沿的参考书。书中所有代码都是在Python3.3版本下面编写和测试的， 并没有考虑之前老版本的兼容性，也没有标注旧版本下的解决方案。这样子可能会有争议， 但是我们最终的目的是写一本完全基于最新最先进工具和语言的书籍。 希望这本书能成为在Python3下编码和想升级之前遗留代码的程序员的优秀教程。
'''
# print(zh_text)
# print("---youdao---")
# print(t1.youdao_parse(zh_text))
# print("---baidu---")
# print(t1.baidu_parse(zh_text))
# # print("---google---")
# # print(t1.google_trans(zh_text))
# print("---tencent---")
# print(t1.tencent_parse(zh_text))
# print('\n')
# # 英译中
# t2 = UnitedTranslator('zh')
# en_text = 'How are you doing lately?'
# print(en_text)
# print("---youdao---")
# print(t2.youdao_parse(en_text))
# print("---baidu---")
# print(t2.baidu_parse(en_text))
# # print("---google---")
# # print(t2.google_trans(en_text))
# print("---tencent---")
# print(t2.tencent_parse(en_text))

t2 = UnitedTranslator('zh')
en_text = "hello"
print(t2.tencent_parse(en_text))
