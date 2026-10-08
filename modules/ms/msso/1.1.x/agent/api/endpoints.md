<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# msso / oauth2_server endpoints (forked)

The bundle ships `oauth2_server` 2.1.1 (bshaffer library via Ludwig).

| Route | Path | Access |
|---|---|---|
| authorize | `/oauth2/authorize` | `use oauth2 server` |
| token | `/oauth2/token` | `use oauth2 server` (`_auth: cookie, basic_auth`) |
| tokens | `/oauth2/tokens/{token}` | `use oauth2 server` |
| userinfo | `/oauth2/UserInfo` | `use oauth2 server` (`_auth: oauth2`) |
| revoke | `/oauth2/revoke` | `use oauth2 server` |
| certificates | `/oauth2/certificates` | `_access: TRUE` (public key) |
| jwk | `/oauth2/jwk` | `_access: TRUE` (public key) |
| server/scope/client admin | `/admin/structure/oauth2-servers/...` | `administer oauth2 server` |

Standard flow: create a server → add scopes → add clients (redirect URI + secret) → grant `use oauth2 server`. The library validates redirect_uri, client credentials and grant types.

## Fork-specific caveats (review before production)
- `OAuth2Controller::authorize()` (~line 178): when `$_REQUEST['return_data']=='mon'` and the client has `automatic_authorization`, the controller returns the redirect `Location` header (which contains the issued `code`) base64-encoded in a JSON response instead of redirecting — the code is disclosed to the caller rather than delivered only to the registered redirect_uri.
- `accessNeedsKeys()`/`openIdConfiguration()` (~line 411-435): build an OIDC discovery / JWK doc from `$_SERVER['HTTP_HOST']` and `echo json_encode(...);die;`. No route references them (dead code), but the Host-header trust and non-Drupal output are noted.

Prefer the canonically documented `oauth2_server` 2.1.x unless you specifically need this monitoring fork.
