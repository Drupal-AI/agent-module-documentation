<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translatable config pages turns "site settings" into a fielded **content** entity so each value can be **translated** per language — the config-pages pattern (a settings page built from fields) with core `content_translation` support built in.

---

Sites routinely need editable global values that are not really content: a footer contact address, opening hours, a promotional strapline, social links, a call-to-action label. Writing a custom settings form means code for every field, and plain configuration cannot be translated per language without config-translation gymnastics. This module instead makes those values a bundle you define through the UI: at `/admin/structure/translatable_config_pages_types` you create a *translatable config pages type* (a `translatable_config_pages_type` config entity) with a label, a menu placement, and any core/contrib fields added through Field UI. Each type then holds exactly one values entity (a `translatable_config_pages` content entity, `translatable = TRUE`) edited at `/admin/config/system/translatable-config-pages`; the add page hides a type once its single page exists. Because the values are a content entity rather than configuration, enabling translation at `/admin/config/regional/content-language` gives every language its own values through the normal translation UI. Code reads them back through the `translatable_config_pages.manager` service (`loadConfig($bundle, $language)` / `loadConfigFieldValue($bundle, $field, $language)`), and a Drush command (`tcp-gc-fv`) fetches a single value from the CLI. A menu deriver adds one admin link per type. Three permissions divide the work: `administer translatable config pages types` (`restrict access: true`) defines structure, while separate `manage` and `view` permissions let editors maintain and translate the values without touching the field structure. The trade-off of the content-entity approach: values do not move with `drush cex`/`cim`, so they are entered per environment. Dependencies are core `content_translation` and `language`, with a wide core range (`^8.8 || ^9 || ^10 || ^11`).

---

- Translate a site's footer contact details per language.
- Maintain opening hours that differ by market.
- Give editors global values to edit without deploying config.
- Translate a promotional strapline or call-to-action label.
- Avoid writing a custom settings form for each value.
- Model a settings page as a set of Field UI fields.
- Attach images, files, media, or paragraphs to a settings page.
- Translate social media links per market.
- Separate structure from values by permission (site builder vs editor).
- Maintain per-language legal or disclaimer text.
- Provide translated global values to Twig templates.
- Manage a language-specific phone number or address.
- Avoid config translation for values editors must edit often.
- Give a multilingual site editable global content.
- Read a config value in PHP via `loadConfigFieldValue()`.
- Fetch a config value from a script with `drush tcp-gc-fv`.
- Place each settings page under a chosen admin menu parent.
- Keep one canonical values entity per settings "page" (singleton per type).
- Let translators localise site-wide strings through the standard translation UI.
- Hold market-specific site details as translatable fields.
