#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import hashlib
import os.path

#os.rename('a.ccc', 'b.ccc') #if b.ccc exists, then delete it
#os.rename('b.ccc', 'b.ccc') #non-action

from apk_parse.apk import APK

if len(sys.argv) < 2:
    print('Usage: ' + sys.argv[0] + ' path' + '[md5|sha1|sha256]')
    exit(-1)

root = sys.argv[1]
while root[-1] == '/':
    root = root[:-1]

if not os.path.isdir(root):
#if not os.path.exists(root):
    print('Error: Invalid Directory')
    exit(-2)

num = 0
setofhash = set()
'''
md5set = set()
sha1set = set()
sha256set = set()
'''

ext = '.ccc'
hashtype = 'md5'
if len(sys.argv) >= 3:
    if sys.argv[2] in set(['md5','sha1','sha256']):
        hashtype = sys.argv[2]

def md5sum(fpath,fn):
    f = open(fpath+fn, 'rb')
    sh = hashlib.md5()
    sh.update(f.read())
    f.close()
    print(fpath+fn)
    print(fpath+sh.hexdigest()+ext)
    return sh.hexdigest()

def sha1sum(fpath,fn):
    f = open(fpath+fn, 'rb')
    sh = hashlib.sha1()
    sh.update(f.read())
    f.close()
    print(fpath+fn)
    print(fpath+sh.hexdigest()+ext)
    return sh.hexdigest()

def sha256sum(fpath,fn):
    f = open(fpath+fn, 'rb')
    sh = hashlib.sha256()
    sh.update(f.read())
    f.close()
    print(fpath+fn)
    print(fpath+sh.hexdigest()+ext)
    return sh.hexdigest()

def hashsum(hashtype, fpath, fn):
    if hashtype == 'md5':
        return md5sum(fpath, fn)
    elif hashtype == 'sha1':
        return sha1sum(fpath, fn)
    elif hashtype == 'sha256':
        return sha256sum(fpath, fn)
    else:
        return 'Error: HashType'

def check(fpath):
    global num
    global setofhash
    #global md5set
    #global sha1set
    #global sha256set
    for fp,dirs,fs in os.walk(fpath):
        for f in fs:
            apkf = None
            try:
                apkf = APK(fp+'/'+f)
            except:
                print(fp+'/'+f + ' error in parsing')
            else:
                if apkf.is_valid_APK():
                    bhash = False
                    fhash = hashsum(hashtype,fp+'/',f)
                    if fhash in setofhash:
                        bhash = True
                    else:
                        setofhash.add(fhash)
                        os.rename(fp+'/'+f, fp+'/'+fhash+ext)
                    '''
                    bmd5 = False
                    fmd5 = md5sum(fp+'/',f)
                    if fmd5 in md5set:
                        bmd5 = True
                    else:
                        md5set.add(fmd5)
                    
                    bsha1 = False
                    fsha1 = sha1sum(fp+'/',f)
                    if fsha1 in sha1set:
                        bsha1 = True
                    else:
                        sha1set.add(fsha1)
                    
                    bsha256 = False
                    fsha256 = sha256sum(fp+'/',f)
                    if fsha256 in sha256set:
                        bsha256 = True
                    else:
                        sha256set.add(fsha256)
                    
                    if bmd5 and bsha1 and bsha256:
                        print('file already exsits')
                    '''
                else:
                    print(fp+'/'+f + ' is not an valid apk')
            num = num + 1
            print('')

def gci(fp):
    global num
    global setofhash
    #global md5set
    #global sha1set
    #global sha256set
    files = os.listdir(fp)
    for f in files:
        fd = os.path.join(fp+'/',f)
        if os.path.isdir(fd):
            gci(fd)
        else:
            apkf = None
            try:
                apkf = APK(fp+'/'+f)
            except:
                print(fp+'/'+f + ' error in parsing')
            else:
                if apkf.is_valid_APK():
                    bhash = False
                    fhash = hashsum(hashtype,fp+'/',f)
                    if fhash in setofhash:
                        bhash = True
                    else:
                        setofhash.add(fhash)
                        os.rename(fp+'/'+f, fp+'/'+fhash+ext)
                    '''
                    bmd5 = False
                    fmd5 = md5sum(fp+'/',f)
                    if fmd5 in md5set:
                        bmd5 = True
                    else:
                        md5set.add(fmd5)
                    
                    bsha1 = False
                    fsha1 = sha1sum(fp+'/',f)
                    if fsha1 in sha1set:
                        bsha1 = True
                    else:
                        sha1set.add(fsha1)
                    
                    bsha256 = False
                    fsha256 = sha256sum(fp+'/',f)
                    if fsha256 in sha256set:
                        bsha256 = True
                    else:
                        sha256set.add(fsha256)
                    
                    if bmd5 and bsha1 and bsha256:
                        print('file already exsits')
                    '''
                else:
                    print(fp+'/'+f + ' is not an valid apk')
            num = num + 1
            print('')

check(root)
#gci(root)
print(num)
print(len(setofhash))
'''
print(len(md5set))
print(len(sha1set))
print(len(sha256set))
'''
