# Single responsive image formatter

One field formatter. Class
`Drupal\single_image_formatter_responsive\Plugin\Field\FieldFormatter\SingleResponsiveImageFormatter`.

| Property | Value |
|---|---|
| Plugin id | `single_responsive_image_formatter` |
| Label | "Single responsive image" |
| Field type | `image` |
| Extends (core) | `Drupal\responsive_image\Plugin\Field\FieldFormatter\ResponsiveImageFormatter` |
| Requires module | `responsive_image` (core) |
| Config schema | `field.formatter.settings.single_responsive_image_formatter` → maps to `field.formatter.settings.responsive_image` |

## What it changes

The class adds a single override:

```php
protected function getEntitiesToView(EntityReferenceFieldItemListInterface $items, $langcode) {
  $files = parent::getEntitiesToView($items, $langcode);
  $file = reset($files);
  return $file ? [$file] : [];
}
```

`parent::getEntitiesToView()` resolves and access-filters the referenced files; this keeps only the
first. Everything else — the settings form, responsive `<picture>`/`srcset` build, link handling,
cache metadata — is core `ResponsiveImageFormatter`, unchanged. Field cardinality and stored values are
untouched; only the number rendered changes (one). See the parent's
[configure/formatters.md](../../../../../2.0.x/agent/configure/formatters.md) for the shared
single-image pattern across the three family formatters.

## Settings

Inherited from `ResponsiveImageFormatter` with no additions: `responsive_image_style` (the responsive
image style machine name to apply) and `image_link` (link the image to nothing / content / the file).
A responsive image style must exist and be selected for output to render. Set them via the
Manage-display formatter cog or in `settings` when configuring via config.

## Select it (UI)

Structure → (entity type / bundle) → **Manage display** (for the target view mode) → set the `image`
field's Format to **Single responsive image**, then use the cog to pick the responsive image style / link.

## Set it via config

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.teaser');
$vd->setComponent('field_gallery', [
  'type' => 'single_responsive_image_formatter',
  'label' => 'hidden',
  'settings' => ['responsive_image_style' => 'wide', 'image_link' => 'file'],
])->save();
```
