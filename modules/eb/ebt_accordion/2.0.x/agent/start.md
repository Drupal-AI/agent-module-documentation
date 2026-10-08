<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Accordion (ebt_accordion) — agent index

Ships a custom **block type** `ebt_accordion` ("EBT Accordion/FAQ") whose body is a repeatable
Paragraph (`field_ebt_accordion` → paragraph type `ebt_accordion`, each with a formatted
Title/Question + Text/Answer). A per-block **settings widget** (`ebt_settings_accordion`, extends
`ebt_core`'s `ebt_settings_default` widget) adds accordion behaviour options (style preset,
collapsible/opened/closed, active panel, heightStyle, per-breakpoint collapse). At render, `ebt_core`
attaches those options into `drupalSettings.ebtAccordion` keyed by the block's CSS class, and
`js/jquery_ui_accordion/jquery_ui_accordion.js` initialises **jQuery UI Accordion** on the
`.ebt-accordion-wrapper` element inside the block. Because it is a block type (not a paragraph type
like the EPT family), instances are placed in regions and Layout Builder. The module itself has no
routes, no services, no controllers, no permissions and no config settings form — all shared design
config and breakpoints come from `ebt_core` (route `ebt_core.settings`).

- Depends on: `ebt_core:ebt_core`, `jquery_ui_accordion:jquery_ui_accordion`, `paragraphs:paragraphs`.
  Install-time config also pulls in `entity_reference_revisions`, `field_group`, `text`, `media`
  (via ebt_core's design widget).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Block Types`. Composer: `drupal/ebt_accordion`
  (requires `drupal/ebt_core ^2.0`, `drupal/jquery_ui_accordion ^2.0`, `drupal/paragraphs ^1.0`).
- No settings page / `configure` route, no permissions, no drush, no config schema of its own, no
  plugin types. Provides one field-widget plugin and four asset libraries.

## What you'd do → where

- **Add an accordion block, fill in Q&A sections, choose its behaviour/style** →
  [configure/accordion.md](configure/accordion.md)
- **Understand the accordion behaviour setting keys and how they map to jQuery UI options / JS** →
  [configure/accordion.md](configure/accordion.md)
- **See the content model (block type, paragraph type, fields, form/view displays, templates) or
  reference it from code** → [fields/structure.md](fields/structure.md)

## Key facts (real machine names)

- Block type (`block_content` bundle): `ebt_accordion` — add form `block/add/ebt_accordion`.
- Paragraph type: `ebt_accordion` (label "EBT Accordion section / FAQ section").
- Fields on the block: `field_ebt_accordion` (`entity_reference_revisions` → paragraph `ebt_accordion`),
  `field_ebt_settings` (`ebt_settings`, from ebt_core), plus core `body`.
- Fields on the paragraph: `field_ebt_accordion_title` (`text_long`, required),
  `field_ebt_accordion_text` (`text_long`, required).
- Field widget plugin: `ebt_settings_accordion` (`EbtSettingsAccordionWidget`, extends
  `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`) — used for `field_ebt_settings`
  on the block's default form display.
- View formatter for `field_ebt_settings`: `ebt_settings_default` (from ebt_core; emits the generated
  `styles` CSS string the templates print with `|raw`).
- Accordion setting keys (stored under `ebt_settings`): `styles`, `collapsible`, `closed`, `opened`,
  `closed_in_tablet`, `closed_in_mobile`, `active`, `disable`, `heightStyle`,
  `pass_options_to_javascript` (forced TRUE).
- Style presets (`styles`): `default`, `text_only`, `plus_minus_left`, `plus_minus_right`.
- Libraries (`ebt_accordion.libraries.yml`): `jquery_ui_accordion` (JS + base CSS + jQuery UI),
  `text_only`, `plus_minus_left`, `plus_minus_right` (preset CSS, attached conditionally).
- JS behaviour: `Drupal.behaviors.ebtAccordion`, reads `drupalSettings.ebtAccordion` and
  `drupalSettings.ebtCore.{mobile,tablet}Breakpoint`.
- Templates: `block--block-content--ebt-accordion.html.twig`,
  `block--inline-block--ebt-accordion.html.twig`,
  `field--block-content--field-ebt-accordion--ebt-accordion.html.twig` (adds `ebt-accordion-wrapper`),
  `paragraph--ebt-accordion--default.html.twig`.
- Hooks/updates: `hook_uninstall` (keeps block type on uninstall); update hooks `9101` (relabel
  paragraph type), `9102` (make title/text fields required).
