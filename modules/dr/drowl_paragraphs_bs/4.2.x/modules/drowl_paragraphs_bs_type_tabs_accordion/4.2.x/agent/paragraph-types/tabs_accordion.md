<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Tabs & Accordion' paragraph type (drowl_paragraphs_bs_type_tabs_accordion)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_tabs_accordion -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `fences:fences`, `micon:micon`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

container: `field_paragraphs` (nested paragraphs), `field_settings`. subtab: `field_title`, `field_icon`, `field_anchor_id`, `field_paragraphs`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_tabs_accordion_preprocess_paragraph()` (bundle `container_tabs_accordion`) reads UI-Styles classes into Twig variables: `tabs-acc__type-*` -> `tabs_acc_type` (tabs/accordion), `tabs-acc__init-state-*` -> `tabs_acc_init_state`, `tabs-acc__multiple-open` -> `tabs_acc_allow_multiple_open`, `tabs-acc__tabs-style-*` -> `tabs_acc_tabs_style`, `tabs-acc__accordion-style-*` -> `tabs_acc_accordion_style`.

## Templates

`paragraph--drowl-paragraphs-bs--container-tabs-accordion.html.twig` builds either a Bootstrap `.nav`/`.tab-content` (buttons with `data-bs-toggle="tab"`) or an `.accordion` (buttons with `data-bs-toggle="collapse"`), pulling each child's title/icon/anchor id with `drupal_field`/`drupal_entity` and using `paragraph.id()` for wrapper ids. The subtab template (`...--container-tabs-accordion-subtab.html.twig`) simply prints its children without the title/icon fields (`content|without('field_title', 'field_icon')`).

## UI Styles

`drowl_paragraphs_bs_type_tabs_accordion.ui_styles.yml` defines type, initial state, multiple-open, tabs style and accordion style.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
