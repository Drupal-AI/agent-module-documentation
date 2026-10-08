USWDS Paragraph Components is a suite of pre-built Paragraphs bundles that render as [U.S. Web Design System](https://designsystem.digital.gov/) (USWDS) components — accordions, alerts, cards, grid columns, modals, process lists, step indicators and summary boxes. It ships the paragraph types, fields, entity displays and Twig templates so a US-government site builder can drop USWDS-styled content into any entity via a Paragraphs field.

---

The module is an umbrella project: since 2.4.x each component lives in its own submodule (`uswds_paragraph_components_accordions`, `_alerts`, `_breakpoints`, `_cards`, `_columns`, `_modal`, `_process_list`, `_step_indicator`, `_summary_box`) so site builders enable only the components they need. Each submodule installs one or more `paragraphs.paragraphs_type` bundles plus their fields, `core.entity_form_display`/`core.entity_view_display` config (all as `config/optional`, imported when both the submodule and Paragraphs are present), and a `paragraph--*.html.twig` template that emits the exact USWDS markup (`usa-accordion`, `usa-alert`, `usa-card`, `usa-step-indicator`, etc.). Most component submodules attach a small component CSS library and use `hook_preprocess_paragraph()` to attach it only in non-`preview` view modes. The base module provides a `paragraph__default` theme hook / template, a `hook_help` page rendering the README, and a Paragraphs field widget plugin `uswds_paragraph_components_paragraphs` (`UswdsParagraphsBreakpoints`, extending Paragraphs' stable widget) that pre-populates the breakpoint sub-paragraphs and adds a "Disable Breakpoints field" setting. The base module carries NO paragraph bundles itself — they all come from the submodules. Grid-aware components (cards, columns) depend on `uswds_paragraph_components_breakpoints`, which supplies a `uswds_breakpoints` taxonomy (mobile/tablet/desktop/card…), a `uswds_card_breakpoints` helper paragraph type, and a supporting view. Setup is entirely config/UI: add a Paragraphs (entity_reference_revisions) field to a content type, allow the top-level USWDS bundles, and choose the USWDS widget on *Manage form display*. There is no admin settings page (`configure` is null) and no permissions of its own — access is governed by core Paragraphs/field permissions. The rendered markup assumes the USWDS CSS/JS is loaded by your theme (e.g. `uswds_base`); the module ships only per-component CSS shims, not the full framework.

---

- Give content editors ready-made USWDS accordion, alert, card, modal, process-list, step-indicator and summary-box blocks without building paragraph types by hand.
- Build a USWDS-compliant federal/government website's body content out of standardized, accessible components.
- Add an expandable FAQ or documentation section using the USWDS accordion (bordered / multiselect options).
- Show info/warning/error/success notices with the USWDS alert component, with slim and no-icon variants.
- Lay out responsive card groups (regular or flag layout) with per-breakpoint column counts.
- Create two- or three-column responsive layouts using the USWDS grid with configurable breakpoints and gaps.
- Add a USWDS modal dialog triggered by a link or button, optionally forcing an action (no dismiss).
- Present sequential instructions as a numbered USWDS process list.
- Show progress through a multi-step flow with a USWDS step indicator (counters, centered, no-labels variants).
- Highlight key takeaways in a USWDS summary box.
- Enable only the components a site needs by installing individual submodules instead of the whole suite.
- Nest components inside columns (the column content fields accept further paragraphs).
- Reference media-library images inside cards via the shipped `image` media type and `field_card_image`.
- Turn a whole card into a clickable link with the "make card link" option.
- Alternate the media/text side of flag cards down the list with the alternating-flags toggle.
- Reuse the `uswds_breakpoints` taxonomy to define which viewport widths a card/column grid responds to.
- Apply extra USWDS utility classes to card groups via the `uswds_classes` taxonomy reference field.
- Provide a consistent, accessible component library that matches Drupal's Paragraphs authoring UX.
- Theme or override any component by copying its `paragraph--uswds-*.html.twig` into your theme.
- Extend the Paragraphs inline-entity-form widget to auto-seed breakpoint rows using the module's field widget.
- Ship USWDS content structures as installable config so multiple sites stay consistent.
- Hide the complex sub-fields editors don't need per the README guidance on the entity form displays.
- Add the USWDS component CSS shims automatically only on the front end (preview view mode is excluded).
- Combine cards and columns to build rich landing pages within a single Paragraphs field.
