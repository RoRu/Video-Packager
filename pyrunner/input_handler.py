def merge_contexts(*contexts, strict=False):
    """
    Merge all passed dicts
    :param contexts: dicts with context parameters
    :param strict: if True, not allow params overriding
    :return: merged dict
    """
    res = {}
    for context in contexts:
        if strict:
            for key in context:
                if key in res:
                    raise ValueError('Contexts have ambiguous parameters')
        res.update(context)
    return res
