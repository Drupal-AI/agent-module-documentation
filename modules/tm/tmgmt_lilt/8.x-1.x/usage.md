<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lilt Translator integrates the Lilt translation service with the Translation Management Tool (TMGMT).

---

Lilt Translator provides a TMGMT (Translation Management Tool) translator plugin for Lilt — an
AI-assisted translation service — so translation jobs managed through TMGMT can be sent to Lilt for
translation. It depends on the TMGMT and TMGMT File modules, in the Translation Management package.

Use it to translate content via Lilt through TMGMT. Security notes: it authenticates to the Lilt API with an
API key — **store that key as a secret** (not in exported config), and content submitted for translation is
sent to the Lilt service (a data-handling consideration for sensitive content). It uses standard HTTP for
its API calls (TLS verification not disabled). It is a multilingual/integration plugin; TMGMT governs the
workflow. Configure the Lilt connection and API key.

---

- Translate TMGMT jobs via Lilt.
- Provide a TMGMT translator for Lilt.
- Depend on TMGMT and TMGMT File.
- Store the Lilt API key as a secret.
- Avoid the key in exported config.
- Send content to Lilt for translation.
- Mind data handling for sensitive content.
- Use standard HTTP (TLS not disabled).
- Manage translation via TMGMT.
- Configure the Lilt connection.
- Translate content with Lilt.
- Handle the API key securely.
- Route jobs to Lilt.
- Support multilingual sites.
- Configure the translator.
- Use AI-assisted translation.
- Translate via TMGMT.
- Connect to Lilt.
- Configure Lilt API.
- Translate through Lilt.
