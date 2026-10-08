<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Block (text_block) — agent index

Provides a single block plugin (`text_block`) whose body text is stored in the block's own
**configuration**, not in a `block_content` content entity. That makes the text exportable: it
lands in `block.block.*` and travels with `drush cex` / `drush cim`. Depends on core `block`;
uses core `filter` when present (optional, soft dependency). Core requirement `^10.1 || ^11`.

No settings page (`configure` is null) — you operate it entirely by placing/configuring the block
at `/admin/structure/block` (or in Layout Builder). No routes, no permissions, no services, no
Drush of its own. It provides one block plugin and a config schema; it does not define a plugin type.

- **Place the block, set its text/format, how the text renders, set it via drush/PHP, config
  portability** → [blocks/text_block.md](blocks/text_block.md)

Key facts:
- Block plugin id `text_block` (class `Drupal\text_block\Plugin\Block\TextBlock`), admin label and
  category both "Text Block".
- Config schema `block.settings.text_block` (in `config/schema/text_block.schema.yml`): one key
  `text` of type `text_format` → stores `text.value` (string) and `text.format` (filter format id).
- With `filter` enabled the block form is a `text_format` element; the format defaults to the
  editing user's `filter_default_format()`. Without `filter`, it is a plain required `textarea`
  and the stored format is `NULL`.
- Rendering: if a format is stored and `filter` is on → `#type => processed_text` (runs
  `check_markup()` with that format); otherwise → `#markup` (core renders that through
  `Xss::filterAdmin()`).
- `calculateDependencies()` adds a config dependency on the chosen `filter_format` entity, so an
  exported block carries its format dependency.
- Editing the text is editing block configuration → the `administer blocks` permission. There is no
  per-block editorial permission; a config import overwrites any UI change on that environment.
- Packaging note: `.info.yml` reports `version: '8.x-1.4'` (legacy drupal.org string); tracked as
  1.4.x here.
