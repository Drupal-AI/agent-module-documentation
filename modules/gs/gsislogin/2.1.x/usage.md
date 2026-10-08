<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GSIS OAuth2 Login lets users sign in with the Greek government's GSIS (γενική γραμματεία πληροφοριακών συστημάτων) OAuth2 identity service and maps the returned citizen data onto Drupal user fields.
---
The module registers an OAuth2 client for GSIS: a login block/form sends the user to GSIS, and `GsisLoginController` handles the start and the callback. The start action generates and stores an OAuth `state` value in the session and redirects to the GSIS authorize endpoint (a test-server toggle switches base URLs). On return, the callback verifies the returned `state` against the session value (`GsisLoginController.php:142`) before exchanging the authorization `code` with the GSIS IdP for a token and fetching the user's profile (tax id / userid, first/last name, father/mother name, birth year). Those values populate the bundled user fields (`field_gsis_taxid`, `field_gsis_userid`, `field_gsis_firstname`, `field_gsis_lastname`, `field_gsis_fathername`, `field_gsis_mothername`, `field_gsis_birthyear`, translated to Greek), and a Drupal account is matched/created and logged in.

Configuration lives at `/admin/config/people/gsislogin` (`administer site configuration`): the GSIS consumer **ID** and **secret** and a **test server** toggle are stored in `gsislogin.GSISID` / `gsislogin.GSISSECRET` / `gsislogin.GSISTEST`. The login routes (`/gsis`, `/gsis/login`) use `access content` because they are the anonymous sign-in entry points; the callback's session-bound `state` check provides CSRF protection on the OAuth flow (reviewed and sound). A block plugin exposes a "Login with GSIS" button for placement in the theme.
---
- Let Greek users authenticate with their GSIS (TaxisNet) government credentials.
- Add a "Login with GSIS" button via the provided block.
- Configure the GSIS consumer ID and secret at /admin/config/people/gsislogin.
- Toggle the GSIS test server for staging vs production.
- Auto-populate a user's Greek tax id (AFM) on login.
- Store citizen first/last name from GSIS onto the account.
- Capture father/mother name and birth year from the GSIS profile.
- Match or create Drupal accounts from GSIS identity data.
- Protect the OAuth callback with a session-bound state check.
- Place the GSIS login form at /gsis/login for anonymous users.
- Start the OAuth flow from the /gsis route.
- Localize the GSIS user fields into Greek (bundled el translations).
- Provide government SSO for Greek public-sector Drupal sites.
- Restrict admin credential management to site administrators.
- Extend behaviour via the module's api hooks (gsislogin.api.php).
- Theme the login block to match the site.
- Keep client secret in config, editable only by admins.
- Use test mode to validate integration before go-live.