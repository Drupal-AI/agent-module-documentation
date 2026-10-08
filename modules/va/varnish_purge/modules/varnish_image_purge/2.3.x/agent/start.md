# varnish_image_purge — agent start

Submodule of `varnish_purger` (project `varnish_purge`). Implements `hook_entity_update()`:
on entity save it sends `URIBAN` HTTP requests for every image-style derivative of the
entity's image fields, banning those variants in Varnish. Has a config form to scope which
entity bundles trigger purging. Depends on `varnish_purger` and `purge`. **Requires Varnish
VCL to handle the `URIBAN` method** (example snippet in the module's help page).

- Enable, the config form (which bundles trigger purge), config key, and the required VCL → [configure/setup.md](configure/setup.md)

Parent module → [../../../../2.3.x/agent/start.md](../../../../2.3.x/agent/start.md)
