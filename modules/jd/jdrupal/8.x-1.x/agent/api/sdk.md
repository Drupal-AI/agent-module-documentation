<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jDrupal JavaScript SDK (`jDrupal` global)

Loaded from asset library `jdrupal/jdrupal` (`js/jdrupal.min.js`). Everything hangs off the
global `jDrupal`. Promise-based (native `Promise` + `XMLHttpRequest`). All requests go to
`jDrupal.restPath()` = `sitePath()` + `basePath()`, and REST calls append `?_format=json`.
This is a client for **core REST** endpoints; each must be enabled + permitted server-side.

## Configure / bootstrap

- `jDrupal.config('sitePath', 'https://example.com')` — set the Drupal base URL (getter when
  called with one arg). Also `jDrupal.config('basePath', '/')` (default `/`).
- `jDrupal.sitePath()`, `jDrupal.basePath()`, `jDrupal.restPath()`, `jDrupal.path()` — read paths.
- `jDrupal.isReady()` — true once `sitePath` is set (warns to console otherwise).
- `jDrupal.init()` — resets internal state (session token, `sessid`, `modules`, `connected`,
  `settings`); called automatically on load.

## Session / auth (maps to core endpoints)

- `jDrupal.connect()` → **GET `/jdrupal/connect?_format=json`**. Bootstraps the current user;
  sets `jDrupal.connected = true` and the current user (anonymous when `uid == 0`). Resolves
  with the JSON `{uid, name, roles, ...}`. This is the one endpoint the *module itself* provides.
- `jDrupal.userLogin(name, pass)` → **POST `/user/login?_format=json`** (JSON body). Cookie session.
- `jDrupal.userLogout()` → **GET `/user/logout`**.
- `jDrupal.userPassword(...)` → password-reset request helper.
- `jDrupal.token()` → **GET `/rest/session/token`**. Fetches the REST session token; called
  automatically by `Entity.save()`/`delete()` before writes. Resolves with the token string.
- `jDrupal.currentUser()` → the client-side `jDrupal.User` for the connected account;
  `jDrupal.setCurrentUser(account)`, `jDrupal.userDefaults()`.

## Entities — generic

- `jDrupal.Entity` — base class. Subclass instances carry `entityKeys` (`id`, `label`) and an
  `entity` object of field values.
- `jDrupal.entityLoad(entityType, id)`, `jDrupal.entityConstructorPrep(obj, arg)` (accepts an id
  or a full entity object).
- Instance methods: `load()`, `save()`, `delete()`, `get(field)`, `set(field, val)`, `id()`,
  `label()`, `language()`, `getEntityType()`, `getBundle()`, `getEntityKey(key)`, `getCreatedTime()`,
  `isNew()`, `stringify()`.
- Lifecycle hooks you can override: `preLoad/postLoad`, `preSave/postSave`, `preDelete/postDelete`
  (each returns a Promise).
- REST mapping:
  - `load()` → **GET `/{entityType}/{id}?_format=json`**
  - `save()` on a new entity → **POST `/entity/{entityType}`**; existing → PATCH.
  - `delete()` → **DELETE `/{entityType}/{id}`**.
  Writes call `jDrupal.token()` first and send the session token.

## Entities — typed helpers

- **Node** — `new jDrupal.Node(nidOrObject)`, `jDrupal.nodeLoad(nid)`. Keys: id=`nid`,
  label=`title`. Extras: `getTitle()`, `setTitle(t)`, `getType()`, `isPublished()`,
  `isPromoted()`, `isSticky()`.
- **User** — `new jDrupal.User(uidOrObject)`, `jDrupal.userLoad(uid)`. `getAccountName()`,
  `getRoles()`, `hasRole(role)`, `isAnonymous()`, `isAuthenticated()`.
- **Comment** — `new jDrupal.Comment(cidOrObject)`, `jDrupal.commentLoad(cid)`. Keys: id=`cid`,
  label=`subject`. `getSubject()`, `setSubject(s)`.
- **Views** — `new jDrupal.Views(path)`, `jDrupal.viewsLoad(path)` → loads a **REST Export**
  view by its path; `getView()`, `getResults()`, `getPath()`.

## Front-end module system

- `jDrupal.Module`, `jDrupal.moduleLoad(name)`, `jDrupal.modulesLoad()`, `jDrupal.moduleExists(name)`.
- `jDrupal.moduleImplements(hook)`, `jDrupal.moduleInvoke(module, hook, ...)`,
  `jDrupal.moduleInvokeAll(hook, ...)` — invoke hooks across registered JS modules
  (a browser-side analogue of Drupal's hook system, unrelated to PHP hooks).
- `jDrupal.functionExists(name)`.

## Utilities

`jDrupal.isEmpty(x)`, `jDrupal.inArray(needle, haystack)`, `jDrupal.isInt(x)`,
`jDrupal.ucfirst(s)`, `jDrupal.lcfirst(s)`, `jDrupal.shuffle(arr)`, `jDrupal.time()`.

## Minimal flow

```js
jDrupal.config('sitePath', 'https://example.com');
jDrupal.connect()
  .then(() => jDrupal.userLogin('alice', 'secret'))
  .then(() => jDrupal.nodeLoad(42))
  .then(node => { node.setTitle('Updated'); return node.save(); });
```

Server-side prerequisites: enable + permit the core resources these calls hit — `jdrupal_connect`,
`user_login`/`user_logout`, and the entity resources (`node`, `user`, `comment`, REST Export
views) — each with `json` format and `cookie` auth. See [connect-resource.md](connect-resource.md).
