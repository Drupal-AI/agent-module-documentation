<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LibreTranslate Translator is a TMGMT implementation of the LibreTranslate service, integrating open-source machine translation.

---

LibreTranslate Translator provides a TMGMT (Translation Management Tool) translator plugin for
LibreTranslate — the open-source, self-hostable machine-translation service — so translation jobs managed
through TMGMT can be sent to a LibreTranslate instance. It depends on the TMGMT module and is configured at
the `tmgmt_translator` collection, in the Translation Management package.

Use it to translate content via LibreTranslate through TMGMT (notably attractive for self-hosting, keeping
content in-house). Security notes: if the LibreTranslate instance requires an API key, **store it as a
secret**; point at an HTTPS endpoint; and if self-hosting, that keeps translation content within your
infrastructure (a data-handling advantage). It uses standard HTTP for its API calls. It is a multilingual/
integration plugin; TMGMT governs the workflow. Configure the LibreTranslate endpoint and key.

---

- Translate TMGMT jobs via LibreTranslate.
- Provide a TMGMT translator for LibreTranslate.
- Use open-source machine translation.
- Depend on the TMGMT module.
- Support self-hosting LibreTranslate.
- Store any LibreTranslate API key as a secret.
- Point at an HTTPS endpoint.
- Keep content in-house when self-hosted.
- Use standard HTTP for API calls.
- Configure at the tmgmt_translator collection.
- Manage translation via TMGMT.
- Translate content.
- Configure the LibreTranslate endpoint.
- Handle the API key securely.
- Translate via TMGMT.
- Use LibreTranslate.
- Configure the translator.
- Route jobs to LibreTranslate.
- Support multilingual sites.
- Translate open-source.
