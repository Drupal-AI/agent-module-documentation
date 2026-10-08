<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Disqus comments on a bundle + the display blocks

Disqus comments are turned on **per bundle** by attaching a **Disqus comments** field. There
is no per-content-type checkbox; the presence of a `disqus_comment` field is what enables the
thread.

## The `disqus_comment` field

- **Field type** `disqus_comment` (`Drupal\disqus\Plugin\Field\FieldType\DisqusItem`) — a
  single-value field storing `status` (bool, show comments) and `identifier` (string, the
  Disqus discussion identifier; defaults to `entityType/entityId`).
- **Widget** `disqus_comment` (`DisqusWidget`) — lets an editor toggle comments per entity.
- **Formatter** `disqus_comment` (`DisqusFormatter`) — renders the Disqus thread (uses the
  `disqus` render Element) when the entity is viewed.

### Add the field via UI

1. Go to the bundle's *Manage fields* (e.g. `/admin/structure/types/manage/article/fields`).
2. **Add field → Disqus comments**, name it (e.g. `field_disqus`), save.
3. On *Manage display*, ensure the field's format is **Disqus comments** so the thread shows.

### Add the field via drush php:eval

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_disqus', 'entity_type' => 'node', 'type' => 'disqus_comment',
])->save();
FieldConfig::create([
  'field_name' => 'field_disqus', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Comments',
])->save();
```

Check it: `drush field:info node article` (look for a `disqus_comment` field), or load the
`field.field.node.article.field_disqus` config.

## Display blocks (place via Block layout)

| Block plugin id | What it shows |
|---|---|
| `disqus_recent_comments` | Recent comments across the site |
| `disqus_popular_threads` | Most-commented threads |
| `disqus_top_commenters` | Most active commenters |
| `disqus_combination_widget` | Combined recent/popular/top widget |

Each block requires the site shortname to be set (see
[settings.md](settings.md)). The module also exposes a **Views field** for the Disqus comment
count (`disqus_field_views_data()` / `DisqusCommentCount`).
