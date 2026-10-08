<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content callback provides a **field type whose stored value is a plugin id** (a "content callback"). When the
field is displayed, the selected plugin runs and renders dynamic content into the entity — letting editors
choose from a curated list of developer-provided callbacks per field.

Use it to let editors drop pre-built dynamic content (a widget, a computed listing, a formatted snippet) into a
node/entity without exposing arbitrary code. Callbacks are defined as annotated **ContentCallback plugins**;
submodules add block and Views integrations.
---
- Requires core `field` and `options`; enable with `ddev drush en content_callback`.
- Add a **Content callback** field to an entity bundle; the widget shows a select of available plugins.
- Developers define callbacks by implementing the `@ContentCallback` plugin (extend `PluginBase`).
- The formatter renders the chosen plugin's output at display time.
- Optional submodules: `content_callback_block` (place callbacks as blocks) and `content_callback_views`.
- The `content_callback_examples` submodule shows Basic/Options/Alter/Filter patterns.
---
- Let editors pick a dynamic content callback per field.
- Render developer-defined dynamic content inside entities.
- Constrain choices to a safe, curated plugin list (no arbitrary code entry).
- Provide options/config per callback via the plugin.
- Expose callbacks as placeable blocks (block submodule).
- Integrate callbacks with Views (views submodule).
- Reuse one callback across many entities.
- Keep rendering logic in code (plugins), selection in content.
- Alter available options via the provided hook/alter.
- Filter which callbacks apply to which entity types.
- Ship example plugins to copy from.
- Use for widgets, computed listings, or snippets.
- Format callback output via the field formatter.
- Support D9/D10 sites.
- Avoid custom field code for dynamic content slots.
- Deploy field + plugin config normally.
