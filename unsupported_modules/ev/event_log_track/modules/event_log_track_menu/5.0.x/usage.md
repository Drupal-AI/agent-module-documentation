<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs custom menu and menu-link create, update and delete events.

---

This submodule of Events Log Track logs menu events. `menu_*` (menu entity) and `menu_link_content_*` hooks log menu and menu-item CUD; a form-submit callback on the menu-link add/edit/delete forms logs `link insert`/`link update`/`link delete`. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `menu` and one of the operations [insert, update, delete, link insert, link update, link delete]. For menus: `ref_char` = menu id. For links: `ref_numeric` = link id, `ref_char` = label/menu. Enable it with `drush en event_log_track_menu -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = menu). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a custom menu is created.
- Log when a menu link is added.
- Log when a menu link is edited.
- Log when a menu link is deleted.
- Log when a menu is renamed or removed.
- Record the `insert` operation on menu in the audit trail.
- Record the `update` operation on menu in the audit trail.
- Record the `delete` operation on menu in the audit trail.
- Record the `link insert` operation on menu in the audit trail.
- Record the `link update` operation on menu in the audit trail.
- Record the `link delete` operation on menu in the audit trail.
- Answer "who changed this menu and when" from the event log.
- Filter the Events Log Track report to just `menu` events.
- See the acting user, IP address and timestamp behind every menu change.
- Build a custom View of menu activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward menu events to external logging.
- Automatically prune old menu logs via the base module's cron-based deletion.
- Exclude noisy menu events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that menu changes are tracked.
- Correlate a menu change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected menu deletion after the fact.
- Measure how often each user performs menu operations.
- Retain a searchable history of menu events for incident response.
