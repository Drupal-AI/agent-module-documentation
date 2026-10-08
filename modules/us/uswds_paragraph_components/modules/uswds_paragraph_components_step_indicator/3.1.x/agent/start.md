# USWDS Step Indicator — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Installs a USWDS step
indicator paragraph type. No settings page, no permissions. Hooks in
`src/Hook/UswdsParagraphComponentsStepIndicatorHooks.php`.

## Paragraph types & fields (config/optional)

- **`uswds_step_indicator_list`** (container, expose this):
  - `field_step_indicator_items` — nested Paragraphs of `uswds_step_indicator_item`.
  - `field_header` — heading text (`usa-step-indicator__heading-text`).
  - `field_centered` (bool) → `usa-step-indicator--center`.
  - `field_counters` (bool) → `usa-step-indicator--counters`.
  - `field_small_counters` (bool) → `usa-step-indicator--counters-sm`.
  - `field_no_labels` (bool) → `usa-step-indicator--no-labels`.
- **`uswds_step_indicator_item`** (child, do NOT expose): `field_item_title`, `field_current` (bool).

## Rendering & assets

Theme hook `paragraph__uswds_step_indicator_list` →
`templates/paragraph--uswds-step-indicator-list.html.twig`. It first finds the item whose
`field_current == 1` (its loop index = current step), then renders each item as a
`usa-step-indicator__segment` with `--complete` (index < current), `--current` (`aria-current="true"`),
or neither, plus screen-reader "completed/not completed" text; the header shows "Step {current} of
{total}". CSS shim `uswds_paragraph_components_step_indicator/uswds-step-indicator-list` attached when
`view_mode !== 'preview'`.
