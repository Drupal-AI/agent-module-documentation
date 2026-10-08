<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Mode Selector — field configuration & rendering

## Add and configure the field
1. On a bundle's *Manage fields*, add a field of type **View Mode Selector** (`view_mode_selector`).
2. In field settings, the form lists every view mode available for the bundle. For each:
   - **enable** — include it as a selectable option (if none enabled, all are shown).
   - **hide_title** — hide the mode label in the widget.
   - **icon** — managed_file upload used by the Icons widget (stored at `public://view-mode-selector/<entity_type>`).
3. On *Manage form display*, pick a widget:
   - `view_mode_selector_select` — Select list
   - `view_mode_selector_radios` — Radio buttons (default)
   - `view_mode_selector_icons` — Icons (renders uploaded images as radio labels; attaches `view_mode_selector/widget_styles`)

## Make the selection take effect
The stored value only matters when the entity is rendered with the **`view_mode_selector`** view mode. The module auto-creates that placeholder view mode for each entity type that has the field (`hook_entity_view_mode_info_alter`). Render the entity with it via:
- an entity/reference field formatter set to the "View mode selector" mode,
- a Views row/entity display using that mode, or
- any `->view($entity, 'view_mode_selector')` call.

`hook_entity_view_mode_alter()` then replaces the mode with the editor's stored value (or `default` if empty). The placeholder's own *Manage display* screen is intentionally disabled with a notice — it never renders directly.

## Formatter
The default formatter (`view_mode_selector`) extends core `text_default` and simply prints the stored view mode name.

## Troubleshooting
If the mode does not change, another module's `hook_entity_view_mode_alter` may run later and override it — audit those implementations.
