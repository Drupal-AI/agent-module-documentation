<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 block embed (ck5_block_embed) — agent index

A CKEditor 5 plugin plus a text-format filter that embed **content blocks, view blocks, and the
active theme's region blocks** into body content. Depends only on core `ckeditor5`.
Version **1.0.3** (project created 2025-01-22). Core requirement `^10 || ^11`. License
GPL-2.0-or-later. Not covered by the security advisory policy.

## What it actually does
- Registers one **CKEditor 5 plugin**, `ck5_block_embed_ck5BlockEmbed` (derived to `:default` by
  `Ck5BlockEmbedDeriver`); JS global `ck5BlockEmbed.Ck5BlockEmbed`, library
  `ck5_block_embed/ck5_block_embed` (built file `js/build/ck5BlockEmbed.js`), PHP definition
  `\Drupal\ck5_block_embed\Plugin\CKEditor5Plugin\Ck5BlockEmbed`.
- Adds one toolbar item, **`ck5BlockEmbed__default`** (label "Embed Block"). Allowed elements:
  `<ck5-block-embed>` / `<ck5-block-embed-inline>` with attributes
  `data-plugin-config data-plugin-id data-button-id`.
- The plugin has a `conditions: { filter: ck5_block_embed }` — the button only works when the
  **Embed blocks** filter (`@Filter` id `ck5_block_embed`) is also enabled on the format.
- The button opens a modal **dialog form** (`Ck5BlockEmbedDialogForm`) that lets the editor pick an
  embed type and a specific block, and inserts a placeholder element carrying `data-plugin-id` and a
  JSON `data-plugin-config`.
- At render time the **filter** (`\Drupal\ck5_block_embed\Plugin\Filter\Ck5BlockEmbed`) regex-parses
  each `<ck5-block-embed …>` tag, instantiates the named embed plugin with the decoded config, calls
  `->build()`, renders the result, and substitutes it into the output.

## The custom "embed" plugin type
This module defines its **own plugin type** (`plugin.manager.ck5_block_embed`, annotation
`@Ck5BlockEmbed`, namespace `Plugin/Ck5BlockEmbed`, interface `Ck5BlockEmbedInterface`, base
`Ck5BlockEmbedPluginBase`). Three plugins ship:
- **`content_block`** (`ContentBlock`) — config `block_id` is a `block_content` entity id;
  `build()` loads it with `BlockContent::load()` and renders via the `block_content` view builder.
- **`view_block`** (`ViewBlock`) — config `block_id` is a JSON `{view_id, display_id}`; `build()`
  does `Views::getView($view_id)->setDisplay($display_id)->render()`.
- **`theme_block`** (`ThemeBlock`) — config `block_id` is a JSON `{theme, block_id}` naming a `block`
  config entity; `build()` loads it, checks it belongs to the given theme, and renders it via the
  `block` view builder with `renderRoot()`.

Each plugin's `buildConfigurationForm()` populates the dialog's select list by loading **all**
`block_content` entities / **all** view block displays / **all** `block` entities of the active
theme — the picker is not filtered by the editor's access to those blocks.

## Routes and access (as coded)
- `ck5_block_embed.dialog` (`/ck5-block-embed/dialog/{button}/{filter_format}`) — the picker form;
  `_custom_access` = **`use ck5 block embed button`**.
- `ck5_block_embed.preview` (`/ck5-block-embed/preview/{editor}`) — renders a live preview of a
  block for the editor; `_custom_access` = permission **`use text format {format}`** only, plus
  `_csrf_token: TRUE`.
- `ck5_block_embed.ck5_block_embed_button.icon` (`/ck5-block-embed/icon/{button}`) — serves the SVG;
  `checkAccess()` returns `AccessResult::allowed()` (public, static file).

## Permission and toolbar gating
One permission, **`use ck5 block embed button`** (title "Administer embed block"). `hook_editor_js_settings_alter()`
removes the `ck5BlockEmbed__default` toolbar item from the editor settings for any user lacking it —
UI-level gating only.

## Things to keep straight
1. **Both the button and the filter are required.** The button is inert without the `ck5_block_embed`
   filter enabled on the same format (enforced by the plugin `conditions`).
2. **The reference is resolved on render**, so the embedded block/view is re-rendered on every
   display and always reflects the current block.
3. **The `<ck5-block-embed>` placeholder is a plain data-attribute element.** Its allowed-elements
   entry permits `data-plugin-id`/`data-plugin-config`, so anyone who can write raw HTML into the
   format (Source editing) can author or alter an embed by hand — the dialog is a convenience, not
   the only path.
4. **No config schema and no admin settings form** — configuration is entirely "add the button +
   enable the filter" on a text format. `provides_config_schema` is false.

## Files
- `../data.json` — metadata (categories, deps, version, plugin types).
- `../usage.md` — short / dense / use-case bullets.
- `ckeditor5/plugin.md` — the CKEditor 5 plugin, deriver, dialog form, and preview flow.
- `filters/embed-filter.md` — the `@Filter` render path and the three embed plugins in detail.
