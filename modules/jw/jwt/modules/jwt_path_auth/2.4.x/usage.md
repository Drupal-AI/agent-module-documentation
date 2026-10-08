<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT Path Authentication accepts a JWT passed in the `?jwt=` query string to authenticate requests to a configured set of path prefixes — handy for direct links such as private file downloads.

---

Some requests cannot carry an `Authorization` header — for example a plain `<a href>` link to a private file, or a URL opened directly in a browser. This submodule adds a global authentication provider (`jwt_path_auth.authentication.jwt`, provider id `jwt_path_auth`, priority 50) that instead reads the token from a `jwt` **query-string** parameter. To limit the blast radius of a token in a URL, it only `applies()` when the request path begins with one of the configured `allowed_path_prefixes` (config object `jwt_path_auth.config`, shipped default `['/system/files/']`, i.e. private files). The token itself must be signed with the site-wide key (same key as the header-based `jwt_auth`) and must carry the nested claims `drupal.path_auth.uid` and `drupal.path_auth.path`; authentication succeeds only if the request path also starts with that in-token `path` claim, binding the token to a specific URL prefix. On success it loads the (unblocked) user and triggers the page-cache kill switch so the response is never cached. Configuration is a single textarea of path prefixes at `/admin/config/system/jwt/path-auth` (route `jwt_path_auth.config_form`, permission `administer jwt`); each prefix must start with `/`.

---

- Let a user download a private file via a direct link that carries a JWT in the URL.
- Authenticate `/system/files/...` private-file requests without an Authorization header.
- Add extra allowed path prefixes so query-string JWTs work on other routes (e.g. an export path).
- Restrict query-string token auth to just the paths you list, leaving everything else header-only.
- Bind a token to one URL prefix via its `drupal.path_auth.path` claim so it cannot be reused elsewhere.
- Issue a time-limited link (short `exp`) to a protected resource for a specific user.
- Embed an authenticated download link in an email or notification.
- Give a headless client a way to fetch a protected file when it can only set the URL, not headers.
- Keep the same signing key as header JWTs so one key rotation covers both.
- Ensure JWT-authenticated file responses are never served from the page cache (kill switch).
- Configure the allowed prefixes through the UI textarea at `/admin/config/system/jwt/path-auth`.
- Manage the prefix list as deployable config (`jwt_path_auth.config` `allowed_path_prefixes`).
- Provide per-user, per-path access to assets behind Drupal's private file system.
- Combine with `jwt_auth_issuer` to mint the tokens that these links carry.
- Validate that a path prefix starts with a slash (enforced by the config form).
