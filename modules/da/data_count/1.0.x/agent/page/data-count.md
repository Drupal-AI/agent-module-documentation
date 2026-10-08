<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Count — the page, counting helpers, and theming

## Install / enable

`drush en data_count -y`. No configuration step follows — there are no settings, no config
objects, and no permissions to grant beyond core's existing **`administer site configuration`**.
Visit **Reports > Data Count** (`/admin/reports/data-count`).

## Route & access

`data_count.routing.yml` defines one route:

- `data_count.admin_link` — path `/admin/reports/data-count`, `_title: 'Data Count'`,
  `_controller: '\Drupal\data_count\Controller\DataController::dataCount'`,
  `requirements: _permission: 'administer site configuration'`.

`data_count.links.menu.yml` adds the menu link under `system.admin_reports` (weight 0). No local
tasks/actions.

## Controller

`src/Controller/DataController.php`, `DataController extends ControllerBase`:

```
dataCount(): returns
  ['#theme' => 'data_count',
   '#data' => ['nodes' => data_count_node(), 'users' => data_count_user()],
   '#attached' => ['library' => ['data_count/count-style']]]
```

It only assembles data and hands it to the theme; all counting is in `data_count.module`.

## Counting helpers (data_count.module)

- **`data_count_node()`** — `NodeType::loadMultiple()`; for each content type computes
  `published` = `data_count_node_wise(id, 1)`, `unpublished` = `data_count_node_wise(id, 0)`,
  `sum` = published+unpublished, accumulates grand totals, and returns
  `['items' => [type => {name,published,unpublished,sum}], 'total' => [pub, unpub, all]]`.
- **`data_count_node_wise($type, $status)`** — `select('node_field_data','nfd')`, condition on
  `nfd.type = $type` and `nfd.status = 1|0`, `countQuery()->execute()->fetchField()`.
- **`data_count_user()`** — `Role::loadMultiple()`, **skips `anonymous` and `authenticated`**; for
  each remaining role computes `active` = `data_count_role_wise(id,1)`, `inactive` =
  `data_count_role_wise(id,0)`, `sum`. Returns `items` keyed by role plus a `total` triple.
- **`data_count_role_wise($role, $status)`** — `select('users_field_data','ufd')` left-joined to
  `user__roles ur` on `ufd.uid = ur.entity_id`, condition `ur.roles_target_id = $role` and
  `ufd.status = 1|0`, counted. (A user with multiple roles is counted once per role.)
- **`data_count_users_sum($role, $status)`** — site-wide user count by status; for inactive it also
  requires `ufd.uid <> 0` to exclude the anonymous row. `$role` is accepted but unused here.

Note (behavioral, not a bug to fix here): the `total` triple in `data_count_user()` is produced by
`data_count_users_sum()`, which counts **all** users by status regardless of role — so the user
grand totals are site-wide, while the per-row figures are per-role and may overlap (multi-role
users) or exclude role-less users. All queries use the DB API query builder with bound conditions.

## Theming & assets

- `hook_theme()` registers `data_count` (variable `data`) → `templates/data-count.html.twig`.
  The template renders two panels, "Node Count Details" and "User Count Details", each a table
  built from `data.nodes` / `data.users`; each number is an `<a href>` into
  `admin/content?type=…&status=…` or `admin/people?status=…&role=…`. Shows "No data available."
  when there are no node items. Twig auto-escapes the printed values.
- Library `data_count/count-style` (`data_count.libraries.yml`): `css/count.css` +
  `js/count.js` (deps `core/drupal`, `core/jquery`). `js/count.js` registers
  `Drupal.behaviors.data_count`, toggling `.node-details` / `.user-details` visibility and a
  `btn-effect` class when the `#node-count` / `#user-count` spans are clicked.

## Operating notes

- Purely read-only and computed at request time — nothing is stored or cached; refresh to update.
- To see any user rows, create at least one **custom** role and assign accounts to it (the two
  built-in roles are intentionally excluded from the per-role table).
- `hook_help()` supplies About/Steps text on `help.page.data_count`.
