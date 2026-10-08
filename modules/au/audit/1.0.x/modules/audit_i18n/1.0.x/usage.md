Scores multilingual setup: configured languages, translation coverage, modules, and hreflang SEO.

---

Registers the `i18n` analyzer (`I18nAnalyzer`, weight 2). It reviews configured languages, the enabled multilingual module stack, content translation coverage (flagging bundles/entities below `min_translation_percentage`, default 80%), and — when `check_multilingual_seo` is on — hreflang/multilingual SEO configuration.

---

- List configured languages and default language.
- Check the enabled multilingual module stack (language, content_translation, config_translation).
- Report translation coverage and flag content below `min_translation_percentage` (80%).
- Audit hreflang / multilingual SEO configuration (toggle with `check_multilingual_seo`).
- Tune the coverage threshold to your localization SLA.
- Run headless: `drush audit:run i18n --format=json`.
- Weight 2 by default in the Project Score.
