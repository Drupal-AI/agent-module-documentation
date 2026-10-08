<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX Block config entity + HTMX Loader block

Two pieces work together to lazy-load a block over HTMX:

1. an **HTMX Block** (`htmx_block` config entity) — a stored block definition, and
2. an **HTMX Loader** block plugin (`htmx_loader`) — placed in a region, it swaps itself for the
   HTMX block when a chosen event fires.

## HTMX Block config entity (`htmx_block`)

- Managed at **`/admin/structure/htmx-block`** (route `entity.htmx_block.collection`, appears
  under *Structure → Block layout → HTMX*). Add/edit/delete forms live under `/htmx/blocks/*`
  (rendered inside an off-canvas `<dialog>`).
- Permission: **`administer htmx_block`** (the entity's `admin_permission`).
- Config name `htmx.htmx_block.<id>`; `config_export` keys: `id`, `label`, `provider`, `plugin`,
  `settings`, `visibility`. `plugin` is a core Block plugin id (schema-constrained by
  `PluginExists` against `plugin.manager.block`); `settings` is that plugin's
  `block.settings.<plugin>`; `visibility` is a sequence of condition plugins.
- It reuses core's `Drupal\block\BlockAccessControlHandler` as its access handler, and core's
  `BlockPluginCollection` / `ConditionPluginCollection` for the wrapped plugin and its visibility
  conditions. Render URL: `/htmx/blocks/view/{block}` (`htmx_blocks.view`, `_htmx_route: true`,
  permission `access content`).

Scriptable:

```php
use Drupal\htmx\Entity\HtmxBlock;
HtmxBlock::create([
  'id' => 'my_promo',
  'label' => 'Promo',
  'plugin' => 'system_powered_by_block',
  'settings' => ['id' => 'system_powered_by_block', 'label' => 'Powered by Drupal', 'provider' => 'system', 'label_display' => 'visible'],
  'visibility' => [],
])->save();
```

Read back: `drush cget htmx.htmx_block.my_promo plugin`.

## HTMX Loader block (`htmx_loader`)

A core Block plugin (admin label "HTMX Loader", category "HTMX"). Place it via *Block layout*;
in its settings (`block.settings.htmx_loader`):

- **HTMX Block** (`htmx_block_id`) — which `htmx_block` to load (autocomplete via
  `htmx_block.htmx_block_autocomplete`).
- **Triggering Event** (`event`) — the `hx-trigger` event (e.g. `load`, `click`, `revealed`, a
  custom event; autocomplete offers events from `htmx.htmx_loader.autocomplete_events` config).
- **Event modifiers** — `filter` (boolean JS expression, wrapped as `[filter]`), `from`, `target`,
  `delay`, `throttle`, `consume`. `delay` and `throttle` are mutually exclusive (validated) and
  must match `\d+(ms|m|s)`. An **Advanced** checkbox lets you hand-write the multi-event
  `hx-trigger` string instead of using the modifier fields.

On the event, `HtmxLoaderBlock::build()` issues an `hx-get` to
`/htmx/blocks/view/<htmx_block_id>`, `hx-select`s `#block-<id>`, and swaps with `outerHTML`,
attaching `core/drupal.htmx`.

## Autocomplete events config

`htmx.htmx_loader.autocomplete_events` (config_object, key `events`: list of
`{event, description}`) seeds the event autocomplete on the loader block form. It ships an install
default listing the full HTMX event set plus common DOM events; edit it to offer your own event
names. The loader form also renders this list as reference documentation.
