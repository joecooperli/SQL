# -*- coding: utf-8 -*-
"""
Created on Sat May 12 09:08:56 2018

@author: JoeCooper
"""

#使用selenium模拟点击下一页，实现多页查找并获取内容

from selenium import webdriver
from bs4 import BeautifulSoup
import os
from urllib.request import urlretrieve
import time
import random

if __name__ == '__main__':
    url = 'http://www.5442.com/tag/rentiyishu.html'
    url_list_1 = []
    #url_list_2 = []
    
    
    #ChromeOptions，添加浏览器选项
    options = webdriver.ChromeOptions()
    options.add_argument('user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36",')
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')    
    #设置代理IP
    ip_list = ['49.75.195.140:15680','221.228.17.172:8181','218.72.110.139:18118','113.121.240.132:808','175.14.3.69:808',
               '113.116.177.31:808','222.76.187.211:8118','114.226.128.254:6666','180.160.121.48:8118','115.58.130.70:8118',
               '222.76.173.33:8118','124.90.206.31:8118','113.121.240.132:808','175.14.3.69:808','113.116.177.31:808',
               '120.92.119.187:10000','222.76.187.211:8118','114.113.126.82:80','221.228.17.172:8181','218.72.110.139:18118']
    options.add_argument("--proxy-server=http://" + random.choice(ip_list))
    
    driver_1 = webdriver.Chrome(chrome_options=options)
    driver_1.get(url)
    html_1 = driver_1.page_source
    time.sleep(3)
    driver_1.close()
    #driver_1.implicitly_wait(30)
    
    soup_1 = BeautifulSoup(html_1,'lxml')
    url_1 = soup_1.find_all(name='div',class_='img')
    
    for url_2 in url_1:
        url_3 = url_2.a.get('href')
        if str('html') not in str(url_3):
            continue
        print(url_3)
        url_list_1.append(url_3)
        
    print(len(url_list_1))
    
    m = 1
    n = 1
    for url_test in url_list_1:
        options = webdriver.ChromeOptions()
        options.add_argument('user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36",')
        options.add_argument('--headless')
        options.add_argument('--disable-gpu')
        #设置代理IP
        ip_list = ['49.75.195.140:15680','221.228.17.172:8181','218.72.110.139:18118','113.121.240.132:808','175.14.3.69:808',
                   '113.116.177.31:808','222.76.187.211:8118','114.226.128.254:6666','180.160.121.48:8118','115.58.130.70:8118',
                   '222.76.173.33:8118','124.90.206.31:8118','113.121.240.132:808','175.14.3.69:808','113.116.177.31:808',
                   '120.92.119.187:10000','222.76.187.211:8118','114.113.126.82:80','221.228.17.172:8181','218.72.110.139:18118']
        options.add_argument("--proxy-server=http://" + random.choice(ip_list))
    
        driver_2 = webdriver.Chrome(chrome_options=options)
        driver_2.get(url_test)
        #html_2 = driver_2.page_source
        #time.sleep(3)
        #driver_2.close()
        #driver_2.implicitly_wait(30)
        
        i = 1
        while True:
            soup_2 = BeautifulSoup(driver_2.page_source,'lxml')
            url_5 = soup_2.find_all(name='p',align='center')
            
            soup_3 = BeautifulSoup(str(url_5),'lxml')
            url_6 = soup_3.find_all(name='img')
            
            if 'photoes' not in os.listdir():
                os.makedirs('photoes')            
                
            for url_7 in url_6:
                img_url = url_7.get('src')
                img_filename = 'photoes/'+'mm%s-%s'%(m,n)+'.jpg'
                print('下载中',img_url)
                urlretrieve(url=img_url,filename=img_filename)
                print('下载完成')
                n += 1            
            
            if i <= 10:                
                driver_2.find_element_by_xpath("//div[@class='page']/ul/li/a[text()='下一页']").click()
                i += 1
            else:
                break
            
        m += 1
            
            
            