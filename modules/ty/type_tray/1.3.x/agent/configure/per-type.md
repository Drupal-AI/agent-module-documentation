<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-content-type settings

Everything type-specific is a **third-party setting** on the `node_type` config entity, in
the `type_tray` namespace.

```yaml
# node.type.article
third_party_settings:
  type_tray:
    type_category: tt_editorial          # must be a key from type_tray.settings:categories
    type_thumbnail: '/themes/custom/foo/img/thumbs/article.png'
    type_icon: '/themes/custom/foo/img/icons/article.svg'
    type_description: '<p>Use this for news and blog posts.</p>'
    existing_nodes_link_text: 'View existing Article content'
    type_weight: 0
```

Schema key: `node.type.*.third_party.type_tray` (see `config/schema/type_tray.schema.yml`).

| Key | Type | Meaning / default |
|---|---|---|
| `type_category` | string | Category key; falls back to `_none` when empty or unknown |
| `type_thumbnail` | string | Webroot-relative path; default `<type_tray path>/assets/thumbnails/wysiwyg1.png` |
| `type_icon` | string | Webroot-relative path; default `<type_tray path>/assets/icons/file-text.svg` |
| `type_description` | label | Extended description, rendered with `type_tray.settings:text_format`; used in **list** layout only, falling back to the core description |
| `existing_nodes_link_text` | label | Link text to `/admin/content?type=<type>`; empty = no link |
| `type_weight` | integer | Sort order inside the category; higher sinks (default 0) |

## In the UI

Edit the content type (`/admin/structure/types/manage/<type>`) → **Type Tray** vertical tab.
The form is added by `type_tray_form_node_type_form_alter()`; `type_tray_entity_builder()`
copies each value into `setThirdPartySetting('type_tray', $key, $value)` (unwrapping
`type_description` from the `text_format` element's `['value']`).

## From code / drush

```bash
drush php:eval '
  $t = \Drupal\node\Entity\NodeType::load("article");
  $t->setThirdPartySetting("type_tray", "type_category", "tt_editorial");
  $t->setThirdPartySetting("type_tray", "type_weight", 10);
  $t->setThirdPartySetting("type_tray", "existing_nodes_link_text", "View existing Article content");
  $t->save();'
```

Read them back:

```bash
drush cget node.type.article third_party_settings
drush php:eval 'print var_export(\Drupal\node\Entity\NodeType::load("article")->getThirdPartySettings("type_tray"), TRUE);'
```

Resolve the effective category (key + label) for a type:

```php
\Drupal\type_tray\Controller\TypeTrayController::getCategory('article');
// -> ['tt_editorial' => 'Editorial']   or   ['_none' => 'Uncategorized']
```

All available categories (including the synthetic Favorites group when applicable):

```php
\Drupal\type_tray\Controller\TypeTrayController::getTypeTrayCategories();
```

## Install-time behaviour

`type_tray_install()` seeds every existing content type's `existing_nodes_link_text` with
*"View existing %type_label content"*. `type_tray_post_update_move_existing_node_links_to_type_settings()`
migrated the old global `existing_nodes_link` boolean into this per-type text and removed the
config key.

## Gotchas

- `type_category` pointing at a key that is **not** in `type_tray.settings:categories`
  silently falls back to `_none`.
- You cannot delete a category from the settings form while a type still references it.
- Icon/thumbnail values are webroot-relative *paths*, not managed file ids; they are passed
  through `file_url_generator->generateString()`.
