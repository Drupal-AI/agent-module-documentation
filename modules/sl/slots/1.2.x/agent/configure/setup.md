<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Slots

## Prerequisites
Requires `block_plugin_view_builder`, `conditions` (conditions_field submodule) and `dynamic_entity_reference`. Enable the submodule that matches your integration: `slots_paragraphs`, `slots_views`, or `slots_twig`.

## 1. Place a slot
Give each slot an **identifier** (reusable, not required to be unique) and a **cardinality** (max blocks rendered). Place it via:
- **Block UI** — add the "Slot block" block to a region.
- **Layout Builder** — use the injected **"+ Add slot"** create link (added by `ControllerAlterSubscriber` on the choose-block screen).
- **Views** — add a "Slot" to the view header or footer.
- **Paragraphs** — via `slots_paragraphs`.
- **Twig** — `{{ slot(slot_id, cardinality) }}` via `slots_twig`.

Render the slot in the browser at least once so it is registered.

## 2. Add the slot field to a block type
At `/admin/structure/block-content`, on the target block type → **Manage fields**, add a field of type **Slots**.

## 3. Create slot content
At `/admin/content/block` → **Add content block**:
1. Fill in the block fields.
2. In the **Slots** fieldset, check "This content shall be displayed in slots".
3. Configure **conditions**, including a **Slot** condition whose identifier matches the slot you placed.
4. Save — the block now renders in matching slots.

`SlotsService` evaluates the configured conditions against the current request context, loads matching blocks and renders them through `block_plugin.view_builder`, caching in `cache.default`.

## Permissions
- `administer slots` (restricted) — manage `Slot` entities at `/admin/content/slots`.
- `access slot library` — the slot overview page.
- `view slot identifiers` — surfaces where slots exist and interaction methods.
- `create slots` — create slot IDs from UI integrations (checked in `Element\SlotSelector`).
