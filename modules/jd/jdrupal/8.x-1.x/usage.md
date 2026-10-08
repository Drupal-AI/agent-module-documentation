<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jDrupal is a browser-side JavaScript SDK for talking to Drupal's core REST API from a decoupled/headless front-end (SPA, mobile web, Cordova/Ionic app). The Drupal module ships the SDK as an asset library plus one small REST resource, `jDrupal Connect`, that returns the current session's uid/name/roles as JSON.

---

The `jdrupal` module bundles a single minified JavaScript library (`js/jdrupal.min.js`, exposed as the Drupal asset library `jdrupal/jdrupal`) and registers one REST resource plugin, `jdrupal_connect`, at `/jdrupal/connect`. The JS side is a promise-based client: you point it at a Drupal base URL with `jDrupal.config('sitePath', ...)`, then call `jDrupal.connect()` (GET `/jdrupal/connect?_format=json`) to bootstrap the current user, `jDrupal.userLogin()/userLogout()` (POST `/user/login`, GET `/user/logout`) for cookie-session auth, and `jDrupal.token()` (GET `/rest/session/token`) to fetch the session token used on writes. Entity work is done through `jDrupal.Node`, `jDrupal.User`, `jDrupal.Comment` and a generic `jDrupal.Entity`, whose `.load()/.save()/.delete()` methods map to Drupal's REST entity endpoints (`GET /node/{id}?_format=json`, `POST /entity/{type}`, etc.), and `jDrupal.Views` / `jDrupal.viewsLoad()` read a REST Export view. A JS-side module system (`jDrupal.moduleImplements`, `moduleInvokeAll`) lets front-end plugins hook in. Server-side, `jDrupal Connect` is disabled until you enable it in the REST UI (`admin/config/services/rest`) with `GET + json + cookie` and grant the `restful get jdrupal_connect` permission; PHP modules can extend its JSON with `hook_jdrupal_connect_alter()`. The module has no admin form, no config schema, no permissions of its own, and no Drush commands — it is a delivery vehicle for the JS library and the connect endpoint, relying on core `rest`/`serialization`/`restui` for everything else. This is legacy 8.x-1.x code (last release 8.x-1.5, 2024) whose canonical docs live in the upstream jDrupal JS project.

---

- Build a single-page app (Vue/React/vanilla) that reads and writes Drupal content over REST without hand-writing fetch calls.
- Bootstrap a front-end session: call `jDrupal.connect()` on load to learn if the visitor is anonymous or authenticated and what roles they hold.
- Log a user in from JavaScript with `jDrupal.userLogin(name, pass)` against `/user/login?_format=json` (cookie auth).
- Log the current user out from JavaScript with `jDrupal.userLogout()`.
- Fetch the REST session token via `jDrupal.token()` before performing any write (POST/PATCH/DELETE).
- Load a node by id with `jDrupal.nodeLoad(nid)` or `new jDrupal.Node(nid).load()`.
- Create a node from JS by building a `jDrupal.Node`, setting fields, and calling `.save()` (POST to `/entity/node`).
- Update an existing node's title/fields and persist with `.save()` (PATCH).
- Delete a node with `node.delete()` (DELETE `/node/{nid}`).
- Load a user account with `jDrupal.userLoad(uid)` and read `getAccountName()`, `getRoles()`, `hasRole()`.
- Check the current user client-side: `jDrupal.currentUser().isAnonymous()` / `isAuthenticated()`.
- Load and save comments with `jDrupal.commentLoad(cid)` / `jDrupal.Comment`.
- Render a listing by loading a REST Export view with `jDrupal.viewsLoad(path)` and iterating `getResults()`.
- Work with arbitrary entity types generically through `jDrupal.Entity` / `jDrupal.entityLoad(type, id)`.
- Attach entity lifecycle logic on the front end via `preSave`/`postSave`/`preLoad`/`postLoad`/`preDelete`/`postDelete` overrides.
- Add extra data to every `connect()` response from a custom Drupal module using `hook_jdrupal_connect_alter()` (e.g. inject site settings or feature flags).
- Expose the current user's identity to a decoupled front-end without JSON:API, using the lightweight `jdrupal_connect` resource.
- Register front-end "modules" that hook into jDrupal via `jDrupal.moduleImplements()` / `moduleInvokeAll()`.
- Configure the SDK against different environments by switching `jDrupal.config('sitePath', ...)` / `'basePath'`.
- Attach the `jdrupal/jdrupal` library to a Drupal-served page (theme `.info.yml`, `#attached`, or Twig `attach_library`) for a progressively-decoupled widget.
- Power a Cordova/Ionic or PhoneGap mobile app that authenticates and CRUDs Drupal content over cookie-session REST.
- Read entity metadata client-side with helpers like `getEntityType()`, `getBundle()`, `getEntityKey()`, `label()`, `id()`, `language()`.
- Use node status helpers `isPublished()`, `isPromoted()`, `isSticky()`, `isNew()` to drive UI state.
- Serialize a loaded entity for caching or transport with `entity.stringify()`.
- Use the small utility belt (`jDrupal.isEmpty`, `inArray`, `isInt`, `ucfirst`, `lcfirst`, `shuffle`, `time`) inside front-end code.
- Prototype a headless front-end against an existing Drupal 9/10/11 site by enabling only the REST resources the app needs.
