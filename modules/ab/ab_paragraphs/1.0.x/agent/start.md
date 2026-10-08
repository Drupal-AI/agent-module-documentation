<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AB Paragraphs (ab_paragraphs) — agent index

A Paragraphs-based A/B testing module. It installs a paragraph bundle **`ab_test`** holding two
content variants and picks one **per browser session in client-side JavaScript**, so rendered
output stays fully cacheable. It fires impression/click events into whatever analytics library
(Matomo/Piwik Pro `_paq`, GA `gtag`, GTM `dataLayer`) is already on the page — the module does no
reporting itself. Package `Custom`. Depends on **`paragraphs`**. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0-beta3 (`1.0.x`).

- **The ab_test bundle, its six fields, rendering/preprocess, and the session-selection JS** →
  [plugins/ab_test_paragraph.md](plugins/ab_test_paragraph.md)
- **Settings form, config object/schema, analytics-provider wiring, editor helper** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **No plugin classes, no field types.** Everything is a paragraph bundle + fields created
  imperatively in `ab_paragraphs_install()` (`ab_paragraphs.install`), plus module hooks.
- **Hooks** (`ab_paragraphs.module`): `hook_theme` (registers `paragraph__ab_test`),
  `hook_preprocess_paragraph` (builds both variants into `content.ab_test_output`, attaches the
  `ab_paragraphs/ab_test` library, sets a `paragraph:<id>` cache tag, hides raw fields),
  `hook_theme_suggestions_paragraph_alter`, `hook_page_attachments` (loads the editor helper
  library on `entity.node.edit_form` / `node.add` and pushes provider + tracking URL into
  `drupalSettings`), `hook_form_alter` (annotates entity-autocomplete textfields with a
  `data-resolved-path`), `hook_requirements` (runtime check that the six fields exist),
  `hook_uninstall` (deletes all ab_test paragraphs + nested content + fields + the bundle).
- **Fields on `paragraph.ab_test`**: `field_variant_a` / `field_variant_b`
  (entity_reference_revisions → paragraph), `field_tracking_code_a` / `field_tracking_code_b`
  (text_long), `field_unique_id` (string, 128), `field_distribution` (list_string:
  50/50, 90/10, 10/90, 70/30, 30/70).
- **Route** (`ab_paragraphs.routing.yml`): only **`ab_paragraphs.settings.form`** →
  `/admin/config/content/ab-paragraphs`, permission `administer site configuration`.
  (`ab_paragraphs.links.menu.yml` also lists a menu link pointing at an
  `ab_paragraphs.admin_content_ab_paragraphs` route, and `src/Controller/AbLogController.php`
  exists, but **neither has a route defined** — dead/unreachable code in this release.)
- **Libraries** (`ab_paragraphs.libraries.yml`): `ab_test` (`js/ab_test.js`, front-end variant
  selection) and `trackingcode_suggestions` (`js/trackingcode_suggestions.js`, editor helper).
- **Config**: object `ab_paragraphs.settings` with one key `analytics_provider` (default
  `matomo`); schema in `config/schema/ab_paragraphs.schema.yml`.
- **No permissions.yml, no services.yml, no Drush, no composer.json.**

## After install (manual step)

Fields are created but **not placed on any display**. Enable them on
`/admin/structure/paragraphs_type/ab_test/form-display` and `.../display`; use the
Plain-text (multi-line) widget for the tracking-code fields. `hook_requirements` warns if any of
the six fields are missing.
