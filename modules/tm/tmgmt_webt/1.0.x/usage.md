<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WEB-T Translator provides a TMGMT implementation of WEB-T website translation (European Commission eTranslation), reusing the webt module's translation engine.

---

WEB-T Translator (tmgmt_webt) is a TMGMT (Translation Management Tool) translator plugin for WEB-T — the
European Commission's website translation, including its eTranslation engine — so translation jobs managed
through TMGMT can be sent to WEB-T/eTranslation. It depends on the TMGMT module and the WEB-T (webt) module,
reusing webt's translation engine.

`WebtTranslator` injects and calls webt's `EtranslationService` (`webt.translation_service.etranslation`).
Translating through TMGMT with the WEB-T/eTranslation translator sends the eTranslation credentials
(`Authorization: Basic …`) and the content to be translated to `language-tools.ec.europa.eu`; the returned
translations are stored as content. Store the eTranslation credentials as secrets.

---

- Translate TMGMT jobs via WEB-T/eTranslation.
- Provide a TMGMT translator for WEB-T.
- Reuse webt's translation engine.
- Depend on TMGMT and webt.
- Store eTranslation credentials as secrets.
- Route translation through TMGMT.
- Use the EU eTranslation engine.
- Manage translation via TMGMT.
- Translate with WEB-T.
