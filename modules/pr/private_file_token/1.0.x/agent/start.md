# Private file token — agent index

Appends a signed, time-limited `token`+`timestamp` to `private://` file URLs so they can be
downloaded without the normal per-user private-file access check. No config UI (`configure`
null), no permissions, no Drush. Provides one config key and one service. Works site-wide the
moment it is enabled.

- **The `expiration_time` setting, how tokens are minted/validated, the routes covered** →
  [configure/settings.md](configure/settings.md)
- **The `private_file_token` service (`get()` / `validate()`) for custom code** →
  [api/service.md](api/service.md)

Key facts:
- `hook_file_url_alter()` adds `?token=<hmac>&timestamp=<int>` to every generated `private://` URL.
- Token = `Crypt::hmacBase64($path . $timestamp, $private_key->get() . Settings::getHashSalt())`
  — a 43-char HMAC over the (scheme/base-path-stripped) request path and timestamp. Not guessable/forgeable externally.
- `hook_ENTITY_TYPE_access()` (file `download`) grants access on routes `system.private_file_download`,
  `system.files`, `image.style_private` when a valid, unexpired token matches the current path.
- Only setting: `private_file_token.settings:expiration_time` (seconds, default 10800 = 3h). No install form; change via config.
- The token is a **bearer** credential — not bound to a user/session; anyone with the URL can download until it expires.
