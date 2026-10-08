<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LegalWeb Cloud provides integration for the legalweb.io cloud service.

---

LegalWeb Cloud integrates the **legalweb.io** cloud service — providing legal texts (imprint, privacy) and
a consent popup sourced from your legalweb.io subscription. It requires PHP 7.3, provides its own permissions,
ships a `legalweb_cloud_enhancements` submodule, in the Content package.

Use it to surface legalweb.io legal content/consent. `LWCManager::generateAssets()` stores the JS legalweb.io
returns (`dppopupjs`) in `public://legalweb_cloud/legalweb_cloud.js`, which is then loaded as a library on every
non-admin page and refreshed by cron every 24h. The API `guid` is kept in the module's configuration.

---

- Integrate the legalweb.io service.
- Provide legal texts + a consent popup.
- Require PHP 7.3.
- Store the API guid as a secret.
- Provide its own permissions.
- Handle legal content.
- Configure the service.
- Show a consent popup.
- Handle the integration.
- Provide legal texts.
- Provide legalweb.io integration.
