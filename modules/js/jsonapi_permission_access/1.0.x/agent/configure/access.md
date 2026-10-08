# Gating JSON:API with a permission

## Mechanism
`JsonApiRoutesAddPermission` (tagged `event_subscriber`, extends `RouteSubscriberBase`) runs on
route rebuild:
```php
foreach ($collection as $route) {
  if (!empty($route->getDefaults()['_is_jsonapi'])) {
    $route->setRequirement('_permission', 'access jsonapi routes');
  }
}
```
So every JSON:API route (individual, collection, relationship, related) gains the
`access jsonapi routes` requirement. This is **additive/tightening**: core JSON:API is normally
reachable by anyone (subject to entity access); after enabling this module a caller must *also*
hold the permission, or the request is denied with 403 before entity access is evaluated.

There is nothing to configure — no settings form, no schema. All you do is grant the permission.

## The permission
`access jsonapi routes` (title "Access JSON:API Routes"). It is **not** `restrict access: TRUE`,
so it is intended to be grantable to lower-trust roles/consumers. Holding it only unlocks the
*route*; the response is still filtered by core entity/field access — the permission does not by
itself expose any entity a role couldn't already read.

## Grant / deny recipes
Grant to a role:
```bash
drush role:perm:add json_api_user 'access jsonapi routes'   # or any role
```
Assign the shipped role to a user/consumer:
```bash
drush user:role:add json_api_user someuser
```
Close JSON:API to the public: make sure neither `anonymous` nor `authenticated` holds
`access jsonapi routes` (grant it only to a dedicated API/consumer role).

Lock it down fast (incident response): revoke the permission from every role —
`drush role:perm:remove <role> 'access jsonapi routes'` — and all JSON:API URLs return 403.

## Default role
`config/optional/user.role.json_api_user.yml` installs a `JSON:API User` role whose only
permission is `access jsonapi routes` (installed only if User module config deps allow). Use it as
a ready-made "API client" role; it grants nothing else.
