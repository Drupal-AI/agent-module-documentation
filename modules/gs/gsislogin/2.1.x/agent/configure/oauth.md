<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure GSIS OAuth2 login

## Admin form
Route `gsislogin.admin_form` → `/admin/config/people/gsislogin` (permission `administer site configuration`,
`AdminGsisLoginForm`). Stores:
- `gsislogin.GSISID` (`title`) — GSIS consumer/client ID.
- `gsislogin.GSISSECRET` (`title`) — GSIS consumer/client secret.
- `gsislogin.GSISTEST` (`title`) — test-server toggle (switches GSIS base URLs for staging).

Obtain the ID/secret by registering your service with GSIS. Use the test server until validated.

## Flow
1. User hits `/gsis` (or the login block / `/gsis/login` form) → `GsisLoginController::start` generates an OAuth `state`, saves it to the session, and redirects to the GSIS authorize endpoint.
2. GSIS redirects back with `code` + `state`. The controller **verifies `state` matches the session** (`GsisLoginController.php:142`) — mismatched/absent state is rejected (CSRF protection).
3. The `code` is exchanged with the GSIS IdP for a token; the user profile is fetched.
4. GSIS fields (taxid, userid, first/last/father/mother name, birth year) are written to the bundled `field_gsis_*` user fields; the matching Drupal account is logged in (created if needed).

## Block
`GsisLoginBlock` provides a placeable "Login with GSIS" button — add it via Block layout.

## Security posture
Anonymous by necessity (login entry points use `access content`); the callback's session-bound `state`
check protects the OAuth flow. Keep the client secret admin-only. Reviewed sound — no changes needed.
