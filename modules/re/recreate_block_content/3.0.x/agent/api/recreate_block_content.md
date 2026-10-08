<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recreate Block Content — mechanism & API

The whole module is two procedural functions in `recreate_block_content.module`, wired to
two hooks. There is **no** service, config, route, permission, or Drush command of its own.

## What triggers it

- `hook_install()` (`recreate_block_content.install`) → calls `recreate_block_content_rebuild()`
  once, right after `drush en recreate_block_content` / enabling the module.
- `hook_rebuild()` (`recreate_block_content.module`) → Drupal core fires this on **every cache
  rebuild**. So to recreate blocks at any later time you just clear caches:
  - `drush cr`
  - Admin → Configuration → Development → Performance → **Clear all caches**

No dedicated command or URL exists — cache rebuild is the trigger.

## `recreate_block_content_rebuild()`

1. Gets the `config.manager` service and calls `findMissingContentDependencies()` — the set of
   content entities that installed config depends on but that don't exist on this site.
2. Loads all block types via `BlockContentType::loadMultiple()`.
3. For each missing dependency where `entity_type == 'block_content'`:
   - If the referenced `bundle` (block type) **exists**, creates and saves a placeholder:
     ```php
     $block_content = \Drupal\block_content\Entity\BlockContent::create([
       'type' => $content['bundle'],
       'info' => recreate_block_content_title($content),
       'uuid' => $content['uuid'],
     ]);
     $block_content->save();
     ```
     Then adds a success message (messenger) and logs it at `LogLevel::INFO`.
   - If the bundle **does not exist**, it creates nothing; it adds a failure message and logs at
     `LogLevel::ALERT` ("the block type @bundle doesn't exists").

The new block is an **empty placeholder** — only `type`, `uuid`, and `info` are set. Body/field
content is left for an editor to fill in. The preserved `uuid` is what makes the imported config
placement resolve correctly.

## `recreate_block_content_title($content)` — title resolution

Builds the `info` label for the placeholder, in this order of preference:

1. **`block` config** using the block → its `settings.label` (highest preference).
2. **`page_manager`** variant → the matching block's `label` (found by UUID in
   `variant_settings.blocks`). Used only if no plain `block` label was found.
3. Fallback: the **first config dependency name** returned by
   `config.manager->findConfigEntityDependencies('content', [ "<entity_type>:<bundle>:<uuid>" ])`.

This is why placements from core Block layout and Panels/Page Manager yield human-readable
placeholder titles, while other providers fall back to the raw dependency name.

## Scope / limitations

- Only handles `block_content`; other missing content dependencies are ignored.
- Works with any module that declares a config **dependency** on a block (core Block layout,
  Panels, Page Manager). **Not** Panelizer — it adds no block dependency.
- Does not export or copy block *content*; for that the README suggests Fixed block content,
  Simple block, or Deploy.
- If a block's bundle is missing on the target site, that block is skipped (and an ALERT logged).

## Verifying a run

Recreated/failed blocks are reported on-screen and to the logger channel
`recreate_block_content`:

```
drush watchdog:show --type=recreate_block_content
```
