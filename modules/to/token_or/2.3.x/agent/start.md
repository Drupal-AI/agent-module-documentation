# token_or — agent start

Adds "OR"/fallback logic inside a single token: `[a|b|"literal"]` resolves to the first
non-empty candidate. Extends the **Token** module (depends on `token:token`). No admin UI,
no config, no permissions, no plugin type — it is pure token syntax. Works everywhere tokens
are replaced because it swaps the core `token` service for a subclass.

- OR/fallback + literal-string syntax, how replacement + the service override work, programmatic use → [api/token_or.md](api/token_or.md)
- The `hook_tokens_pre` alter it fires, and registering your own tokens to use in OR chains → [hooks/token_or.md](hooks/token_or.md)
- Submodule `token_or_webform` (Webform token-manager fallback) → [../../modules/token_or_webform/2.3.x/agent/start.md](../../modules/token_or_webform/2.3.x/agent/start.md)
