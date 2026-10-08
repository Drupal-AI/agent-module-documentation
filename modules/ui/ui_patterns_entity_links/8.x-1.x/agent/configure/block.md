<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: entity-link blocks

## What you get
For every fieldable entity type and every link-template `rel` it defines, the deriver creates a block:
- ID: `link_block:<entity_type>:<rel>` (e.g. `link_block:node:canonical`, `link_block:node:delete-form`).
- Admin label: the rel humanised (e.g. "Canonical", "Edit form"); category "<Entity> entity links".
- Context: an `entity` context (+ `view_mode`).

## Use in Layout Builder
1. Edit a Layout Builder layout for the entity view display.
2. Add block → pick the "<Entity> entity links" block for the desired `rel`.
3. In the block form (UI Patterns `PatternDisplayFormTrait`):
   - **Label override** — replace the auto label text.
   - **Absolute URL** — output absolute instead of relative URLs.
   - **Pattern** — choose the UI Patterns component; map its fields to the `url` / `label` sources (source id `entity_link`).
   - Optionally set a **variant** and pattern **settings**.

## Rendering notes
- `LinkBlock::build()` resolves `$entity->toUrl($rel, ['absolute' => ...])`; on `RouteNotFoundException` it falls back to the entity type's raw link template string.
- During Layout Builder preview an entity may have no id — the URL is left empty.
- The plugin class is `@internal`; rely on the block UI, not the class API.
