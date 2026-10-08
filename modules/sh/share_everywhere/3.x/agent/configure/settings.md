<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Share Everywhere

Single config object **`share_everywhere.settings`**, one form at route
**`share_everywhere.config_form`** (`/admin/config/services/share_everywhere`, permission
*administer share everywhere*, form id `share_everywhere.config_form`).

## Buttons

`buttons` is a map keyed by network. `facebook_like` has just `name`/`enabled`; the rest
(`facebook_share`, `twitter`, `linkedin`, `messenger`, `viber`, `whatsapp`, `copy`) are
`share_everywhere.image_button` (`name`, `title`, `enabled` (int 0/1), `image` (svg filename),
`weight`). Note `twitter` renders through the **`se-x`** template (X/Twitter). Reorder with
`weight`; toggle with `enabled`.

## Top-level keys (shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `share_icon` | `{image: share-icon.svg, alt: Share icon}` | Icon for collapsible mode. |
| `title` | `Share Everywhere` | Heading above the buttons. |
| `display_title` | `1` | Show the title. |
| `style` | `share_everywhere` | CSS style set. |
| `include_css` | `include_css` | Include bundled CSS (empty to disable). |
| `include_js` | `include_js` | Include bundled JS (empty to disable). |
| `collapsible` | `1` | Hide buttons behind the share icon until clicked. |
| `location` | `content` | `content` (extra field) or `links` (node links area). |
| `alignment` | `left` | `left` / `right`. |
| `content_types` | `{article, page}` | Node bundles where buttons may show. |
| `view_modes` | `{article:{full}, page:{full}}` | Enabled view modes per bundle. |
| `product_types` / `product_view_modes` | `{default:{full}}` | Same for Commerce products. |
| `per_entity` | (unset) | If truthy, add a per-node/product opt-in checkbox. |
| `enabled_entities` | — | Entity ids opted in under `per_entity` (per entity type). |
| `restricted_pages` | `{pages:{}, type: show}` | Path visibility (`show`/hide list). |
| `weight` | `10` | Weight of the extra field component. |

## Four ways buttons appear

1. **Extra field** (`location: content`): `hook_entity_extra_field_info()` exposes a
   `share_everywhere` display component on every node (and commerce_product) bundle. Place it on
   *Manage display*; it renders when the bundle is in `content_types` and the view mode is in
   `view_modes.<bundle>` (and, if `per_entity`, the entity id is in `enabled_entities`).
2. **Links** (`location: links`): buttons are injected into the node's `links` render array.
3. **Block**: the `share_everywhere_block` block plugin ("Share Everywhere Block") — place it in
   any region; it shares the current page URL.
4. **Views field**: `share_everywhere_field` (`@ViewsField("share_everywhere_field")`) — add it
   as a field to a View.

## Per-entity opt-in

With `per_entity` on, node/product forms get a "Share Everywhere Settings" → "Show social share
buttons" checkbox (`hook_form_BASE_FORM_ID_alter`), saved into
`enabled_entities.<entity_type>` in the config.

## Read / write via drush

```bash
drush cget share_everywhere.settings buttons
drush cget share_everywhere.settings location
```

```php
$c = \Drupal::configFactory()->getEditable('share_everywhere.settings');
$c->set('buttons.whatsapp.enabled', 0)->set('alignment', 'right')->save();
```
