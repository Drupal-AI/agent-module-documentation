# token_or_webform — agent start

Submodule of **token_or**. Makes token_or's `[a|b|"literal"]` OR/fallback syntax work inside
**Webform**, which replaces tokens through its own `webform.token_manager` service instead of
the core `token` service. Depends on `webform:webform` and `token_or:token_or`. No UI, no
config, no permissions, no plugin type.

- How it decorates the Webform token manager, the `|`/clear behaviour, and the anonymous `[current-user:*]` handling → [api/token_or_webform.md](api/token_or_webform.md)
- Parent module (OR syntax core) → [../../../../2.3.x/agent/start.md](../../../../2.3.x/agent/start.md)
