<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Redirect (bundle_redirect) — agent index

Adds a **"URL redirect" vertical tab to the node edit form** for node bundles you enable, listing
and linking to the [Redirect](https://www.drupal.org/project/redirect) module's per-node redirects.
It stores **only a list of enabled bundle machine names**; the Redirect module owns all redirect
data and create/edit/delete flows. Nodes only (no other entity types). Version **2.0.6**.
Core `^8.8 || ^9 || ^10 || ^11`. Package *Other*. License GPL-2.0-or-later.

- **Settings form, config object, permissions, routes, the node-form alter, and the update hook** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **No plugins, no services, no entities.** Two hooks in `bundle_redirect.module` plus one config
  form. Depends on contrib `redirect`.
- `bundle_redirect_form_node_form_alter()` — `hook_form_BASE_FORM_ID_alter`. On an **existing**
  node whose bundle is in `bundle_redirect.settings:node_bundles`, adds a `details` element
  `url_redirect` (`#group => advanced`), gated `#access` by core permission **`administer redirects`**.
  It DB-queries the `redirect` table for redirects pointing at `internal:/node/{nid}`, renders them
  as a table with Edit/delete operations, and adds an *"Add URL redirect to this node"* link into
  Redirect's `redirect.add` route (query: node path, current language, `destination` = node
  edit-form URL). All values are server-derived; the nid is an integer bound via the DB API.
- `bundle_redirect_help()` — help text on `help.page.bundle_redirect`.

## Config / routes / permissions

- Config object **`bundle_redirect.settings`**, single key `node_bundles` (sequence of strings) —
  schema in `config/schema/bundle_redirect.schema.yml`.
- Settings form `Drupal\bundle_redirect\Form\BundleRedirectSettingForm` (checkboxes of node types).
  Route **`bundle_redirect.settings`** at `/admin/config/search/bundle-redirect`
  (`_admin_route`), permission **`access bundle redirect setting form`**
  (`bundle_redirect.permissions.yml`); menu link under *Config → Search and metadata*.
- Update hook `bundle_redirect_update_8101()` (`.install`) bulk-enables **all** node bundles.
