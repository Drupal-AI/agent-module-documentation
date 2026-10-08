# Configure — restricted content types & settings

All state lives in the config object **`onlyone.settings`**.

## Which content types are "Only One"

- UI: `/admin/config/content/onlyone` (route `onlyone.config_content_types`, form
  `ConfigContentTypes`) — tick the content types that should allow only one node per language.
- Stored at `onlyone.settings.onlyone_node_types` — a **sequence of node-type machine names**.

```yaml
# onlyone.settings
onlyone_node_types:
  - homepage
  - landing
onlyone_new_menu_entry: false
onlyone_redirect: true
```

Shipped defaults (`config/install/onlyone.settings.yml`): `onlyone_node_types: {}` (empty),
`onlyone_new_menu_entry: false`, `onlyone_redirect: true`.

## The two settings

Settings form: `/admin/config/content/onlyone/settings` (route `onlyone.admin_settings` — this
is the module's `configure` route, form `OnlyOneAdminSettings`).

| Key | Type | Meaning |
|---|---|---|
| `onlyone_new_menu_entry` | boolean | If true, configured types move to a separate **Add content (Only One)** action link / route `onlyone.add_page` (`/onlyone/add`); the normal *Add content* then lists only the non-restricted types. Toggling it rebuilds routes. |
| `onlyone_redirect` | boolean | When an editor adds a restricted type that already has a node: true → redirect to the existing node's **edit form**; false → to its **canonical** page. |

## Scriptable (drush php:eval / drush cset)

```php
// Restrict the 'homepage' content type.
$cfg = \Drupal::configFactory()->getEditable('onlyone.settings');
$types = $cfg->get('onlyone_node_types');
$types[] = 'homepage';
$cfg->set('onlyone_node_types', array_values(array_unique($types)))->save();
```

```bash
drush cget onlyone.settings onlyone_node_types
drush cset onlyone.settings onlyone_new_menu_entry true -y   # rebuild routes after: drush cr
```

Removing a type: drop it from `onlyone_node_types` (the `onlyone` service's
`deleteContentTypeConfig()` does this; `hook_node_type_delete` also cleans it up when a content
type is deleted).

## No working Drush commands

`onlyone.drush.inc` defines `onlyone-list/enable/disable/new-menu-entry` using the legacy
Drush 8/9 `hook_drush_command` API, which modern Drush (12/13) does not load — these commands
are **not** available. Edit `onlyone.settings` directly (above) instead.
