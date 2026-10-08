<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GSIS OAuth2 Login (gsislogin) — agent index

**OAuth2 SSO login client for the Greek GSIS government IdP; verifies the callback `state` and maps citizen data (taxid, names, birth year) to user fields.**

- **Version:** 2.1.x
- **Core:** ^10.3 || ^11
- **Routes:** `gsislogin.login` → `/gsis` (start/callback, `access content`, `no_cache`), `gsislogin.form` → `/gsis/login` (`access content`), `gsislogin.admin_form` → `/admin/config/people/gsislogin` (`administer site configuration`).
- **Config:** `gsislogin.GSISID`, `gsislogin.GSISSECRET`, `gsislogin.GSISTEST` (consumer id / secret / test-server toggle).
- **Controller:** `GsisLoginController` — start stores OAuth `state` in session; callback **verifies `state` against the session** (`GsisLoginController.php:142`) before token exchange with the GSIS IdP. Block plugin `GsisLoginBlock` renders the login button.
- **User fields:** `field_gsis_taxid`, `field_gsis_userid`, `field_gsis_firstname`, `field_gsis_lastname`, `field_gsis_fathername`, `field_gsis_mothername`, `field_gsis_birthyear` (with el translations).
- **Security:** login routes use `access content` because they are the anonymous sign-in entry points; the OAuth `state` is verified against the session (CSRF-protected callback) — reviewed and **sound**. Admin credential form is `administer site configuration`.

See [configure/oauth.md](configure/oauth.md).