# Setup & configuration

No global settings page (`configure` is null) and no module permissions. All configuration is
per-field / per-form-display, plus choosing which component submodules to enable.

## 1. Enable the components you want

Each submodule installs its own paragraph bundle(s) + fields + displays + template as
`config/optional` (imported only when the submodule AND `paragraphs` are enabled):

```
drush en uswds_paragraph_components_accordions uswds_paragraph_components_alerts \
  uswds_paragraph_components_cards uswds_paragraph_components_columns \
  uswds_paragraph_components_modal uswds_paragraph_components_process_list \
  uswds_paragraph_components_step_indicator uswds_paragraph_components_summary_box -y
```

`_cards` and `_columns` auto-require `uswds_paragraph_components_breakpoints` (the grid helper —
supplies the `uswds_breakpoints` taxonomy + `uswds_card_breakpoints` type + a view). The base
`uswds_paragraph_components` module ships NO bundles; it only provides the base template, the field
widget and the help page.

## 2. Add a Paragraphs field to a content type

- On a content type: *Manage fields → Add field → Reference revisions → Paragraphs*
  (field type `entity_reference_revisions`, target type `paragraph`). Set cardinality unlimited so
  editors can stack multiple components.
- On the field settings, allow the **top-level** bundles only:
  `uswds_accordion`, `uswds_alert`, `uswds_card_group_regular`, `uswds_card_group_flag`,
  `uswds_2_columns`, `uswds_3_columns`, `uswds_modal`, `uswds_process_list`,
  `uswds_step_indicator_list`, `uswds_summary_box`.
- **Do NOT allow** the sub-bundles used inside a parent (they do nothing on their own):
  `uswds_accordion_section`, `uswds_card_regular`, `uswds_cards_flag`, `uswds_process_item`,
  `uswds_step_indicator_item`, `uswds_*_column_breakpoints`, `uswds_card_breakpoints`, `text_field`.

## 3. Choose the USWDS widget (optional but recommended for grids)

On *Manage form display* of the field, pick the widget **"Extended Paragraphs (stable) - USWDS
Breakpoints"** (plugin id `uswds_paragraph_components_paragraphs`, class `UswdsParagraphsBreakpoints`).
It extends the stable Paragraphs widget and:

- Pre-seeds one breakpoint sub-paragraph row per enabled `uswds_breakpoints` taxonomy term (via
  `formMultipleElements()` + the breakpoints submodule's `field_widget_..._form_alter`), so grid
  components come pre-filled with the site's breakpoints.
- Adds a **`disable_breakpoints`** widget setting (checkbox "Disable Breakpoints field"). When on,
  the `field_uswds_breakpoints` widget inside card/column breakpoint rows is rendered `#disabled`.
- Widget-settings schema: `field.widget.settings.uswds_paragraph_components_paragraphs` (see
  `config/schema/uswds_paragraph_components.schema.yml`) — it is the core Paragraphs widget settings
  plus the `disable_breakpoints` boolean.

## 4. Front-end requirements

The templates emit raw USWDS class names (`usa-card`, `usa-accordion`, …). The full USWDS CSS/JS must
be provided by your theme — the module only ships small per-component CSS shims (see
[../theming/templates.md](../theming/templates.md)). The recommended theme is
[`uswds_base`](https://www.drupal.org/project/uswds_base).

## Notes

- The README's "Reset bundles" tool at `/admin/config/content/uswds_paragraph_components` is documented
  as **currently broken** and there is no routing entry for it in 3.1.x — treat it as absent.
- Per-editor simplification: the shipped `entity_form_display`s expose every sub-field; the README
  suggests hiding fields editors don't need on *Manage form display* of each bundle.
