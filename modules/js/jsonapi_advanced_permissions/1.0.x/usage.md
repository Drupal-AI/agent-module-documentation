<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Advanced Permissions provides advanced dynamic permissions for JSON:API collections based on HTTP methods, so access to JSON:API resources can be gated per method and collection.

---

JSON:API Advanced Permissions adds a layer of dynamic permissions on top of JSON:API: it generates
permissions per collection and per HTTP method (GET, POST, PATCH, DELETE), and gates the corresponding
JSON:API routes behind them via a route subscriber. This lets a site require an explicit permission to,
say, read one resource collection or write another — finer-grained than JSON:API's default reliance on
entity access alone. It depends on core JSON:API and is configured at
`jsonapi_advanced_permissions.settings`.

Use it to lock down a JSON:API surface with method/collection-level permissions (for example, allow
read but require a permission for writes, or restrict certain collections to specific roles). Because
it adds route requirements, it is a fail-closed control: without the required permission the route is
denied. Important scoping note: it governs access to the JSON:API *routes/collections*; it complements,
not replaces, Drupal's underlying entity/field access — keep both correct. It provides its own
permissions.

---

- Gate JSON:API by HTTP method.
- Add per-collection JSON:API permissions.
- Require a permission to read a collection.
- Require a permission to write a resource.
- Restrict JSON:API collections to roles.
- Add route requirements to JSON:API.
- Fail closed without the permission.
- Depend on core JSON:API.
- Configure at the settings form.
- Provide method-level access control.
- Complement entity/field access.
- Lock down a JSON:API surface.
- Generate permissions per collection/method.
- Allow read but gate writes.
- Deny routes lacking the permission.
- Provide its own permissions.
- Scope access to JSON:API routes.
- Keep entity access correct too.
- Control POST/PATCH/DELETE access.
- Harden the API surface.
