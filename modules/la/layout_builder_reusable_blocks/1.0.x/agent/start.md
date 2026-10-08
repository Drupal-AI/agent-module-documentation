<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Reusable Blocks (layout_builder_reusable_blocks) — agent index

Create **reusable** `block_content` blocks from inside Layout Builder (and optionally edit shared
ones in place), without going to `/admin/content/block`. Version **1.0.3**. Core `^10 || ^11`.
Depends on core **`layout_builder`** and **`block_content`**. License GPL-2.0-or-later.
No Drush, no services file, no config schema, no submodules, no library. All behaviour is in one
`.module` file plus two classes.

## What it provides

- **Add-block workflow alter** — `hook_form_layout_builder_add_block_alter` turns the custom-inline
  add form into a two-step choice (inline vs reusable), or auto-creates reusable when configured.
  → [api/add-block-workflow.md](api/add-block-workflow.md)
- **Promote-on-save** — the reusable submit handler flips the just-created block with
  `setReusable(TRUE)` and rewires the placed component to `block_content:<uuid>`.
  → [api/promote-to-reusable.md](api/promote-to-reusable.md)
- **Block plugin** `LayoutBuilderReusableContentBlock` (`src/Plugin/Block/`), extends core
  `BlockContentBlock`; when the admin enables it, embeds the block edit form inline in Layout
  Builder with an optional warning. → [plugins/reusable-content-block.md](plugins/reusable-content-block.md)
- **Global block override** — `hook_block_alter` reassigns the `class` of **every**
  `block_content:*` block derivative to the plugin above. → [api/block-alter.md](api/block-alter.md)
- **Settings form** `LayoutBuilderReusableBlocksConfigForm` writing config
  `layout_builder_reusable_blocks.settings` (4 keys). → [config/settings.md](config/settings.md)
- **Routes / permission / menu link** (one of each). → [reference/routes-permissions.md](reference/routes-permissions.md)
- **README-vs-code behaviour notes** (what the README promises that the code does *not* ship).
  → [reference/behavior-notes.md](reference/behavior-notes.md)

## Route & permission

- Route `layout_builder_reusable_blocks.settings` → `/admin/config/user-interface/layout-builder-reusable-blocks`,
  `_form: LayoutBuilderReusableBlocksConfigForm`, requirement
  `_permission: 'administer layout builder reusable blocks'`.
- Permission `administer layout builder reusable blocks` — **`restrict access: true`**; governs the
  module's *settings only*. Creating/promoting/editing blocks follows Layout Builder + block_content
  access, not this permission.

## Config keys (`layout_builder_reusable_blocks.settings`, all set only via the form)

`show_warning` (default TRUE), `warning_text` (default provided), `allow_editing_reusable_blocks`
(default **FALSE**), `make_all_blocks_reusable` (default FALSE). No `config/install` or
`config/schema` ship — defaults come from `?? …` fallbacks in code.

**Operational caveat to surface when recommending this:** editing a reusable block from one page
changes it on every page that uses it. In-place editing is off by default; enabling it removes the
normal reason to visit the library. Pair with a visual inline-vs-reusable distinction and a
deliberate decision about who edits shared blocks.
