<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jDrupal (jdrupal) — agent index

Browser-side **JavaScript SDK** for talking to Drupal core REST from a decoupled/headless
front-end, delivered as a Drupal module. The module ships two things and nothing else:

1. one asset library — `jdrupal/jdrupal` → `js/jdrupal.min.js` (the SDK global `jDrupal`), and
2. one REST resource plugin — `jdrupal_connect` at `/jdrupal/connect` (current session's uid/name/roles).

Package `Web services`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version `8.x-1.5`
(legacy `8.x-1.x` branch, packaged 2024). Depends on core `node, user, views, serialization,
rest, restui`.

- **The JavaScript SDK surface** (connect, login/logout, token, entity CRUD, Node/User/Comment/Views, module system, utils) and the REST endpoints it calls → [api/sdk.md](api/sdk.md)
- **The server side** (`jdrupal_connect` resource, `hook_jdrupal_connect_alter`, REST-UI + permission setup) → [api/connect-resource.md](api/connect-resource.md)
- **Attaching the `jdrupal/jdrupal` library** to a Drupal-served page → [theming/attach-library.md](theming/attach-library.md)

## What it actually is (and isn't)

- **No PHP admin form, no config schema, no `configure` route, no permissions.yml, no Drush.**
  The module is the JS library + the connect resource. `jdrupal.module` implements only
  `hook_help()` (links to upstream docs). `src/Controller/jDrupalController.php` is an empty stub.
- Verified on the live site: REST plugin `jdrupal_connect` is discovered with canonical
  `/jdrupal/connect`; library `jdrupal/jdrupal` resolves to `js/jdrupal.min.js`.
- The connect endpoint is **disabled until enabled in the REST UI** — an unconfigured site
  returns `404 No route found for GET /jdrupal/connect` (confirmed live). See connect-resource.md.
- All real CRUD is done by **core REST** (`/node/{nid}`, `/entity/node`, `/user/login`,
  `/rest/session/token`, REST Export views). jDrupal is a client for those; enable/permit each
  core resource the front-end needs separately.
- `library_dependencies` is empty — the SDK JS is bundled, not pulled from a CDN or composer.
- Legacy, low-activity project (~93 installs). Canonical SDK reference is the upstream jDrupal
  JS repo, not this module.
