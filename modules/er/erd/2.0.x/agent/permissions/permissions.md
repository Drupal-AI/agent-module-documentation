<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module defines a single permission (`erd.permissions.yml`):

| Machine name | Title | Gates |
|--------------|-------|-------|
| `administer erd` | Create and administer Entity Relationship Diagrams | All three routes: `erd.admin` (view/build the diagram), `erd.settings` (settings form), `erd.ajaxSave` (persist layout to State). |

Every route in `erd.routing.yml` uses `requirements: { _permission: 'administer erd' }`. The
permission is not granted to any role by default, so the diagram — which exposes the full entity
type / bundle / field model of the site — is only reachable by roles you explicitly grant it to.

Grant it:

```bash
drush role:perm:add administrator 'administer erd'
```

Note: the module's README still refers to `administer site configuration`; that reflects the
legacy `8.x-1.x` branch. On `2.0.x` the real gate is the dedicated `administer erd` permission
above. Because the diagram reveals the whole data model, treat `administer erd` as a
developer/administrator-only permission.
