<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ebt_columns` block type (install, fields, displays)

## Install & enable

```bash
composer require drupal/ebt_columns   # pulls drupal/ebt_core:^2.0 and drupal/block_field:^1.0
drush en ebt_columns -y
```

Enabling runs the `config/install/` set below. `ebt_core` also expects the Media module with a
Media Image type present before install (used for EBT background images) — see the README.

There is **no settings form** for this module (`configure` is null). All configuration is per block
instance. It defines no permissions and no routes of its own; who may create/edit/place these
blocks is governed by core Block Content and Block Field permissions.

## What gets installed (`config/install/`)

- `block_content.type.ebt_columns.yml` — the bundle **`ebt_columns`**, label "EBT Columns /
  Container", `revision: 0`.
- `field.storage.block_content.field_ebt_columns_blocks.yml` — field storage, type **`block_field`**,
  `cardinality: -1` (unlimited), `translatable: true`.
- `field.field.block_content.ebt_columns.field_ebt_columns_blocks.yml` — the "Blocks" field.
  `settings.selection: categories` with a large allow-list of block-plugin categories (Block,
  Content block, Inline blocks, Lists (Views), Menus, System, User, Webform, etc.) — this scopes
  which block plugins an editor can pick per column.
- `field.field.block_content.ebt_columns.field_ebt_settings.yml` — the "Block settings" field, type
  **`ebt_settings`** (field type from ebt_core). No storage file ships here; the storage is
  provided by ebt_core.
- `field.field.block_content.ebt_columns.body.yml` — a standard `text_with_summary` **Body** field
  (`display_summary: false`), relying on core's shared `field.storage.block_content.body`.
- `core.entity_form_display.block_content.ebt_columns.default.yml` — the edit form (see below).
- `core.entity_view_display.block_content.ebt_columns.default.yml` — the render display (see below).

## Form display (edit form)

Uses **field_group** (a `third_party_settings` dependency) to build a tabbed UI:

- `group_tabs` (format `tabs`) containing:
  - **Content** tab (`group_content`, open): `info` (string_textfield), `body`
    (text_textarea_with_summary), `field_ebt_columns_blocks` (widget **`block_field_default`**,
    `configuration_form: full`).
  - **Settings** tab (`group_settings`, closed): `field_ebt_settings` using this module's widget
    **`ebt_settings_columns`** (see [../fields/widget.md](../fields/widget.md)).

Module deps declared by this form display: `block_field`, `ebt_columns`, `field_group`, `text`.
(field_group is required for the form display to import cleanly.)

## View display (render)

- `body` → `text_default` (label hidden).
- `field_ebt_columns_blocks` → formatter **`block_field`** (label hidden) — renders each referenced
  block plugin.
- `field_ebt_settings` → formatter **`ebt_settings_default`** (from ebt_core) — this is what builds
  the `styles` variable printed by the templates.

## Operating notes

- Place the block via **Structure → Block layout → Add block → Columns / Container**, or add it as
  an inline/reusable block in **Layout Builder**.
- README troubleshooting: if the **Field Layout** module is on, it may force Layout Builder onto the
  new bundle; disable Layout Builder for the bundle's display at
  `/admin/structure/block/block-content/manage/ebt_columns/display/default` so the fields render
  through these Twig templates.
- Site-wide EBT defaults (primary/secondary colours, breakpoints) live in **ebt_core**'s form at
  *Configuration → Content authoring → Extra Block Types (EBT) settings*, not here.
