<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Menu — agent index

Logs custom menu and menu-link create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `menu` | insert, update, delete, link insert, link update, link delete |

## How it logs

`menu_*` (menu entity) and `menu_link_content_*` hooks log menu and menu-item CUD; a form-submit callback on the menu-link add/edit/delete forms logs `link insert`/`link update`/`link delete`.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. For menus: `ref_char` = menu id. For links: `ref_numeric` = link id, `ref_char` = label/menu.

## Enable & view

```bash
drush en event_log_track_menu -y
```
View at `/admin/reports/events-track` (filter Type = menu), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='menu' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
