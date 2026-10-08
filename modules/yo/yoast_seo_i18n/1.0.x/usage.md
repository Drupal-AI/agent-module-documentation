<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yoast SEO Localizer translates the Real-Time SEO (yoast_seo) content-analysis widget so its feedback shows in the site language instead of always English.

---

The yoast_seo module renders its readability/SEO score messages from a bundled JavaScript library whose strings bypass Drupal's normal translation pipeline, so editors on a non-English site still see English analysis text. This module registers those strings with Drupal's `locale` system and supplies translated JavaScript so the widget's messages are localised. It is a support/glue module with no routes, permissions or services of its own — it depends on yoast_seo and locale.

Setup: enable the module on a multilingual site with yoast_seo already configured, ensure the target languages are installed, and import/translate the provided strings via the usual translation workflow. The analysis widget then renders its guidance in the active interface language.
---
- Show Yoast SEO analysis feedback in the site language
- Localise Real-Time SEO readability messages
- Translate the content-analysis widget for non-English editors
- Register Yoast's JS strings with Drupal locale
- Support multilingual editorial teams
- Provide translated SEO guidance per language
- Integrate Yoast feedback into a localised admin UI
- Avoid English-only SEO scores on translated sites
- Reuse Drupal's translation import workflow
- Cover multiple languages for the Yoast widget
- Improve editor experience in non-English backends
- Keep SEO tooling consistent with interface language
- Localise readability and keyword-analysis feedback
- Add a new language for the Yoast widget via locale import
- Update translations as yoast_seo strings change
- Provide consistent multilingual SEO guidance to authors
