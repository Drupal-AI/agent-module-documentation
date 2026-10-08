# Menu Normalizer — agent index

Pure plumbing: registers the two Serializer normalizers core lacks for menu objects, so
`MenuLinkInterface` and `MenuLinkTreeElement` can be serialized (JSON/XML) via the core `serializer`
service. No UI, config, permissions, routes, or Drush. Does nothing on its own — install only when
code/another module needs to serialize menus.

- **The two normalizers and the exact array shape they emit** → [api/normalizers.md](api/normalizers.md)

Key facts:
- Services (`menu_normalizer.services.yml`), both tagged `normalizer`:
  `MenuLinkNormalizer` (supports `MenuLinkInterface`) and `MenuLinkTreeNormalizer` (supports
  `MenuLinkTreeElement`).
- Relies on core's Serialization/serializer to be present to have any effect.
- Requires Drupal core `^11.3 || ^12` (this 2.2.x branch dropped the older `^9 || ^10 || ^11`
  support that 2.1.x carried).

## Diff 2.1.x → 2.2.x

- **Core requirement bumped**: `core_version_requirement` is now `^11.3 || ^12`
  (`menu_normalizer.info.yml`), and `composer.json` requires `drupal/core: ^11.3 || ^12`. The 2.1.x
  branch supported `^9 || ^10 || ^11`; 2.2.x drops Drupal 9/10 and the pre-11.3 Drupal 11 releases.
- **New branch/release**: `2.2.x`, release `2.2.0` (`version: '2.2.0'` in the info file).
- **Normalizer behaviour unchanged**: both `MenuLinkNormalizer` and `MenuLinkTreeNormalizer` emit the
  same array shape as 2.1.x (same fields, same order). No new fields, services, routes, permissions,
  or config were added.
