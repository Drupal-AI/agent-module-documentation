<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Redirect — configuration, form, hooks

Everything the module does lives in `bundle_redirect.module` (2 hooks), one settings form, one
config object, one route, one permission, and one update hook. Requires contrib **`redirect`**
(`^1.9`, `redirect:redirect` in `bundle_redirect.info.yml`).

## Install / enable

```
composer require drupal/bundle_redirect   # pulls drupal/redirect ^1.9
drush en bundle_redirect -y
```

## Config object `bundle_redirect.settings`

Schema (`config/schema/bundle_redirect.schema.yml`): `config_object` with one key:

- `node_bundles` — `sequence` of `string` (node type machine names that get the redirect tab).

Nothing else is stored. There is **no** redirect destination, target host, or path in this config —
redirect records themselves belong to the Redirect module's `redirect` table.

Example export:

```yaml
# bundle_redirect.settings.yml
node_bundles:
  article: article
  page: page
```

## Settings form — `BundleRedirectSettingForm`

`src/Form/BundleRedirectSettingForm.php` (extends `ConfigFormBase`).

- `getFormId()` → `bundle_redirect_settings`; `getEditableConfigNames()` → `['bundle_redirect.settings']`.
- `buildForm()` — loads `NodeType::loadMultiple()` into a `checkboxes` element `node_bundles`
  (default from config). If no node types exist it shows a warning with a link to `node.type_add`
  and returns an empty form.
- `submitForm()` — saves `array_filter($values['node_bundles'])` (drops unchecked boxes) to
  `node_bundles` and adds a "Configs have been saved." message.
- Route **`bundle_redirect.settings`** (`bundle_redirect.routing.yml`): path
  `/admin/config/search/bundle-redirect`, `_admin_route: TRUE`, requirement
  `_permission: 'access bundle redirect setting form'`. Menu link
  (`bundle_redirect.links.menu.yml`) under `system.admin_config_search`.

## Permissions (`bundle_redirect.permissions.yml`)

- `access bundle redirect setting form` — gates the settings route above (choose which bundles get
  the tab). This is the only permission the module defines.
- The node-form redirect tab is separately gated by core Redirect's **`administer redirects`**
  (see below).

## Node form alter — `bundle_redirect_form_node_form_alter()`

`hook_form_BASE_FORM_ID_alter` on `node_form`. Guards, in order:

1. Reads `bundle_redirect.settings:node_bundles`; returns if empty or the current node's bundle is
   not enabled.
2. Returns if `$node->isNew()` — the tab appears only when **editing an existing** node.
3. Adds `$form['url_redirect']` (`#type => details`, `#group => 'advanced'`, `#weight => 100`) with
   `#access => \Drupal::currentUser()->hasPermission('administer redirects')` — users without that
   permission never see it.

It then selects from the `redirect` table (Drupal DB API, `orConditionGroup` on
`redirect_redirect__uri` = `internal:/node/{nid}` or LIKE `%internal:/node/{nid}?%`, ordered by
`redirect_source__path`), builds a table via helper `bundle_redirect_list_table()`, and appends an
*"Add URL redirect to this node"* link to Redirect's `redirect.add` route with query params:
`redirect` = `/node/{nid}`, `language` = current language id, `destination` = node edit-form URL.

`bundle_redirect_list_table($redirect_list, $header, $destination, $lang)` renders each row's source
path as a `Link` and an `operations` element with Edit
(`/admin/config/search/redirect/edit/{rid}`) and delete
(`/admin/config/search/redirect/delete/{rid}`) links, each carrying `language` and `destination`
query params. All URLs/IDs are server-derived (the node id is an integer, the rid comes from the
DB); redirect create/edit/delete is handled entirely by the Redirect module and its access checks.

## Update hook (`bundle_redirect.install`)

`bundle_redirect_update_8101()` — sets `node_bundles` to **every** node type machine name
(`NodeType::loadMultiple()`), i.e. enables the redirect tab site-wide on update. Run with
`drush updatedb`.

## Operating notes

- The tab is invisible on node **creation**; save the node first, then re-edit to manage redirects.
- Extending to non-node entities requires custom code — only `node_form` is altered.
- Uninstalling removes `bundle_redirect.settings` but leaves Redirect's redirect records intact.
