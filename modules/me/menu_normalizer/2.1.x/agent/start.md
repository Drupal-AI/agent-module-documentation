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
