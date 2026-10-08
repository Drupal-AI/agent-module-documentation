Allow a content type only once (Only One) restricts selected content types to a single node **per language**: once that node exists, adding another of that type sends the editor to edit the existing one instead.

---

You choose which content types are "Only One" on the config page `/admin/config/content/onlyone`
(route `onlyone.config_content_types`); the list is stored as `onlyone.settings.onlyone_node_types`
(a sequence of content-type machine names). Enforcement is a validation constraint: the module
adds an `OnlyOne` entity constraint to the `node` entity type (`hook_entity_type_alter`), whose
validator blocks saving a second node of a configured type in the same language. When an editor
opens *Add content* for a configured type that already has a node, a node-form alter redirects
them to the existing node's edit form (or its canonical page, depending on the
`onlyone_redirect` setting). A settings page `/admin/config/content/onlyone/settings` (route
`onlyone.admin_settings`, the module's `configure` route) offers two options:
`onlyone_new_menu_entry` (move configured types into a separate "Add content (Only One)" menu
entry / route `onlyone.add_page`) and `onlyone_redirect` (redirect to edit form vs. canonical).
The counting is language-aware and uses the `onlyone` service. A single permission, *administer
onlyone*, gates both admin forms. A bundled submodule, `onlyone_admin_toolbar`, keeps the Admin
Toolbar Tools menu in sync. Note: the shipped `onlyone.drush.inc` uses the legacy Drush 8/9
command API and is **not** available under the site's Drush 12/13 — configure via the UI or the
`onlyone.settings` config instead.

---

- Guarantee exactly one "Homepage" node exists so editors edit it instead of creating duplicates.
- Keep a single "Site settings" or "Contact page" node per site.
- Enforce one "About us" page per language on a multilingual site.
- Prevent accidental duplicate landing pages for a one-off content type.
- Redirect editors straight to the existing node's edit form when they click "Add".
- Alternatively send them to the existing node's canonical page (via `onlyone_redirect: false`).
- Move singleton content types into a dedicated "Add content (Only One)" action link.
- Show a validation error if a second node of a restricted type is saved in the same language.
- Allow one node per language while still permitting a translated copy in each other language.
- Configure the restriction per content type with checkboxes on the Only One page.
- Manage the restricted-types list as deployable `onlyone.settings` config.
- Model a "singleton" content type (e.g. a global banner) without custom code.
- Ensure a "Privacy policy" content type can only ever hold one node.
- Keep the standard "Add content" list showing only non-restricted types.
- Automatically clean up the config when a content type is deleted (`hook_node_type_delete`).
- Gate who can change the restriction with the *administer onlyone* permission.
- Combine with Admin Toolbar (via the submodule) to label configured types "(Edit)" in the menu.
- Provide editors a clear message that only a single node can be created for a type.
- Use the `onlyone` service to check whether a content type already has a node in a language.
- Drive companion behavior by subscribing to the `onlyone.content_types_updated` event.
- Reduce editorial errors on content types that are meant to be unique.
- Apply the rule site-wide by adding the constraint to the node entity type automatically.
