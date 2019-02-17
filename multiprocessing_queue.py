#!/usr/bin/env python3
#
# https://www.linuxjournal.com/content/multiprocessing-python
#
#
# v: 0.1
# multiprocessing_queue.py

import multiprocessing
import time
import random
import os
import logging
from multiprocessing import Queue
from subprocess import check_output
import sys

q = Queue()
processes = []

'''

A funcao ou rotina "proc", sera executada dentro de um novo processo filho

'''
def proc(port):
    time.sleep(random.randint(1, 5) * random.random())

    while not q.empty():
        item = q.get()

        try:
            sts = check_output('python3 firefox.py'.format(port, item), shell=True)
            print('[+] {} = {}'.format(os.getpid(), repr(sts)))
        except Exception as e:
            print('[-] {} = {}'.format(os.getpid(), repr(e)))


if __name__ == '__main__':
    multiprocessing.log_to_stderr(logging.DEBUG)

    '''
    
    Alocar dados em fila para serem consumidos pelo processos.
    Cada processo vai usar um numero de porta, ex: processo A: 24000, processo B: 24001 
    
    '''

    for x in range(100):
        q.put(x)

    '''
    
    Iniciar processos usando numero da porta
    
    '''

    for p in range(24000, 24005):
        t = multiprocessing.Process(target=proc, args=(p,), daemon=False)
        processes.append(t)
        t.start()

    '''
    
    esperar o termino dos processsos
    
    '''
    for one_process in processes:
        one_process.join()

    print('[+] all done!')

    sys.exit(0)
