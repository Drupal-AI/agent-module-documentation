<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Moderation state columns Views style

## Build the View
1. Create a View of moderated entities (e.g. Content) using **fields** or **entity** row style (`usesRowPlugin = TRUE`).
2. Set the display **Format** to **Moderation state columns**.
3. In the format settings choose a **Workflow** (required). Changing it triggers an AJAX reload of the state list (`ModerationStateColumns::updateStates`).
4. Select one or more **States** to display as columns. Note the settings help: you should still add the moderation-state filter/fields to the View — the style only chooses which state columns to render.

## How rows are bucketed
`template_preprocess_views_view_moderation_state_columns()`:
- Loads the chosen `Workflow`.
- For each result row, locates the moderated entity (direct `EntityInterface` or `ResultRow->_entity`) and skips rows whose entity is not managed by the chosen workflow or whose state is not selected.
- Renders the row and stores markup under `entities[state][]`.
- Emits `json_encoded_content` = `{states, entities}` for the `view_display` JS to render.
- Merges workflow + entity cache tags into `#cache['tags']`.

## Notes
- `getWorkflowStatesOptions()` sorts states by weight and returns `id => label`.
- No permissions to configure; gate visibility via the View's access settings.
