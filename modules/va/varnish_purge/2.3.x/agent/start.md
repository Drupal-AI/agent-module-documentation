# varnish_purge (machine name: varnish_purger) — agent start

Purge "purger" plugins that invalidate Varnish reverse-proxy caches when Drupal content
changes. NOTE the naming mismatch: the Drupal.org **project is `varnish_purge`** but the
**main module machine name is `varnish_purger`** (`drush en varnish_purger`). Provides three
purger plugins (`varnish`, `varnishbundled`, `varnish_zeroconfig_purger`) and a
`varnishconfiguration` diagnostic. Depends on `purge` and `purge_tokens`. The module has **no
admin page of its own** (`configure` is `null`) — purgers are added/configured through Purge's
UI (`purge_ui`) or Drush.

- Enable, add purgers, and set every configurable key (hostname, method, headers, timeouts) → [configure/setup.md](configure/setup.md)
- The three purger plugins + diagnostic, invalidation types, when to use which → [plugins/purgers.md](plugins/purgers.md)
- Programmatic surface: `VarnishPurgerSettings` config entity, purger base (getUri/getOptions/token) → [api/api.md](api/api.md)
- Submodule `varnish_purge_tags` (Cache-Tags response header) → [../../modules/varnish_purge_tags/2.3.x/agent/start.md](../../modules/varnish_purge_tags/2.3.x/agent/start.md)
- Submodule `varnish_image_purge` (URIBAN image-style purge on entity save) → [../../modules/varnish_image_purge/2.3.x/agent/start.md](../../modules/varnish_image_purge/2.3.x/agent/start.md)
- Submodule `varnish_focal_point_purge` (URIBAN purge on focal-point crop change) → [../../modules/varnish_focal_point_purge/2.3.x/agent/start.md](../../modules/varnish_focal_point_purge/2.3.x/agent/start.md)
