# purge_tokens — agent start

Submodule of **purge**. Implements the Token API (`purge_tokens_token_info()` /
`purge_tokens_tokens()` in `purge_tokens.module`) to expose Purge-related replacement tokens
so token-aware purger plugins can build invalidation URLs/headers from tokens instead of
hard-coded values.

Trivial: no config, schema, permissions, or plugin types. Enable it alongside a token-aware
purger. Consumed via the standard token replacement service; only useful with `purge` +
a purger that supports tokens.
