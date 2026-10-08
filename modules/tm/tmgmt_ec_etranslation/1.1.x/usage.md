<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Translator for eTranslation provides a TMGMT plugin for eTranslation, the European Commission's machine-translation service.

---

TMGMT Translator for eTranslation provides a TMGMT (Translation Management Tool) translator plugin for
eTranslation — the European Commission's online machine-translation service — so translation jobs managed
through TMGMT can be sent to eTranslation. It depends on the TMGMT module and requires PHP 8.0.

Notably (and unlike the separate `webt`/`tmgmt_webt` eTranslation path, which disables TLS verification),
this module makes its eTranslation API requests through Drupal's **standard HTTP client**
(`$container->get('http_client')`) — so certificate verification is **not** disabled here, and it does not
share the `webt` disabled-TLS finding. When adopting: store the eTranslation credentials (application name/
password) as secrets, and be aware that content submitted for translation is sent to the eTranslation
service (a data-handling consideration for sensitive content). It is a multilingual/integration plugin;
TMGMT governs the workflow. Configure the eTranslation connection.

---

- Translate TMGMT jobs via eTranslation.
- Provide a TMGMT translator for the EU eTranslation.
- Depend on the TMGMT module.
- Require PHP 8.0.
- Use Drupal's standard HTTP client.
- Not disable TLS verification (unlike webt).
- Not share the webt disabled-TLS finding.
- Store eTranslation credentials as secrets.
- Send content to eTranslation for translation.
- Mind data handling for sensitive content.
- Manage translation via TMGMT.
- Configure the eTranslation connection.
- Use the EU machine-translation service.
- Translate content.
- Handle credentials securely.
- Route jobs to eTranslation.
- Support multilingual sites.
- Translate via TMGMT.
- Configure the translator.
- Use eTranslation correctly.
