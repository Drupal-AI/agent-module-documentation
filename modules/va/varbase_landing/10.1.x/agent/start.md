<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Landing Page (varbase_landing) — agent index

A **Varbase** feature that installs a **"Landing page (Paragraphs)"** content type (`landing_page`)
whose body is a stacked list of Bootstrap Paragraph components. All of it is delivered by an
install-time **recipe** (`recipes/default`, run from `hook_install()`); the module ships **no routes,
permissions, services, or plugins** and only two hook implementations. Pinned to core `~11.4.0`.

The runtime code, in full: `src/Hook/VarbaseLandingHooks.php` attaches the
`varbase_bootstrap_paragraphs/vbp-default-admin` library to the `landing_page` add/edit forms
(`form_node_landing_page_form_alter`, `form_node_landing_page_edit_form_alter`). Everything else is
config in `recipes/default/config/`.

Dependencies (info file): `varbase_bootstrap_paragraphs` + its `vbp_text_and_image` submodule, and
`varbase_seo`. Composer additionally pulls `varbase_media ~10.1.0`, `paragraphs_features ~2`,
`paragraphs_asymmetric_translation_widgets ~1`, `length_indicator ~1`, `advanced_text_formatter ~3`,
`maxlength ~3`, plus Vardot tooling:
- **`vardot/module-installer-factory ~1`** — install-time module enabling helper;
- **`vardot/varbase-patches ~10.1.0`** — a composer **plugin** that must be in
  `config.allow-plugins` or `composer require` aborts.

## What you'd do → where

- **Understand the content type, its fields, form/view displays, and the pathauto / metatag /
  rabbit-hole / translation behaviours the recipe installs** →
  [configure/varbase_landing.md](configure/varbase_landing.md)
- **Who can create/edit/delete landing pages — the role grants the recipe applies** →
  [permissions/varbase_landing.md](permissions/varbase_landing.md)

## Key facts (real machine names)

- Content type: `landing_page` — "Landing page (Paragraphs)", `new_revision: true`,
  `preview_mode: 1`, `display_submitted: false`; menu_ui third-party settings expose the `main` menu.
- Body field: `field_lp_paragraphs` (label "Components") — `entity_reference_revisions`,
  cardinality `-1`, translatable, target `paragraph`, allowed bundles: `bp_accordion`, `bp_block`,
  `bp_carousel`, `bp_columns`, `bp_columns_three_uneven`, `bp_columns_two_uneven`, `bp_image`,
  `bp_modal`, `bp_simple`, `bp_tabs`, `bp_view`, `bp_webform`, `from_library`, `text_and_image`
  (all from `varbase_bootstrap_paragraphs`). Widget: `paragraphs_previewer` (add_mode modal,
  closed/preview), with `paragraphs_features` add-in-between / duplicate / split-text /
  delete-confirmation.
- Other fields: `field_description` (string_long, textarea, maxlength_js 160), `field_meta_tags`
  (metatag firehose), `field_yoast_seo` (yoast real-time SEO widget, body=field_description), core
  `path` + `menu_link`. Title widget carries `length_indicator` (optimin 15 / optimax 50 / tol 10).
- View display: only `field_lp_paragraphs` shown
  (`entity_reference_revisions_entity_view`, label hidden); description/meta/yoast/langcode/links hidden.
- Recipe also installs: pathauto pattern `hierarchical_paths_for_landing_pages`
  (`[node:menu-link:parents:join-path]/[node:title]`), metatag defaults `node__landing_page`,
  rabbit_hole `display_page`, content_translation enabled with asymmetric paragraph translation.
- The paragraph **components themselves** are defined in `varbase_bootstrap_paragraphs` — debug
  component markup/behaviour there, not here.
- Not documented live: the `landing_page` type requires the `bp_*` paragraph bundles to be present
  before the recipe's field config imports cleanly. Docs written from source config.
