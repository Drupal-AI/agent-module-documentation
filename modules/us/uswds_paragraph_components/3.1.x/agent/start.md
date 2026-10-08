# USWDS Paragraph Components — agent index

Umbrella project shipping USWDS-styled **Paragraphs bundles**. The base module has NO bundles of
its own — every component is a submodule you enable individually. No admin settings page
(`configure` null), no permissions of its own, no Drush. Depends on `paragraphs`,
`entity_reference_revisions`, `field_group`, `twig_tweak`, `viewsreference`. Rendered markup expects
the USWDS CSS/JS to be loaded by your theme (e.g. `uswds_base`).

- **Install components, add the Paragraphs field, pick the USWDS widget, which bundles to expose** →
  [configure/setup.md](configure/setup.md)
- **Templates, theme hooks, per-component CSS libraries, how to override markup** →
  [theming/templates.md](theming/templates.md)

Submodules (own docs — each installs paragraph type(s) + fields + displays + a Twig template):
- Accordions → [../../modules/uswds_paragraph_components_accordions/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_accordions/3.1.x/agent/start.md)
- Alerts → [../../modules/uswds_paragraph_components_alerts/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_alerts/3.1.x/agent/start.md)
- Breakpoints (grid helper) → [../../modules/uswds_paragraph_components_breakpoints/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_breakpoints/3.1.x/agent/start.md)
- Cards → [../../modules/uswds_paragraph_components_cards/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_cards/3.1.x/agent/start.md)
- Columns → [../../modules/uswds_paragraph_components_columns/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_columns/3.1.x/agent/start.md)
- Modal → [../../modules/uswds_paragraph_components_modal/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_modal/3.1.x/agent/start.md)
- Process List → [../../modules/uswds_paragraph_components_process_list/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_process_list/3.1.x/agent/start.md)
- Step Indicator → [../../modules/uswds_paragraph_components_step_indicator/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_step_indicator/3.1.x/agent/start.md)
- Summary Box → [../../modules/uswds_paragraph_components_summary_box/3.1.x/agent/start.md](../../modules/uswds_paragraph_components_summary_box/3.1.x/agent/start.md)

Key facts:
- Enabled submodule → paragraph bundle(s). Top-level bundles you expose on a field:
  `uswds_accordion`, `uswds_alert`, `uswds_card_group_regular`, `uswds_card_group_flag`,
  `uswds_2_columns`, `uswds_3_columns`, `uswds_modal`, `uswds_process_list`,
  `uswds_step_indicator_list`, `uswds_summary_box`.
- **Do NOT expose the sub-bundles** on the field (they are children of the above): `uswds_accordion_section`,
  `uswds_card_regular`, `uswds_cards_flag`, `uswds_process_item`, `uswds_step_indicator_item`,
  `uswds_2_column_breakpoints`, `uswds_3_column_breakpoints`, `uswds_card_breakpoints`, `text_field`.
- Field widget plugin `uswds_paragraph_components_paragraphs` (label "Extended Paragraphs (stable) -
  USWDS Breakpoints", class `UswdsParagraphsBreakpoints extends ParagraphsWidget`) seeds breakpoint rows
  and adds a `disable_breakpoints` setting. Schema key `field.widget.settings.uswds_paragraph_components_paragraphs`.
- Base module: `hook_theme` → `paragraph__default` (template `templates/paragraph--default.html.twig`);
  `hook_help` renders the README. Hooks live in `src/Hook/UswdsParagraphComponentsHooks.php`.
- README notes the "Reset bundles" feature at `/admin/config/content/uswds_paragraph_components` is
  currently broken; there is no routing.yml for it in 3.1.x.
