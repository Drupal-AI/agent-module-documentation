# Configuration

There are two ways to restrict a route by domain: the admin UI (for site builders)
and a route-definition requirement (for developers writing their own routes).

## Option 1 — the admin UI

1. Log in as a user with the **Administer domain route access** permission.
2. Go to **Configuration → Domain → Route Access**
   (`/admin/config/domain/route-access`).
3. Click **Add new Domain Route Access**.
4. Fill in the form:
   - **Route** — select the route you want to control access to (for example
     `user.register`).
   - **Allowed domains** — tick the domains on which the route should remain
     accessible. The route is reachable on **any** of the domains you select and
     blocked on the rest.
   - **Enabled** — enable or disable this rule. A disabled rule drops its
     requirement on the next route rebuild.
5. **Save**.
6. **Clear caches.** The rule is applied when routes are rebuilt, so use the
   listing's **Clear cache** action (or `drush cr`) before testing — the
   restriction does not take effect until you do.

Each rule maps one route to a set of allowed domains. You can add as many rules as
you like for different routes.

### Safety notes

- An entry with **no allowed domains selected** is skipped entirely, leaving the
  route unrestricted — so an empty selection cannot accidentally lock everyone out.
- Restricting **core or system routes** is possible, but test carefully so you do
  not lock administrators out of a domain.
- This module restricts *existing* routes only; it never creates endpoints or
  exposes data. Rules are config entities, so they export and deploy with Drupal's
  configuration management.

## Option 2 — the `_domain` route requirement (developers)

If you define your own routes, you can add the same per-domain restriction
directly in your module's `*.routing.yml`, without creating a config entity:

```yaml
my_module.custom_route:
  path: '/foo/bar'
  defaults:
    _controller: 'Drupal\my_module\Controller\BarsController'
  requirements:
    _permission: 'view bars content'
    _domain: 'domain1_id+domain2_id'
```

The `_domain` requirement lists the allowed domain IDs joined with `+` ("any of
these domains"). This is the same Domain-module access check the UI applies under
the hood.
