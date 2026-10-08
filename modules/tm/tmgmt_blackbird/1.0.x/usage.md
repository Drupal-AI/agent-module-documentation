<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blackbird Translator provides a TMGMT translator using the Blackbird service.

---

Blackbird Translator (tmgmt_blackbird) **adds a Blackbird TMGMT translator** — sending content to the Blackbird
translation service (via file-based TMGMT jobs) and receiving translations back. It depends on the TMGMT and TMGMT
File modules.

Use it to translate content with Blackbird. It is a multilingual/integration feature. Security/data handling: it
**sends content to the external Blackbird service** (egress — confirm acceptable) and authenticates with **Blackbird
credentials** (store as secrets — env/Key — over HTTPS). It has no access-control role. Configure the Blackbird
credentials.

---

- Provide a Blackbird TMGMT translator.
- Send content for translation.
- Receive translations back.
- Depend on TMGMT + TMGMT File.
- Serve multilingual/integration.
- Use file-based jobs.
- Send content to Blackbird (egress).
- Confirm the egress is acceptable.
- Store Blackbird credentials as secrets (env/Key, HTTPS).
- Have no access-control role.
- Configure the Blackbird credentials.
- Handle Blackbird translation.
- Translate content.
- Configure the connector.
- Send translations.
- Handle the integration.
- Localize content.
- Manage translations.
- Secure the credentials.
- Provide Blackbird translation.
