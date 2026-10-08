<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access — the `issue subrequests` permission

There is exactly one permission and one route; there is no settings/configure form
(`configure: null` in data.json).

## The permission

```yaml
# subrequests.permissions.yml
issue subrequests:
  title: 'Issue subrequests'
  description: 'Allow using the subrequests front controller to respond to multiple requests.'
```

Grant it to any role that should be allowed to POST/GET a blueprint to the front controller —
typically a dedicated API-client/integration role rather than every authenticated user, since
a granted blueprint can bundle arbitrary `view`/`create`/`update`/`replace`/`delete` actions
(each still subject to normal Drupal access checks on the underlying route/entity).

## The route

```yaml
# subrequests.routing.yml
subrequests.front-controller:
  path: '/subrequests'
  defaults:
    _controller: '\Drupal\subrequests\Controller\FrontController::handle'
  methods: [GET, POST]
  options:
    _auth: ['basic_auth', 'cookie', 'oauth2', 'token_bearer']
  requirements:
    _permission: 'issue subrequests'
```

- Path: `/subrequests`. Methods: `GET` (blueprint as a percent-encoded `query` parameter) or
  `POST` (blueprint as the request body).
- Auth providers accepted on the **master** request: `basic_auth`, `cookie`, `oauth2`,
  `token_bearer` (module/provider must be enabled separately — `subrequests` itself doesn't
  add any of them). Whichever identity authenticates the master request is the identity every
  subrequest inside the batch runs as (cookies/session are copied onto each sub-request).
- Enforcement is a plain `_permission` route requirement — check/grant it like any other
  permission (Permissions UI at `/admin/people/permissions`, `user_role_grant_permissions()`,
  or `drush role:perm:add <role> 'issue subrequests'`).

## Read it back

```bash
drush role:perm:add <role> 'issue subrequests'      # grant
drush role:perm:remove <role> 'issue subrequests'   # revoke
```

Or in PHP: `\Drupal::entityTypeManager()->getStorage('user_role')->load($rid)
  ->hasPermission('issue subrequests')`.
