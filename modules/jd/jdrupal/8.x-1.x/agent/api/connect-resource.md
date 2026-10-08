<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `jdrupal_connect` REST resource + `hook_jdrupal_connect_alter`

The only server-side capability the module adds beyond the JS library.

## The resource

`src/Plugin/rest/resource/jDrupalConnect.php` — a core `@RestResource`:

```
id          = "jdrupal_connect"
label       = "jDrupal Connect"
uri_paths   = { "canonical" = "/jdrupal/connect" }
```

Only `GET` is implemented. It reads `\Drupal::currentUser()` — i.e. the **requesting session's
own account** — and returns:

```json
{ "uid": 0, "name": "", "roles": ["anonymous"] }
```

for anonymous, or the authenticated account's `uid` / `name` / `roles` otherwise. The response
is given `addCacheableDependency($account)` (varies per user). Before returning, it runs
`\Drupal::moduleHandler()->alter('jdrupal_connect', $results)`, letting other modules extend it.

It exposes only the caller's own identity (uid/name/roles), never other users' data, and is
gated by the standard REST resource permission below.

## Enabling it (required — off by default)

Verified on the live site: the plugin is discovered (canonical `/jdrupal/connect`), but until
the resource is turned on the route does not exist — a GET returns
`404 {"message":"No route found for GET /jdrupal/connect"}`. Turn it on like any core REST resource:

- REST UI: `admin/config/services/rest` → **jDrupal Connect** → enable `GET` with
  `Accepted request formats: json` and `Authentication providers: cookie` → Save.
- Or config `rest.resource.jdrupal_connect` with
  `configuration: { methods: [GET], formats: [json], authentication: [cookie] }`.

Then grant the permission the `rest` module generates for it:

- Permission machine name: **`restful get jdrupal_connect`** (shown as
  "Access GET on jDrupal Connect resource" under *RESTful Web Services* at
  `admin/people/permissions`). Grant to Anonymous and/or Authenticated as your app needs.
- `drush cr` after changes.

Note: the permission is provided by core `rest` (dynamic per-resource), not by `jdrupal` —
`jdrupal` itself declares no `*.permissions.yml` (`provides_permissions: false`).

## Extending the response — `hook_jdrupal_connect_alter($results)`

Documented in `jdrupal.api.php`. Any module may add keys to the connect JSON:

```php
function my_module_jdrupal_connect_alter(&$results) {
  $results['my_module'] = ['hello' => 'world'];
}
```

The added data is returned inside the same `connect()` payload the JS SDK bootstraps with —
a convenient channel for site settings, feature flags, or extra profile fields the front-end
needs at startup.

## Related core endpoints the SDK also uses

Enable/permit these separately (each with `json` + `cookie`) for a working app:
`user_login` (POST `/user/login`), `user_logout` (GET `/user/logout`),
`entity:node` / `entity:user` / `entity:comment` (`/entity/{type}`, `/{type}/{id}`),
the session token at `/rest/session/token`, and a REST Export view for `viewsLoad()`.
See the README's setup section for the recommended resource/method/permission matrix.
