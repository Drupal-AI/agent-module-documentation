<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textimage permissions

Textimage defines one permission (`textimage.permissions.yml`):

- **`generate textimage url derivatives`** — "Generate Textimage URL derivatives". Allows a user
  to generate Textimage derivatives directly from a URL request (the direct-URL generation
  route). Restricting it prevents anonymous users from creating arbitrary images on demand.

The settings and cleanup routes are instead gated by the core
**`administer site configuration`** permission (see `textimage.routing.yml`).

Grant with drush:

```bash
drush role:perm:add anonymous 'generate textimage url derivatives'
```

Only meaningful when `url_generation.enabled` is TRUE in `textimage.settings`.
