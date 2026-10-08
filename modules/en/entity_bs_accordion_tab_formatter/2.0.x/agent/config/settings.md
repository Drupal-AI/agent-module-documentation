<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap version config, themes, templates & libraries

## Settings form & config object

- Form `EntityBSAccordionTabFormatterConfig` (`src/Form/EntityBSAccordionTabFormatterConfig.php`,
  extends `ConfigFormBase`, form id `entity_bs_config`).
- Route **`entity_bs_accordion_tab_formatter.entity_bs_config`** →
  `/admin/config/user-interface/entity-bs`, `_permission: 'administer site configuration'`,
  `_admin_route: TRUE` (`entity_bs_accordion_tab_formatter.routing.yml`). Menu link "Entity Bootstrap"
  under `system.admin_config_ui` (*Configuration → User interface*), weight 99
  (`entity_bs_accordion_tab_formatter.links.menu.yml`).
- Editable config: **`entity_bs_accordion_tab_formatter.settings`** (`getEditableConfigNames()`).
  Single key **`bootstrap_version`**, a `select` of `bs3` / `bs4` / `bs5`. Install default `bs4`
  (`config/install/entity_bs_accordion_tab_formatter.settings.yml`).
- **No `config/schema/`** ships — the module provides no config schema for this object.

## hook_theme + templates (`.module`)

`entity_bs_accordion_tab_formatter_theme()` registers two theme hooks, each with variables
`{ tabs, attributes }`, and sets `template` dynamically to
`<bootstrap_version>/entity-bs-tab-formatter` and `<bootstrap_version>/entity-bs-accordion-formatter`:

- `entity_bs_tab_formatter`
- `entity_bs_accordion_formatter`

So the actual Twig chosen depends on the configured version, one of:
`templates/bs3/`, `templates/bs4/`, `templates/bs5/` — each holds
`entity-bs-tab-formatter.html.twig` and `entity-bs-accordion-formatter.html.twig`. The templates loop
`tabs` and emit Bootstrap-version-specific markup: BS3 tab uses `<a>` toggles + `nav-tabs responsive`;
BS4 accordion uses `card`/`card-header`; BS5 uses `accordion-item`/`accordion-button`/`nav-link` and a
responsive tab-collapses-to-accordion layout. Titles are output as `{{ fieldname.title }}` (Twig
autoescaped); bodies as `{{ fieldname.body }}` (already-built render arrays).

`template_preprocess_entity_bs_tab_formatter()` walks `tabs[*].content` and, for each key that is a
field on the content entity, sets `tabs[*].fields[<field>] = content->{field}->view()`.
`template_preprocess_entity_bs_accordion_formatter()` simply delegates to the tab preprocessor.
`entity_bs_accordion_tab_formatter_help()` provides the module help text.

## Libraries (`entity_bs_accordion_tab_formatter.libraries.yml`)

- `bootstrap-responsive-tabs` — external JS `/libraries/bootstrap-responsive-tabs/js/responsive-tabs.js`
  (MIT). Attached only for **BS3 tabs**.
- `tabs` — module JS `js/entity_bs_accordion_tab_formatter.tabs.js` + component CSS, depends on
  `core/drupalSettings`, `core/jquery.once`. Attached for BS3 and BS5 tabs.

Bootstrap itself (CSS/JS) is expected from the site theme — it is **not** bundled.

## Requirements check (`.install`)

`hook_requirements()` checks for `libraries/bootstrap-responsive-tabs/js/responsive-tabs.js` in the
site root and then in the install-profile `libraries/` dir; if absent it emits a
`REQUIREMENT_INFO` notice telling you to download the Bootstrap Responsive Tabs library (needed for
Bootstrap 3 tabs). This is informational only, not a hard install blocker.

## Operate

1. Set the Bootstrap version at `/admin/config/user-interface/entity-bs` to match your theme's
   Bootstrap (default `bs4`).
2. For BS3 tabs, place the Bootstrap Responsive Tabs library under `/libraries/`.
3. Configure the formatter per reference display — see [../fields/formatter.md](../fields/formatter.md).
