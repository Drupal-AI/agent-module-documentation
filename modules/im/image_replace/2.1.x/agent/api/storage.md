# Programmatic API

## Storage service
Service id `image_replace.storage` (also autowired by class/interface). Implements
`Drupal\image_replace\ImageReplaceStorageInterface`
(`Drupal\image_replace\ImageReplaceDatabaseStorage`).

```php
/** @var \Drupal\image_replace\ImageReplaceStorageInterface $s */
$s = \Drupal::service(\Drupal\image_replace\ImageReplaceStorageInterface::class);
// or \Drupal::service('image_replace.storage');

$s->get(string $target_style, string $target_uri): ?string;   // replacement URI or NULL
$s->add(string $target_style, string $target_uri, string $replacement_uri): void;
$s->remove(string $target_style, string $target_uri): void;
```
- Keying: internally `target_uri` is hashed with `hash('sha256', $target_uri)` and stored as
  `target_uri_hash`. Primary key is `(target_style, target_uri_hash)`.
- `add()` does a plain insert (no upsert) — callers `remove()` first when re-syncing (as
  `image_replace_entity_presave` does).
- `get()` returns the stored `replacement_uri` string, or NULL if no row.

## Database schema (`{image_replace}`, image_replace.install)
| field | type | notes |
|---|---|---|
| `target_style` | varchar_ascii(255), not null | image style machine name (part of PK) |
| `target_uri_hash` | varchar(64), not null | sha256 of the original image URI (part of PK) |
| `replacement_uri` | varchar(255), binary, not null | URI to render instead |

Update hooks `image_replace_update_8101/8102` migrated an earlier `target_uri` column to the
hash-based key.

## Plugin classes (provided, not extension points)
- `src/Plugin/ImageEffect/ImageReplaceEffect.php` — the `image_replace` image effect. Injects
  `ImageFactory` and the storage service; `applyEffect()` looks up and applies a replacement.
  The style name it queries with comes from its own `data.image_style` config, populated by
  `image_replace_image_style_presave()`.
- `src/Plugin/ImageToolkit/Operation/gd/Replace.php` — GD `image_replace` operation
  (`image_replace_gd`); `execute()` calls `$this->getToolkit()->setImage($replacementResource)`.
- `src/Plugin/ImageToolkit/Operation/imagemagick/Replace.php` — ImageMagick operation
  (`image_replace_imagemagick`); copies the replacement's source path + width/height onto the
  toolkit. Both `validateArguments()` require a `replacement_image` `ImageInterface` on the
  matching toolkit.

## Hooks used (module-internal, for reference)
- `hook_entity_presave` → `image_replace_entity_presave` (build table + flush derivatives).
- `hook_ENTITY_TYPE_presave` for image styles → `image_replace_image_style_presave` (stamp style
  name into the effect config).
- `hook_form_FORM_ID_alter` for `field_config_edit_form` → adds the mapping UI.

The module invites no hooks of its own (no `image_replace.api.php`).
