<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Login URL — agent index

Generates cryptographically signed, time-limited URLs (`/autologinurl/{uid}/{hash}`) that log a
user in without a password and redirect anywhere. Depends on core `system` + `user`. Config UI at
`/admin/people/autologinurl` (route `auto_login_url.settings`). No Drush. Both permissions are
`restrict access: true`.

- **Create URLs in code / convert text / helpers / token model** → [api/create.md](api/create.md)
- **Settings keys, admin routes, secret, defaults** → [configure/settings.md](configure/settings.md)
- **Permissions and the public login route's access model** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Token = `substr(Crypt::hmacBase64(random_entropy, key), 0, token_length)`; DB stores
  `hmacBase64(token, key)`, not the token. `key = Settings::getHashSalt() . secret . user_pass_hash`.
- Not forgeable/guessable: attacker cannot compute a token or DB hash without `hash_salt` + module
  secret + the target user's password hash. A password change invalidates that user's URLs.
- Login route `auto_login_url.login` has `_access: TRUE` (public); security is the token itself plus
  per-IP flood control and (optional) IP validation. `no_cache: TRUE`.
- Tables: `auto_login_url` (tokens), `auto_login_url_usage` (analytics). Cron prunes both.
- Tokens (with Token module): `[user:auto-login-url-token]`, `[user:auto-login-url-account-edit-token]`.
