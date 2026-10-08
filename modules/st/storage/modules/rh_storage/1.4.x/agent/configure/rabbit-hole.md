<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Rabbit Hole on storage entities

rh_storage has no configuration of its own. It only makes the `storage` entity type
Rabbit-Hole-aware; you then use Rabbit Hole's normal configuration.

## What it adds

- A `RabbitHoleEntityPlugin` (id `rh_storage`, `entityType = "storage"`,
  `src/Plugin/RabbitHoleEntityPlugin/Storage.php`) — registers `storage` with Rabbit Hole.
- Base fields on every `storage` entity (via
  `rabbit_hole.entity_extender->getRabbitHoleFields('storage')`):
  - **`rh_action`** — the chosen Rabbit Hole behavior plugin id.
  - `rh_redirect` — redirect target (for `page_redirect`).
  - `rh_redirect_response` — HTTP response code for the redirect.
  - `rh_redirect_fallback_action` — action to use if the redirect can't run.

## Rabbit Hole actions (behavior plugin ids stored in `rh_action`)

| `rh_action` value | Effect when the entity's URL is visited |
|---|---|
| `display_page` | Show the entity normally. |
| `access_denied` | Return 403 Access denied. |
| `page_not_found` | Return 404 Not found. |
| `page_redirect` | Redirect to `rh_redirect` with `rh_redirect_response`. |

A storage-type **bundle** also has a default action (Rabbit Hole's per-bundle behavior
settings); individual entities can override it via their own `rh_action` when overrides are
allowed.

## Set it via drush / code

```bash
# Set a storage entity's Rabbit Hole action to access-denied:
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("storage")->load(123);
  $e->set("rh_action", "access_denied")->save();
'

# Read a storage entity's configured action:
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("storage")->load(123);
  print $e->get("rh_action")->value;
'
```

In the UI, the Rabbit Hole settings appear on the storage entity's add/edit form (and the
storage type's edit form for the bundle default) once rh_storage + rabbit_hole are enabled.
Note this composes with the storage type's own `has_canonical` flag: with no canonical URL
there is nothing to intercept.
