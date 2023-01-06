
import sys
from time import sleep
import requests


def check_endp(endpoint: str, step: int = 1):
    max_timeout_s = 10

    print()
    # Dependent on User Interference, ei. Cntl+C or kill -9
    try:
        while 1:
            for timeout_s in range(1, max_timeout_s, step):
                try:
                    res = requests.get(endpoint, timeout=(timeout_s, timeout_s))
                except:
                    print(f'Latency under {timeout_s}s:\tFail.')
                    continue
                finally:
                    sleep(timeout_s)
                success = res.status_code == 200
                print(f'Latency under {timeout_s}s:\tSuccess. BamBum')
                if res.status_code == 200:
                    break
    except:
        print('\nBye.')
        exit()
        quit()


if __name__ == '__main__':

    if sys.argv.__len__() < 2:
        print('No Endpoint specified. Bye.')
        exit()

    endpoint = sys.argv[1]
    check_endp(endpoint)
