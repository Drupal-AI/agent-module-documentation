<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Lite Graph API Transport — agent index

Mail transport sending email via the **Microsoft Graph API** (Microsoft 365, OAuth-authenticated) — for
**Symfony Mailer Lite**. Config at the `symfony_mailer_lite_transport` collection. Version **1.0.2**. Core
`^10.1||^11`.

**Security:** store Graph OAuth credentials (client ID/secret/tenant) as secrets; scope the app to mail-send
(least privilege); TLS (Graph is HTTPS). Mail/developer feature; no content-access role.
