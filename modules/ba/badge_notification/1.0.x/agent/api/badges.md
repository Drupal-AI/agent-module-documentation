<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badge Notification — async endpoint, plugins & extending

## The JSON endpoint

Route `badge_notification.post` — **`POST /badge-notification/get/json`**, requirement
`_role: authenticated`. Controller `Controller/BadgeNotificationController::json(Request $request)`.

Request body is JSON: `{"badges": {"<id>": {"id","plugin-name","attributes"}, …}}`. For each entry the
controller `createInstance($badge['plugin-name'])` from `plugin.manager.badge_notification` (reusing
instances per plugin name), calls `$plugin->badgeResult($id, $badge['attributes'])`, and — when the
result is truthy — renders `#theme => 'badge_notification'` with `#content => result`. Response:
`{"badges": {"<id>": "<rendered markup>", …}}` (empty results are omitted).

`js/badge-notification.js` (`Drupal.behaviors.badge_notification`) collects every
`.badge-notification-placeholder` in the DOM, reads each element's `data-id` / `data-plugin-name` /
`data-attributes`, POSTs them all in one request to `Drupal.url('badge-notification/get/json')`, then
sets `.html(markup)` on the placeholder whose `data-id` matches each returned key.

## Bundled plugins (`src/Plugin/BadgeNotification/`)

| Plugin id | Class | `has_menu_notification` | `badgeResult()` returns |
|---|---|---|---|
| `node_is_new` | `NodeIsNew` | (no) | `NodeIsNew::getNodeStatus((int) $attributes)` → translated **New** / **Updated** / `''` |
| `views_count_new` | `ViewsCountNew` | true | `BadgeNotificationMenu::viewsCountNew($attributes)` → the integer count (or `''` when 0) |
| `views_has_new` | `ViewsHasNew` | true | translated **New** when count > 0, else `''` |

`attributes` semantics differ by plugin: for `node_is_new` it is a node id; for the Views plugins it is
`view_id/display_id/arg1/arg2…` (parsed by `BadgeNotificationMenu::resolvePluginAttributes()`).
`node_is_new` deps: `database`, `current_user`, `entity_type.manager`, `badge_notification.core`. The
Views plugins depend on `badge_notification.menu` (ViewsHasNew also injects `config.factory`).

## Plugin type & annotation

Manager `Plugin/BadgeNotificationManager` (service `plugin.manager.badge_notification`) scans
`Plugin/BadgeNotification`, interface `BadgeNotificationInterface`, annotation
`Annotation/BadgeNotification` (fields `id`, `label`, `has_menu_notification` default `FALSE`). Alter
hook `hook_badge_notification_badge_notification_info`; cache key
`badge_notification_badge_notification_plugins`. Base class `BadgeNotificationBase` (uses
`StringTranslationTrait`); its default `badgeResult()` returns `"unknown badge handler : @badge_id"`.

## Writing a custom badge plugin

Create `src/Plugin/BadgeNotification/MyBadge.php`:

```php
/**
 * @BadgeNotification(
 *   id = "my_badge",
 *   label = @Translation("My badge"),
 *   has_menu_notification = true
 * )
 */
class MyBadge extends BadgeNotificationBase {
  public function badgeResult(string $badge_id, string $attributes): string {
    // Return a string/int to show, or '' for no badge.
    return (string) my_count($attributes);
  }
}
```

Implement `ContainerFactoryPluginInterface` + `create()` if you need services (see the bundled
plugins). Set `has_menu_notification = true` to make it selectable on the menu-link "Notifications
handlers" field. Render markers by adding elements with class `badge-notification-placeholder` and the
appropriate `data-plugin-name` / `data-attributes` (the extra field and `link_alter` do this for the
bundled plugins), or trigger the JS behavior on your own placeholders.
