# Configure Admin Toolbar Content

One settings form, route `admin_toolbar_content.settings` at
`/admin/config/user-interface/admin-toolbar-content`, gated by `administer site configuration`.
Form class `Drupal\admin_toolbar_content\Form\AdminToolbarContentSettingsForm` (a `ConfigFormBase`
editing `admin_toolbar_content.settings`). The form renders a "Common" tab plus one tab per enabled
`AdminToolbarContent` plugin — each plugin injects its own fields via `buildConfigForm()`. On save,
`submitForm()` moves every plugin's values under the `plugins` key and calls
`menu.link.plugin_manager->rebuild()` so the toolbar picks up the change.

## Config object `admin_toolbar_content.settings`

```yaml
common:
  group_collections: ''          # '' | 'top' | 'bottom'  — push collection items to top/bottom
  hide_empty_collections: false  # hide collection menu items that ended up with no children
plugins:
  content:
    enabled: true
    recent_items:
      number_of_items: 5         # 0 or empty disables the "Recent items" list
      hide_empty_list: false     # drop the "Recent items" divider when the user sees none
      link: default              # 'default'(edit form) | 'view' | 'layout_builder'
    hide_non_content_items: true # strip toolbar items under Content not tied to a content type
    hide_content_type_items:     # checkboxes: value === key means "on"
      content_view: content_view #   hide a type absent from the 'content' view's 'type' filter
      admin_permissions: 0       #   hide a type the user has no admin permission on (uid>1)
  categories:  { enabled: true }
  media:       { enabled: true, link_media_library: true }
  menus:       { enabled: true }
  webform:     { enabled: true }
  drupal:      { enabled: true, account_links: both }  # '' | 'user' | 'edit' | 'both'
```

Note: the runtime reads `plugins.content.recent_items.number_of_items` / `.hide_empty_list` /
`.link` (see `AdminToolbarContentContentPlugin`). The shipped `config/install` file uses the older
keys `limit` / `hide_empty` for the first two; set the schema keys above when configuring by hand.

## Per-plugin options

| Plugin id | Extra config keys | Effect |
|---|---|---|
| `content` | `recent_items.{number_of_items,hide_empty_list,link}`, `hide_non_content_items`, `hide_content_type_items.{content_view,admin_permissions}` | Builds the per-type Content tree; `link` chooses whether recent items point at the edit form, canonical view, or Layout Builder. |
| `media` | `link_media_library` | When true (and `view.media_library.page` exists) the "Media" root links to the Media Library, otherwise to the media admin list. |
| `drupal` | `account_links` | Adds "My account" and/or "Edit my account" under the Drupal icon (`admin_toolbar_tools.help`). |
| `categories`, `menus`, `webform` | `enabled` only | Toggle the Categories / Menus / Webform-submissions top menus. |

A plugin whose `entity_type` (e.g. `media_type`, `webform`) is not installed is auto-skipped by
`AdminToolbarContentPluginBase::isEnabled()` even if `enabled: true`.

## Set it with PHP / Drush

```php
$config = \Drupal::configFactory()->getEditable('admin_toolbar_content.settings');
$config->set('plugins.content.recent_items.number_of_items', 10);
$config->set('plugins.content.recent_items.link', 'view');
$config->set('plugins.media.enabled', FALSE);
$config->save();
// Toolbar links are cached in the menu tree — rebuild after a config change:
\Drupal::service('plugin.manager.menu.link')->rebuild();
```

```bash
drush cset admin_toolbar_content.settings plugins.content.recent_items.number_of_items 10 -y
drush cset admin_toolbar_content.settings plugins.drupal.account_links user -y
drush cr   # rebuild caches / menu links
```

## Config schema

`config/schema/admin_toolbar_content.schema.yml` types `admin_toolbar_content.settings` as a
`config_object`: `common` (mapping) and `plugins` (a `sequence` keyed per plugin, each typed
`admin_toolbar_content.plugin.[%key]`). Base type `admin_toolbar_content.plugin` carries `enabled`;
per-plugin subtypes add `recent_items` (`admin_toolbar_content.recent_items`),
`hide_non_content_items`, `hide_content_type_items`, `account_links` and `link_media_library`.

## Install / update hooks

`admin_toolbar_content.install` ships `admin_toolbar_content_update_9000/9001/9002`, which migrate
pre-2.x flat config into the current `common` + `plugins.<id>` structure and rebuild menu links.
No config is created beyond `config/install/admin_toolbar_content.settings.yml`.
