<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Bootstrap Accordion Tab Formatter (entity_bs_accordion_tab_formatter) — agent index

A single **field formatter** that renders the targets of an **entity-reference** field as **Bootstrap
accordion panels or tabs**. Package `Entity`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version-dir 2.0.x (installed release 2.0.11). No composer.json, **no module dependencies**, no config
schema, no permissions, no Drush, no submodules.

- **The formatter — plugin id, every setting, the referenced-entity render path, view-mode ordering** →
  [fields/formatter.md](fields/formatter.md)
- **Site-wide Bootstrap-version config form, the `hook_theme` templates, libraries & JS** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `EntityBSAccordionTabFormatter` (id **`entity_bs_accordion_tab_formatter`**, label
  *"Entity Bootstrap Accordion Tab formatter"*), in
  `src/Plugin/Field/FieldFormatter/EntityBSAccordionTabFormatter.php`, extending core `FormatterBase`.
  `field_types = { entity_reference, entity_reference_revisions }` — so it also covers **Paragraphs**.
- One config form: `EntityBSAccordionTabFormatterConfig` (`ConfigFormBase`) at route
  **`entity_bs_accordion_tab_formatter.entity_bs_config`** (`/admin/config/user-interface/entity-bs`,
  `_permission: administer site configuration`), writing config object
  **`entity_bs_accordion_tab_formatter.settings`** key `bootstrap_version` (`bs3`/`bs4`/`bs5`, install
  default `bs4`). Menu link under *Configuration → User interface*.
- `entity_bs_accordion_tab_formatter.module` declares two themes via `hook_theme()`
  (`entity_bs_tab_formatter`, `entity_bs_accordion_formatter`), whose `template` path is chosen at
  runtime from `bootstrap_version` (`bs3/`, `bs4/`, `bs5/` template dirs), plus two
  `template_preprocess_*` hooks and `hook_help`. `.install` `hook_requirements()` warns if the
  Bootstrap Responsive Tabs library is missing (BS3 tabs only).

## Mechanism (from source)

- `viewElements()` reads `bootstrap_version` from config, then iterates the reference items. The
  **style** (`accordion` / `accordion_closed` / `tab`) and an optional **title_level** come from
  fields on the **host/parent** entity (`$items->getParent()`), selected in the formatter settings.
- For each item it resolves the target: revisions via `loadRevision()`; otherwise
  `entityTypeManager->getStorage($target_type)->loadByProperties()` (adding `status => 1` unless the
  user has `view unpublished <type> entities`). It then reads the configured **title** field value and
  builds the **body** from the configured body field(s) — text fields with a `format` render as
  `#type => processed_text`, others via `FieldItemList::view($view_mode)`. Body field order can follow
  a chosen view mode's component weights.
- Each panel becomes a `tabs[$id]` array (id, header/body attributes tuned per BS3/4/5, title, body,
  content entity, title_level). `viewElements()` returns one `#theme => entity_bs_(tab|accordion)_formatter`
  element; `template_preprocess_entity_bs_tab_formatter()` additionally renders any per-item fields.
  For BS3/BS5 tabs it `#attached`es the module's `tabs` (and BS3 `bootstrap-responsive-tabs`) library.
