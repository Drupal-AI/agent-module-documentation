<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badge Notification — install, settings & operation

## Install / enable

`drush en badge_notification -y`. Pulls in core **`history`**, **`views`**, **`menu_ui`** (declared in
`badge_notification.info.yml`). No composer requirements beyond core. Enabling attaches the JS library
to every authenticated page (`badge_notification_page_attachments()` → library
`badge_notification/badge_notification.assets`); anonymous users get nothing.

## Settings form

Route `badge_notification.admin.settings` → **`/admin/config/content/badge-notification`**
(`Form/BadgeNotificationSettingsForm`, permission **`administer badge notification`**; menu link under
*Configuration → Content authoring*). Writes config object **`badge_notification.settings`**:

- `days_limit` (number, **1–30**, default **7**) — "Maximum content age to display status (days)".
  Validated in `validateForm()` against `DAYS_LIMIT_MIN`/`DAYS_LIMIT_MAX`; non-numeric or out-of-range
  → form error. Stored raw (the `#attributes` min/max are advisory HTML only).
- `status_display` (checkboxes) — `new` / `updated`. Default `{new: 'new', updated: 0}`.

No `config/schema/` is shipped, so this config is **not schema-validated** on export. There is no
`config/install/` default; `BadgeNotificationCore` falls back to `days_limit = 7` and
`status_display = {new: 'new', updated: 0}` when the object is absent.

`Service/BadgeNotificationCore` reads this config in its constructor and exposes:
`getStatusDisplay(): array` and `getTimeLimit(): int` — the latter is
`strtotime('-{days_limit} day', requestTime)`, the cut-off used everywhere.

## Node status marker (node_is_new)

`hook_entity_extra_field_info()` adds a hidden display extra field
`badge_notification_placeholder` labelled **"Content status"** to **every** node bundle (invisible by
default). Enable it per view-display on *Manage display*. `badge_notification_node_view()` then emits a
`<div class="badge-notification-placeholder" data-plugin-name="node_is_new" data-attributes="{nid}">`
container. The JS fills it via the JSON endpoint (see [../api/badges.md](../api/badges.md)).

`NodeIsNew::getNodeStatus($nid)` loads the node, then:
- returns **"New"** when `status_display['new']` and the user has **no** `history` row for it and
  `getCreatedTime() > timeLimit`;
- returns **"Updated"** when `status_display['updated']` and `getChangedTime()` is newer than the
  user's `history` timestamp **and** `> timeLimit`;
- otherwise `''` (no badge).

Last-viewed time comes from `getNodeLastViewed()`:
`SELECT timestamp FROM {history} WHERE uid = :uid AND nid = :nid` (parameterised). Core writes to
`history` on each node view, so markers self-update. Note: `getNodeLastViewed()` uses
`drupal_static(__METHOD__)` **without keying by nid**, so within one request the first looked-up nid's
timestamp is reused for later nodes — a correctness bug when several markers render in one request.

## Menu-link count badges (views_count_new / views_has_new)

Editing a menu link (`hook_form_menu_link_content_form_alter`, gated by
`administer badge notification`) adds a multiple-select **"Notifications handlers"** built by
`BadgeNotificationMenu::getHandlersOptions()`. Options are `{plugin_id}::{view_id}[::{display_id}]`
for every plugin whose annotation sets `has_menu_notification = true` (i.e. `views_count_new`,
`views_has_new`) crossed with every enabled View whose `base_table === 'node_field_data'`. The
selection is stored in the menu link's `link.options['badge_notification']`
(`badge_notification_menu_link_content_form_submit`).

`hook_link_alter()` renders, for each stored handler, a placeholder span (built by
`renderMenuLinkcontentPlaceholderAttributes()`, which sets `data-plugin-name` to the plugin id and
`data-attributes` to the remaining `view_id/display/args` joined by `/`) and appends it to the link
text via `FormattableMarkup` (the link text is passed as an escaped `@text` placeholder).

`BadgeNotificationMenu::getView()` resolves the attributes (`resolvePluginAttributes()` splits on `/`
into id/display/arguments), runs `Views::getView($id)`, sets `views_count_new = TRUE`, applies the
display + arguments, executes, and returns the executable; `viewsCountNew()` returns
`$view->total_rows`. `views_count_new` renders that number; `views_has_new` renders the translated
**"New"** when the count is non-zero.

`hook_views_query_alter()` acts only on views carrying the `views_count_new` marker (and only for
authenticated users): it adds `node_field_data.created >= timeLimit` and, when the user has history
rows, `node_field_data.nid NOT IN (…viewed nids…)` — so the count reflects recent, unseen nodes.

## Theme / markup

Theme hook `badge_notification` (`templates/badge-notification.html.twig`) is
`<span {{ attributes }}>{{ content }}</span>` (default attributes classes `marker badge`).
`{{ content }}` is auto-escaped by Twig; badge results are translated `New`/`Updated` strings or an
integer count.
