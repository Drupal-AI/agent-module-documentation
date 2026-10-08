<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `cml_users` view, the pre-view hook, and install hooks

Sources: `config/optional/views.view.cml_users.yml`, `src/Hook/ViewsPreView.php`,
`synusers.module`, `synusers.install`, `synusers.links.menu.yml`.

## Bundled view — `cml_users`

Shipped as **optional** config (`config/optional/`), so it is imported only when all its declared
dependencies are already present:

```yaml
dependencies:
  config:
    - field.storage.user.field_user_name
    - field.storage.user.field_user_phone
    - field.storage.user.field_user_surname
  module:
    - user
```

Because those three custom user field storages must exist first, the view does **not** install on a
stock site. Key facts:

- `base_table: users_field_data`, `base_field: uid`, label "Users".
- **`default` display** access is `perm` → `administer users`; filters to active users
  (`status = 1`); sorts by `created DESC`; fields: Login, Email, Status, Registered, Last visit.
- **`page` display** (`id: page`) path **`/users`**, 25/page pager. Fields: **Login (name),
  First name (field_user_name), Surname (field_user_surname), Phone (field_user_phone), Email (mail),
  Status (status), Operations**. Extra filters exclude uid 0 and uid 1, plus a grouped exposed
  "Status" (Actively/Blocked) filter (`status_1`).
- The export controller consumes the **`page`** display and drops the `operations` and `status`
  fields, yielding Login/First name/Surname/Phone/Email in the spreadsheet.

If you need the export without the vendor fields, provide your own `cml_users` view with a `page`
display; the controller only requires that id + display to exist.

## `hook_views_pre_view()` — the "Download Excel" link

`synusers.module`'s `synusers_views_pre_view()` delegates to `ViewsPreView::hook()`
(`src/Hook/ViewsPreView.php`). For `view id == 'cml_users'` and `display_id == 'page'` only, it:

- Reads the view's current exposed input (`$view->getExposedInput()`).
- Builds a link with `Link::fromTextAndUrl(new TranslatableMarkup('Download Excel'),
  Url::fromRoute('synusers.page', [], ['query' => $exposedInput]))->toString()` — i.e. a link to
  `/users-xls` carrying the current exposed-filter values as query params.
- Injects it as a `text_custom` **header area handler** (`$view->setHandler('page', 'header',
  'area_text_custom', $options)`) with `content = '<div class="load-xls">' . $link . '</div>'` and
  `empty: TRUE` (shown even when the result is empty).

Net effect: when an operator views the `cml_users` page, a "Download Excel" link appears in the header
that exports exactly the currently filtered list.

## Install / uninstall hooks (`synusers.install`)

- `synusers_install()` → `user_role_change_permissions('editor', ['administer users' => 1])` — grants
  the **`administer users`** permission to the site's **`editor`** role on install.
- `synusers_uninstall()` → the same call with `0` — revokes it on uninstall.
- Operators should be aware this changes the `editor` role's permission set (review after enabling).

## Menu link (`synusers.links.menu.yml`)

Adds `synusers.settings`: title "Users", `menu_name: editor`, `url: internal:/users` — a link to the
view page in the (site-specific) `editor` menu. It is not a settings/config form; the module has no
configuration UI.
