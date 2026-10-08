# varnish_focal_point_purge — agent start

Submodule of `varnish_purger` (project `varnish_purge`). On update of a `focal_point` crop
entity it sends `URIBAN` HTTP requests to ban every image-style derivative of the cropped
file in Varnish. **No configuration, no admin page** — just enable it. Depends on
`varnish_purger` and `purge`. Requires Varnish VCL to handle the `URIBAN` method (example in
the module help).

- What triggers it, what it purges, and the required VCL → [api/behavior.md](api/behavior.md)

Parent module → [../../../../2.3.x/agent/start.md](../../../../2.3.x/agent/start.md)
Sibling `varnish_image_purge` → [../../../varnish_image_purge/2.3.x/agent/start.md](../../../varnish_image_purge/2.3.x/agent/start.md)
