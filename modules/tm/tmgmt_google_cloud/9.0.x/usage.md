<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Google Cloud is a TMGMT implementation of the Google Cloud Translate service.

---

TMGMT Google Cloud adds a **translator plugin for TMGMT** (Translation Management Tool) that uses the
**Google Cloud Translation** service — so content queued for translation in TMGMT can be machine-translated by
Google Cloud. It is in the Translation Management package.

Use it for automated Google Cloud translations via TMGMT. It is a multilingual/integration feature. Security/
data handling: it sends the **content to be translated to Google Cloud** (an external data-egress
consideration — confirm this is acceptable for the content), and it authenticates with **Google Cloud
credentials/API key** — store those as **secrets** (env/Key, not committed config), over HTTPS. It has no
access-control role. Configure the Google Cloud credentials and translator.

---

- Provide a Google Cloud TMGMT translator.
- Machine-translate via Google Cloud.
- Translate TMGMT-queued content.
- Send content to Google Cloud (data egress).
- Confirm the egress is acceptable.
- Authenticate with Google Cloud credentials.
- Store credentials as secrets.
- Use HTTPS.
- Have no access-control role.
- Configure the translator.
- Handle Google translation.
- Translate content.
- Configure credentials.
- Handle the integration.
- Machine-translate.
- Configure TMGMT.
- Handle translation.
- Provide translations.
- Secure the API key.
- Provide Google Cloud translation.
