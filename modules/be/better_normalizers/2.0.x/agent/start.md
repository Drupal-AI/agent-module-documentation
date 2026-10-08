# Better Normalizers — agent index

Replaces three core **HAL** normalizers so `hal_json` serialization of files and menu links is
lossless. Depends on the `hal` module. **No config, no routes, no permissions, no Drush, no UI** —
enabling it (with `hal`) is the entire setup. Only affects the `hal_json` format.

- **The three normalizers, what they add, priorities, and how to use/extend them** →
  [api/normalizers.md](api/normalizers.md)

Key facts:
- Registered in `BetterNormalizersServiceProvider::alter()` (a `ServiceProvider`, not config).
- `serializer.normalizer.entity.file_entity` → `FileEntityNormalizer` (priority **30**): adds a
  base64 `data` property on normalize, writes the file back on denormalize.
- `serializer.normalizer.entity_reference_item.file_entity` → `FileItemNormalizer`
  (priority **20**): keeps file-field `description`/`display` (and other item props).
- `serializer.normalizer.menu_link_content.hal` → `MenuLinkContentNormalizer` (priority **30**,
  only if `menu_link_content` is enabled): embeds the linked entity and the parent menu link.
- Each priority is set above the matching `hal.services.yml` normalizer so these win.
- Use via the standard `serializer` service / REST: `\Drupal::service('serializer')->serialize($file, 'hal_json')`.
