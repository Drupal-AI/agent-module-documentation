<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a Social Link Field, plus the global setting

## The field type

Field type id: **`social_links`** (`Plugin/Field/FieldType/SocialLinkItem`). Each delta stores
two varchar(255) columns:

- `social` — the platform plugin id (e.g. `facebook`, `twitter`, `instagram`).
- `link` — the profile URL/handle (combined with the platform's `urlPrefix`/`urlSuffix` on render).

`isEmpty()` is true only when both `social` and `link` are empty. Default widget `social_links`,
default formatter `font_awesome`.

## Add the field (UI)

1. On a bundle's *Manage fields* (e.g. `/admin/structure/types/manage/article/fields`), *Add
   field* → **Social Links** (category "Field types").
2. Set **Allowed number of values** (cardinality). With a limited cardinality you can also set
   default networks/links and forbid changing them.
3. On *Manage form display*, the **Social links** widget has two settings:
   - `select_social` — "Possibility to select social network" (if off with fixed cardinality,
     the networks are locked and editors only fill in the link).
   - `disable_weight` — "Disable order" (removes drag/reorder).
4. On *Manage display*, choose a formatter (below).

## Add the field (drush php:eval, scriptable)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_social', 'entity_type' => 'node',
  'type' => 'social_links', 'cardinality' => -1,
])->save();
FieldConfig::create([
  'field_name' => 'field_social', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Social links',
])->save();
```

## Formatters

- **`font_awesome`** (`SocialLinkFontAwesomeFormatter`) — renders icons. Settings:
  `new_tab` (bool, default TRUE), `icon_type` (`common`|`square`, default `common`),
  `orientation` (`vertical`|`horizontal`, default `vertical`).
- **`network_name`** (`SocialLinkNetworkNameFormatter`) — renders the platform name as a text
  link. Setting: `new_tab` (bool, default TRUE).

Set a formatter via config on `core.entity_view_display.<entity>.<bundle>.<mode>`:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_social', [
  'type' => 'network_name',
  'settings' => ['new_tab' => TRUE],
])->save();
```

## Global module setting

Config object: **`social_link_field.settings`** with a single boolean **`attached_fa`**
(default `TRUE`, from `config/install/social_link_field.settings.yml`).

- Route: `social_link_field.settings` → `/admin/config/services/social-link-field`
  (form `SocialLinkFieldSettingsForm`).
- Permission gating it: **`configure social link field`**.
- When `attached_fa` is TRUE the module attaches its external Font Awesome library; set it FALSE
  if your theme already loads Font Awesome (avoids double-loading).

```bash
drush cget social_link_field.settings attached_fa
drush cset social_link_field.settings attached_fa false -y
```
