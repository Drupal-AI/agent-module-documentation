Adds CSS classes to the HTML `<body>` element based on the current user's roles, so themes and CSS can target logged-in users by role (e.g. `role-editor`) plus an authenticated/anonymous marker.

---

Via `hook_preprocess_html`, the `RoleClassGenerator` service reads the current user's roles
and appends one class per role to `<body>`, each built as `prefix + role`, lowercased with
underscores turned into hyphens and run through `Html::cleanCssIdentifier()`. It also always
adds `user-authenticated` or `user-anonymous`. Behaviour is controlled by a simple config
object (`body_roles_classes.settings`): `enabled` (master switch), `prefix` (default `role-`),
`exclude_roles` (roles to omit from output — useful for hiding sensitive roles such as
`administrator`, which is excluded by default), and `role_map` (per-role class-name
overrides). The output cache is varied by the `user.roles` cache context. A settings form at
`/admin/config/user-interface/body-roles-classes` exposes enable/prefix/exclude. There are no
Drush commands. (Note: the settings route is gated behind a permission that the module does
not actually define, so out of the box only the superuser can open the form — see the
configure doc.)

---

- Style the site differently for editors vs. authenticated vs. anonymous users via CSS only.
- Add a `role-administrator`-style class to `<body>` for admin-only visual cues (if not excluded).
- Show or hide front-end UI elements based on the visitor's role using CSS.
- Give a distinct look to a "premium"/"member" role's pages.
- Add a `user-authenticated` / `user-anonymous` body class for login-state styling.
- Prefix all role classes (e.g. `role-`) to avoid collisions with other body classes.
- Exclude sensitive roles from the markup so they are not exposed in the front-end HTML.
- Rename a role's emitted class via the role map (e.g. map `content_editor` → `editor`).
- Drive JavaScript behaviour off a role class present on `<body>`.
- Theme the toolbar or admin regions conditionally by role.
- Provide role-based print or email-template styling hooks.
- Target a specific role in a subtheme's CSS without writing a preprocess hook yourself.
- Keep role styling cache-correct automatically (varies by `user.roles`).
- Toggle the whole feature off site-wide with a single `enabled` switch.
- Normalise role machine names into valid, hyphenated CSS identifiers automatically.
- Combine with a component library to expose role-scoped variants.
- Quickly prototype role-gated visual states during design/QA.
