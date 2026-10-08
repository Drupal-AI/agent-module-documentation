<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Taxonomy Glossary (ckeditor_taxonomy_glossary) — agent index

Turns words in CKEditor 5 rich text into **glossary links** that show a tooltip with the
term's definition on the front end. The glossary is an ordinary taxonomy vocabulary
(`glossary`); each linked word carries `<a class="glossary-link" data-glossary-id="TID">`.
A text filter attaches the tooltip library (and optionally preloads definitions); JS fetches
definitions on demand from JSON routes when not preloaded. Installed **1.0.1** (version dir
`1.0.x`). Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Package `Custom`.

## Dependencies

- Drupal core modules only: **`taxonomy`**, **`ckeditor5`**, **`filter`** (`.info.yml`).
- No PHP libraries, no Composer requirements beyond core. Module makes **no outbound HTTP**.

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_taxonomy_glossary_glossarylink` (`.ckeditor5.yml`): toolbar
  item `glossaryLink`, JS plugin `glossaryLink.GlossaryLink` (built bundle
  `js/build/glossaryLink.js`), PHP class `Plugin/CKEditor5Plugin/GlossaryLink`. Allows the
  element `<a class="glossary-link" data-glossary-id>`. The PHP `getDynamicPluginConfig()`
  passes `autocompleteUrl: '/glossary/autocomplete/'` to the editor. JS source under
  `js/ckeditor5_plugins/glossaryLink/src/` (command, editing, UI, form view, autocomplete).
- **Text filter** `ckeditor_taxonomy_glossary_link` (`Plugin/Filter/GlossaryLinkFilter`,
  TYPE_TRANSFORM_REVERSIBLE): scans rendered text for `data-glossary-id="N"`, attaches the
  `glossary_tooltip` library + `drupalSettings`, and (if `preload_descriptions`) inlines each
  term's processed description.
- **8 routes / controller** (`Controller/GlossaryAutocompleteController`): term autocomplete
  (all languages / by language), term description + term info by tid (and by tid+langcode),
  a POST create-term endpoint, a term-form-HTML endpoint, and the settings form. See
  [api/endpoints.md](api/endpoints.md).
- **Settings form** `/admin/config/content/ckeditor-taxonomy-glossary`
  (`Form/GlossarySettingsForm`), config object `ckeditor_taxonomy_glossary.settings`, config
  schema present. See [config/settings.md](config/settings.md).
- **Permissions** (`.permissions.yml`): `administer glossary terms` (restricted),
  `link to glossary terms`, `create glossary terms via editor` (restricted).
- **Hooks** (`Hook/CkeditorTaxonomyGlossaryHooks`, OOP `#[Hook]` + `.module` LegacyHook
  shims): `hook_help`; `hook_page_attachments` attaches admin CSS on text-format pages and,
  on node add/edit routes, the `modal_utilities` library plus `drupalSettings` carrying the
  user's glossary permissions, the language list, and a CSRF token for create-term.
- **Config**: `config/install/…settings.yml` (defaults); `config/optional/
  taxonomy.vocabulary.glossary.yml` creates the `glossary` vocabulary if taxonomy is present.
- **Front-end**: `js/glossary-tooltip.js` (tooltip class: hover/click/keyboard, ARIA live
  region, viewport-aware positioning, on-demand fetch of `/glossary/description/{tid}`), four
  CSS files. No install/update hooks; no Drush; no submodules.

## Solution docs

- **Routes, controller methods, create-term flow, tooltip fetch** → [api/endpoints.md](api/endpoints.md)
- **Settings form, config keys, filter behaviour, CKEditor plugin, permissions** → [config/settings.md](config/settings.md)
