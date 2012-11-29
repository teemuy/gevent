#!/bin/sh
set -e -x
apt-get update -yqq || true
apt-get upgrade -yqq || true
apt-get install -q python$VER
curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python2.7-cython_0.17.1_i386.deb
dpkg -i python2.7-cython_0.17.1_i386.deb
if [ "x$VER" = "x3.3" ]; then
    apt-get install -q python$VER-dev
    curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/g/greenlet/greenlet-0.4.0.zip #md5=87887570082caadc08fb1f8671dbed71
    curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/p/psycopg2/psycopg2-2.4.5.tar.gz
    curl -sSLO --retry 5 --fail http://pysendfile.googlecode.com/files/pysendfile-2.0.0.tar.gz
    #curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/w/web.py/web.py-0.37.tar.gz
    curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/p/pep8/pep8-1.3.3.tar.gz

    unzip -q greenlet-0.4.0.zip && cd greenlet-0.4.0 && $PYTHON setup.py -q install && cd -
    tar -xf psycopg2-2.4.5.tar.gz && cd psycopg2-2.4.5 && $PYTHON setup.py -q install && cd -
    tar -xf pysendfile-2.0.0.tar.gz && cd pysendfile-2.0.0 && $PYTHON setup.py -q install && cd -
    #tar -xf web.py-0.37.tar.gz && cd web.py-0.37 && $PYTHON setup.py -q install && cd -
    tar -xf pep8-1.3.3.tar.gz && cd pep8-1.3.3 && $PYTHON setup.py -q install && cd -
else
    if [ "x$VER" = "x2.5" ]; then apt-get install libssl-dev libkrb5-dev libbluetooth-dev; curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/s/sslfix/sslfix-1.15.tar.gz; fi
    curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-greenlet_0.4.0_i386.deb
    curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-psycopg2_2.4.5_i386.deb
    curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-pysendfile_2.0.0_i386.deb
    curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/w/web.py/web.py-0.37.tar.gz #md5=93375e3f03e74d6bf5c5096a4962a8db
    dpkg -i python$VER-greenlet_0.4.0_i386.deb
    dpkg -i python$VER-psycopg2_2.4.5_i386.deb
    dpkg -i python$VER-pysendfile_2.0.0_i386.deb
    tar -xf web.py-0.37.tar.gz && cd web.py-0.37 && $PYTHON setup.py -q install && cd -
    if [ "x$VER" = "x2.5" ]; then tar -xf sslfix-1.15.tar.gz && cd sslfix-1.15 && $PYTHON setup.py -q install && cd -; fi
    if [ "x$VER" = "x2.7" ]; then pip install --use-mirrors -q pep8; fi
    $PYTHON -c 'import web; print(web, web.__version__)'
fi
cython --version
$PYTHON -c 'import greenlet; print(greenlet, greenlet.__version__); import psycopg2; print(psycopg2, psycopg2.__version__)'
