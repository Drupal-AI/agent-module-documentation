<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monitoring SSO (`msso`) is a project bundle that ships a **fork of the contrib OAuth2 Server module** (`oauth2_server` 2.1.1) with extra custom code to support a monitoring/SSO integration. It turns the site into an OAuth2 / OpenID Connect provider (authorize, token, userinfo, revoke, JWK/certificates endpoints).
---
The bundled `oauth2_server` submodule uses the bshaffer `oauth2-server-php` library (via Ludwig) to implement the standard flows: `/oauth2/authorize` and `/oauth2/token` are gated by the `use oauth2 server` permission, server/scope/client management lives under `/admin/structure/oauth2-servers` (`administer oauth2 server`), and `/oauth2/certificates` + `/oauth2/jwk` are public (`_access: 'TRUE'`) exposing only the RSA **public** key — correct for OIDC clients. Clients, scopes and servers are config entities; client secrets and the private signing key are handled by the storage service.

**Report-only observations** (this is a modified fork, not stock oauth2_server): (1) a custom block in `OAuth2Controller::authorize()` returns the authorization redirect `Location` header — which carries the issued `code`/token — as a base64-encoded JSON body when `$_REQUEST['return_data']=='mon'`, bypassing normal redirect_uri delivery of the code; (2) dead custom methods `accessNeedsKeys()`/`openIdConfiguration()` build an OIDC discovery/JWK document from the raw `$_SERVER['HTTP_HOST']` (Host-header trust) and `echo ... die` outside Drupal's render pipeline, though no route wires them up; (3) the project README committed a developer's local `.ssh` directory listing (no key material). Because oauth2_server 2.1.x is already documented canonically, this entry documents the **msso fork** specifically. Setup: add a server, define scopes and clients, and grant `use oauth2 server` to authenticating users.
---
- Turn the site into an OAuth2 authorization server.
- Act as an OpenID Connect provider for client apps.
- Define an OAuth2 server entity under `/admin/structure/oauth2-servers`.
- Register OAuth2 clients with redirect URIs and secrets.
- Define scopes for fine-grained authorization.
- Issue authorization codes via `/oauth2/authorize`.
- Exchange codes/credentials for tokens at `/oauth2/token`.
- Expose user claims at `/oauth2/UserInfo`.
- Publish signing keys at `/oauth2/jwk` and `/oauth2/certificates`.
- Revoke tokens at `/oauth2/revoke`.
- Enable automatic authorization for trusted clients.
- Grant `use oauth2 server` to end users who authenticate.
- Restrict `administer oauth2 server` to administrators.
- Integrate a monitoring tool via the custom `return_data=mon` path (review first).
- Support authorization_code / client_credentials grant types.
- Sign ID tokens with RS256 using the site private key.
