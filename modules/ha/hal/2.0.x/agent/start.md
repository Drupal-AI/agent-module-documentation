# hal — agent start

Adds the `hal_json` serialization format that encodes entities as Hypertext Application Language
(hypermedia `_links` + `_embedded`). Was in Drupal core through D9; extracted to this contrib
module for D10/D11/D12. Depends on core `serialization`; usually paired with `rest`. Enable with
`drush en hal -y`. No admin UI — one config value `hal.settings:link_domain`.

- Use the `hal_json` format, the normalizers/encoder, and the LinkManager API → [api/hal.md](api/hal.md)
- Add a custom normalizer or override the link manager → [extend/hal.md](extend/hal.md)
- Alter generated type/relation URIs via hooks → [hooks/hal.md](hooks/hal.md)
