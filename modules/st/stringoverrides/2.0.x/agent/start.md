<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# String Overrides — agent index

Replaces any translatable interface string (`t()` / `TranslatableMarkup`) with your own
text, per language, from one admin form. Backed by a `string_translator` service, not the
Locale import workflow.

- **Admin form, config storage, enabled vs disabled rows, cache** →
  [configure/overrides.md](configure/overrides.md)
- **How the translator hooks into `t()`, service priority, matching & context** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Configure route: `stringoverrides.translations_form.default` →
  `/admin/config/regional/stringoverrides` (redirects to the default language's form
  `/admin/config/regional/stringoverrides/{language}`).
- Permission: `administer string overrides` (restricted).
- Overrides stored in config `stringoverrides.string_override.<langcode>` under `contexts`;
  disabled rows kept in `stringoverrides.string_override.<langcode>_disabled`.
- Active-language translations cached at cache id `stringoverides:translation_for_<langcode>`
  (note the module's original spelling), cleared on save.
- No Drush commands, no plugin types.
