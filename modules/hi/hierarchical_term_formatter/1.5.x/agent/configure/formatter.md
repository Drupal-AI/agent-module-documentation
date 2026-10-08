<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Hierarchical Term Formatter

There is **no admin settings page** (`configure: null`). You select the formatter per field,
per view mode, on the entity's **Manage display** page, or directly in the
`entity_view_display` config. It is only available on an `entity_reference` field whose target
type is `taxonomy_term`.

## Settings keys (defaults)

| Key | Type | Default | Values / meaning |
|---|---|---|---|
| `display` | string | `all` | `all` (term + all ancestors), `grouping` (merge siblings under a shared parent), `parents` (ancestors only, drop the leaf), `root` (topmost term only), `nonroot` (all except the root), `leaf` (selected term only) |
| `link` | bool | `false` | Link each term to its term page |
| `wrap` | string | `none` | Wrapper per term: `none`, `span`, `div`, `ul`, `ol` (`ul`/`ol` render each term as an `<li>`) |
| `separator` | string | `" » "` | Text/markup between terms (blank = no separator) |
| `reverse` | bool | `false` | Reverse order (children first, ancestors last) |

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_categories:
    type: hierarchical_term_formatter
    label: above
    settings:
      display: parents
      link: true
      wrap: none
      separator: ' » '
      reverse: false
    third_party_settings: {  }
```

## Via the UI

1. Go to the bundle's *Manage display*, e.g. Article:
   `/admin/structure/types/manage/article/display`.
2. In the **Format** column for the taxonomy-term reference field, pick **Hierarchical Term
   Formatter**.
3. Click the cog to set *Terms to display*, *Link each term*, *Reverse order*, *Wrap each
   term*, and *Separator*. **Update**, then **Save**.

## Via drush php:eval (scriptable)

The default view display may not be persisted yet, so obtain it through the display
repository (which creates it if missing) rather than `Storage::load()`:

```php
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$vd->setComponent('field_categories', [
  'type' => 'hierarchical_term_formatter',
  'label' => 'above',
  'settings' => [
    'display' => 'root', 'link' => TRUE, 'wrap' => 'ul',
    'separator' => ' » ', 'reverse' => FALSE,
  ],
  'weight' => 10, 'region' => 'content',
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_categories
# type: hierarchical_term_formatter, and settings.display / settings.separator etc.
```

Config schema `field.formatter.settings.hierarchical_term_formatter` validates `display`,
`link`, `wrap`, `separator`, `reverse`.
