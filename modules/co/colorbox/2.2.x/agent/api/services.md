# Colorbox services

Defined in `colorbox.services.yml`.

| Service | Class | Purpose |
|---|---|---|
| `colorbox.activation_check` | `ActivationCheck` (`ActivationCheckInterface`) | Decides per-request whether Colorbox assets should attach (honors the `activate` mode + current route). Args: `@config.factory`, `@request_stack`. |
| `colorbox.attachment` | `ColorboxAttachment` (`ElementAttachmentInterface`) | Attaches the Colorbox library + `drupalSettings` to a render array. Args: `@colorbox.activation_check`, `@module_handler`, `@config.factory`. |
| `colorbox.gallery_id_generator` | `GalleryIdHelper` | Generates gallery grouping ids (token-aware) so images share/split galleries. Args: `@config.factory`, `@token`. |

Usage:
```php
$attach = \Drupal::service('colorbox.attachment');
if (\Drupal::service('colorbox.activation_check')->isActive()) {
  $attach->attach($build);
}
$gid = \Drupal::service('colorbox.gallery_id_generator')->getId($entity, $field_name);
```

Interfaces `ActivationCheckInterface` and `ElementAttachmentInterface` let you decorate or
swap these services.
