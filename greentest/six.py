import sys
from gevent.hub import PY3, text_type, string_types

__all__ = ['PY3', 'text_type', 'string_types', 'advance_iterator', 'exec_']

if PY3:
    advance_iterator = next
else:
    def advance_iterator(it):
        return it.next()

if PY3:
    import builtins
    exec_ = getattr(builtins, "exec")

    def reraise(tp, value, tb=None):
        if value.__traceback__ is not tb:
            raise value.with_traceback(tb)
        raise value

    del builtins

else:
    def exec_(code, globs=None, locs=None):
        """Execute code in a namespace."""
        if globs is None:
            frame = sys._getframe(1)
            globs = frame.f_globals
            if locs is None:
                locs = frame.f_locals
            del frame
        elif locs is None:
            locs = globs
        exec("""exec code in globs, locs""")
