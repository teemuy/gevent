import six
import sys
if six.PY3:
    xrange = range


if 'runtestcase' in sys.argv[1:]:
    import gevent
    import gevent.subprocess
    gevent.spawn(sys.exit, 'bye')
    gevent.subprocess.Popen('python -c "1/0"'.split())
    gevent.sleep(1)
else:
    import subprocess
    for _ in xrange(5):
        out, err = subprocess.Popen([sys.executable, __file__, 'runtestcase'], stderr=subprocess.PIPE).communicate()
        if b'refs' in err:
            assert err.startswith(b'bye'), repr(err)
        else:
            assert err.strip() == b'bye', repr(err)
