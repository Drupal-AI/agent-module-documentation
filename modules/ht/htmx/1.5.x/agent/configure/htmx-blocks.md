<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX Block config entity + HTMX Loader block

Two pieces work together to lazy-load a block over HTMX:

1. an **HTMX Block** (`htmx_block` config entity) — a stored block definition, and
2. an **HTMX Loader** block plugin (`htmx_loader`) — placed in a region, it swaps itself for
   the HTMX block when a chosen event fires.

## HTMX Block config entity (`htmx_block`)

- Managed at **`/admin/structure/htmx-block`** (route `entity.htmx_block.collection`, appears
  under *Structure → Block layout → HTMX*). Add/edit/delete forms live under `/htmx/blocks/*`.
- Permission: **`administer htmx_block`**.
- Config name `htmx.htmx_block.<id>`; exported keys: `id`, `label`, `provider`, `plugin`,
  `settings`, `visibility`. `plugin` is a core Block plugin id; `settings` is that plugin's
  `block.settings.<plugin>`; `visibility` is a sequence of condition plugins.
- It reuses core's `BlockAccessControlHandler`. Render URL: `/htmx/blocks/view/{block}`
  (`htmx_blocks.view`, `_htmx_route: true`, permission `access content`).

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

A core Block plugin (admin label "HTMX Loader", category "HTMX"). Place it via
*Block layout*; in its settings:

- **HTMX Block** (`htmx_block_id`) — which `htmx_block` to load (autocomplete).
- **Triggering Event** (`event`) — the `hx-trigger` event (e.g. `load`, `click`, a custom
  event; autocomplete offers events from `htmx.htmx_loader.autocomplete_events` config).
- **Advanced** (`advanced`) toggles extra `hx-trigger` modifiers: `filter`, `from`, `delay`,
  `throttle`, `target`, `consume`.

On the event, the placeholder issues an `hx-get` to `/htmx/blocks/view/<htmx_block_id>` and
swaps in the rendered block. Config schema: `block.settings.htmx_loader`.

## Autocomplete events config

`htmx.htmx_loader.autocomplete_events` (config_object, key `events`: list of
`{event, description}`) seeds the event autocomplete on the loader block form. Ships an
install default; edit to offer your own event names.
