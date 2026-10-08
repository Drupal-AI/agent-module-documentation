<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `acquia_dam.permissions.yml` (two permissions):

| Permission | Gates | Notes |
|---|---|---|
| `administer acquia_dam` | The connection/config forms under `/admin/config/acquia-dam` (main config, metadata, image styles, integration links), site auth (`/acquia-dam/auth`) and disconnect. | `restrict access: true` — trusted admins only. |
| `authorize with acquia dam` | A user authorizing their own DAM account: `/user/{user}/acquia-dam`, `/user/acquia-dam/auth`, logout. | Give to any role whose members embed DAM assets. |

Several routes require **either** permission with the `+` syntax, e.g. the user auth page
uses `authorize with acquia dam+administer acquia_dam` (either one grants access), and many
config routes additionally enforce a **site-authenticated** access check
(`_acquia_dam_site_authenticated_access_check`) so they are only reachable once the site has
completed the DAM OAuth handshake.

```bash
# let editors connect their own DAM account
drush role:perm:add editor 'authorize with acquia dam'
# site admins configure the connection
drush role:perm:add administrator 'administer acquia_dam'
```

Asset/media routes (embedding, revision checks, metadata sync) reuse core **media** entity
access (`_entity_access: media.update` etc.), not custom permissions.
