<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siwecos - agent index

Integrates the SIWECOS security-scanning SaaS for the site's own domain. Version **1.1.7** (1.1.x), core `^8 || ^9 || ^10`.

- Config `siwecos.settings`: api_url (default `https://bla.siwecos.de/api/v1`), api_token, domain, domain_token, email, **password**.
- `SiwecosService` (Guzzle, default TLS verify): login, listDomains, addNewDomain, verifyDomain, scan/start, scan/result. Scan/verify/register always target `http://{domain}` where domain is parsed from the site's own `<front>` and the form field is `#disabled` - not user-supplied.
- Routes: `/admin/config/system/siwecos` (`SettingsForm`, perm `administer siwecos configuration`); `/admin/reports/siwecos` (`SiwecosController::build`, perm `access administration pages`).
- Domain verification: `siwecos_page_attachments()` adds a `siwecostoken` meta tag; `SiwecosSubscriber` also sets a `Siwecostoken` response header.

Known issue: `administer siwecos configuration` permission is referenced but never declared (no siwecos.permissions.yml) - form fails closed to uid 1 (functional bug). Report templates use striptags/escaping.
