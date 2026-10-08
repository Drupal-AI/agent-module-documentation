<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Fivestar rating field

Fivestar has **no central settings page**. The info file declares
`configure: fivestar.admin_overview`, but that route is **not registered** by the module, so
don't rely on it. All configuration is per field, on the bundle's *Manage fields*, *Manage
form display* and *Manage display* pages (or in config directly).

## Add the field

Add a field of type **Fivestar rating** (`fivestar`, category `fivestar`) to any fieldable
entity. Requires the `votingapi` module (dependency).

## Storage setting (set once, before data exists)

Config: `field.storage.<entity>.<field>` → `settings`.

| Key | Default | Meaning |
|---|---|---|
| `vote_type` | `vote` | The Voting API vote type each save records. Choose a "rating axis" (quality, satisfaction, overall…). Add types at `/admin/structure/vote-types`. Disabled once data exists. |

Column schema: `rating` (int, 0–100, sortable) and `target` (int).

## Field (instance) settings

Config: `field.field.<entity>.<bundle>.<field>` → `settings` (see `defaultFieldSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `stars` | `5` | Number of stars, 1–10. |
| `allow_clear` | `false` | Show a "Cancel rating" option so users can clear their vote. |
| `allow_revote` | `true` | Allow changing an existing vote. |
| `allow_ownvote` | `true` | Allow users to rate their own content. |
| `rated_while` | `viewing` | `viewing` = widget votes on the rendered entity; `editing` = rating captured on the edit form. |
| `enable_voting_target` | `false` | Also record the vote on a bridged entity. |
| `target_bridge_field` | `''` | Machine name of an **entity_reference** field on the host entity pointing to the target (validated to exist and be entity_reference). |
| `target_fivestar_field` | `''` | Machine name of the fivestar field on the target entity to affect. |

## Display: widget (form display)

Widgets for the `fivestar` field: `fivestar_stars` (interactive stars) or `fivestar_select`
(select list). The stars widget stores in the form-display component `settings`:
`fivestar_widget` (skin key, default `basic`), `display_format` (`average`), `text_format`
(`none`). Config path: `core.entity_form_display.<entity>.<bundle>.<mode>` →
`content.<field>.settings`.

## Display: formatter (view display)

Formatters: `fivestar_stars` (interactive/average stars), `fivestar_percentage` (e.g. `92`),
`fivestar_rating` (e.g. `4.2/5`). The stars formatter settings: `fivestar_widget` (skin),
`display_format` (`average`), `text_format` (`none`/`average`). Config path:
`core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.{type,settings}`.

Available skin keys (see [plugins/plugins.md](../plugins/plugins.md)): `basic`, `craft`,
`drupal`, `flames`, `hearts`, `lullabot`, `minimal`, `outline`, `oxygen`, `small`.

## Permission

Single permission **`rate content`** ("Use Fivestar to rate content"). Grant to roles that
should be able to submit votes.

## Scriptable example (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_rating', 'entity_type' => 'node', 'type' => 'fivestar',
  'settings' => ['vote_type' => 'vote'],
])->save();
FieldConfig::create([
  'field_name' => 'field_rating', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Rating', 'settings' => ['stars' => 5, 'rated_while' => 'viewing'],
])->save();
// Set the interactive stars formatter with the "hearts" skin:
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_rating', ['type' => 'fivestar_stars', 'settings' => ['fivestar_widget' => 'hearts']])
  ->save();
```

Read a value back: `drush cget field.field.node.article.field_rating settings`.
