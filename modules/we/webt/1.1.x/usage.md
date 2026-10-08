<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WEB-T provides automated content translation for Drupal, with pluggable engines including a generic engine and the EU eTranslation service.

---

WEB-T (webt) provides automated content translation for Drupal — translating content via pluggable
machine-translation engines. It integrates with Drupal's content translation, locale, language and
config translation, and offers engines including a generic engine and an "eTranslation" engine that
uses the European Commission's eTranslation machine-translation API. It is configured at
`webt.settings`.

The eTranslation engine (`EtranslationService`) sends requests to
`https://language-tools.ec.europa.eu/etranslation/api` with the eTranslation credentials
(`Authorization: Basic base64(applicationName:password)`), and the returned translations are written
back into site content. When adopting, store the eTranslation application credentials as secrets.

---

- Automate website content translation.
- Translate content via WEB-T engines.
- Use the EU eTranslation service engine.
- Use the generic translation engine.
- Integrate with content_translation and locale.
- Configure at webt.settings.
- Store eTranslation credentials as secrets.
- Translate content into multiple languages.
- Send content to the translation engine.
- Write translations back into content.
- Support multilingual sites.
- Depend on language and config_translation.
- Configure translation engines.
