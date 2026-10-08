<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LanguageWire Translation Provider is a TMGMT translator plugin using LanguageWire services.

---

LanguageWire Translation Provider adds a **TMGMT translator** that uses **LanguageWire** — a professional
translation service — so content queued in TMGMT (Translation Management Tool) can be sent to LanguageWire for
(human/professional) translation and returned. It requires PHP 8.1 and depends on TMGMT and Ultimate Cron, in
the Translation Management package.

Use it to route TMGMT translations through LanguageWire. It is a multilingual/integration feature. Security/
data handling: it sends the **content to be translated to LanguageWire** (external data egress — confirm
acceptable), authenticates with **LanguageWire API credentials** (store as **secrets**, over HTTPS), and uses
Ultimate Cron for job processing. It has no access-control role. Configure the LanguageWire credentials and
translator.

---

- Provide a LanguageWire TMGMT translator.
- Send content to LanguageWire.
- Return professional translations.
- Require PHP 8.1.
- Depend on TMGMT and Ultimate Cron.
- Process jobs via cron.
- Send content externally (data egress).
- Store API credentials as secrets.
- Use HTTPS.
- Have no access-control role.
- Configure the translator.
- Handle LanguageWire.
- Translate content.
- Configure credentials.
- Route translations.
- Handle the integration.
- Send for translation.
- Provide translations.
- Secure the credentials.
- Provide LanguageWire translation.
