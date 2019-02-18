#!/usr/bin/env python3
#
# by f0r34chb3t4 - Seg 18 Fev 2019 15:40:29 -03
# v: 1.0
# python3 pgrp.py
#
import os
import atexit
import sys
import signal
import time

'''
definir processo atual como "chefe do grupo" dos demais processos que serão criados
com isso podemos mandar um sinal para os "chefe do grupo" e os "capangas"
'''

os.setpgrp()

'''
killar todos os processos "capangas" que foram criados pelo processo "chefe do grupo", quando a execucao for interrompida
'''


@atexit.register
def all_done():
    print('atexit.register uid: {}, pid: {}, pgrp: {}'.format(os.getuid(), os.getpid(), os.getpgrp()))

    '''
    SIGTERM = 15, esse "sinal"; informa ao OS e pede ao "chefe do grupo" e os "capangas" para finalizarem de forma graciosa
    '''

    os.killpg(os.getpgrp(), signal.SIGTERM)


'''
iniciar processo filho A
'''

os.system('xclock &')

time.sleep(3)

'''
iniciar processo filho B
'''

os.system('xcalc &')
time.sleep(3)

'''
iniciar processo filho C
'''

os.system('xlogo &')
time.sleep(5)

if __name__ == '__main__':
    print('__main__: uid: {}, pid: {}, pgrp: {}'.format(os.getuid(), os.getpid(), os.getpgrp()))

sys.exit(0)
