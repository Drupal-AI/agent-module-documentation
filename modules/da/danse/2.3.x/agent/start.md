<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DANSE (danse) — agent index

**D**rupal **A**udit **N**otification **S**ubscription **E**vent: an event-driven framework where
"something noticeable" is recorded as a `danse_event` content entity, users subscribe to references
of those events (stored in `user.data`), and matching subscribers/recipients get `danse_notification`
entities (shown on-site, pushable, emailable). Extensible via two plugin types. PHP >= 8.1, core
`^10.3 || ^11`, no non-core dependencies (base module).

Settings: `/admin/config/system/danse` (route `danse.settings`, perm `administer site configuration`).
Per-user subscriptions: `/user/{user}/subscriptions` (own user only). Cron creates notifications and prunes.

Ships 8 submodules (enable only the event sources you need):

| Submodule | @Danse plugin id | Source |
|---|---|---|
| `danse_content` | `content` | create/update/delete/publish/unpublish of any content entity + comments |
| `danse_config` | `config` | config entity save |
| `danse_log` | `log` | log/watchdog entries |
| `danse_user` | `user`, `role` | user events + role/permission changes |
| `danse_form` | `form` | form submissions |
| `danse_generic` | `generic` | arbitrary/custom events (service `danse_generic`) |
| `danse_webhook` | `webhook` | inbound REST endpoint creates events (POST `/api/danse-webhook`, basic_auth) |
| `eca_danse` | — | ECA event + `eca_recipient_selection` recipient plugin |

What you'd do:
- **Configure the settings form (tabs, recipient plugins, prune policy)** → [configure/settings.md](configure/settings.md)
- **Understand the user routes, views, blocks and subscribe widget** → [configure/user-subscriptions.md](configure/user-subscriptions.md)
- **Call the public services / event-creation APIs / integration hooks** → [api/services.md](api/services.md)
- **Read the event/notification entities, their fields and storage** → [api/entities.md](api/entities.md)
- **Add a new event source plugin** → [plugins/event-sources.md](plugins/event-sources.md)
- **Add / choose a recipient-selection plugin** → [plugins/recipient-selection.md](plugins/recipient-selection.md)
- **Run the Drush commands** → [drush/commands.md](drush/commands.md)

Key facts:
- Config object: `danse.settings` (keys `subscriptions_as_tab.{events,view,expand}`,
  `recipient_selection_plugin.<pluginId>`, `prune.<pluginId>.{type,value}`). Schema provided.
- Services: `danse.service`, `danse.query`, `danse.cron`; plugin managers
  `plugin.manager.danse.plugin`, `plugin.manager.danse.recipient.selection`.
- Plugin types: `@Danse` (event sources, `Plugin/Danse`) and `@DanseRecipientSelection`
  (`Plugin/DanseRecipientSelection`). Alter hooks `danse_info`, `danse_recipient_selection_info`.
- Content entities: `danse_event`, `danse_notification`, `danse_notification_action` (all `internal`,
  admin perm `administer site configuration`).
- Subscriptions stored in `user.data` under module `danse`, name = subscription key, value 0/1.
- State key `danse.event_tracking.paused`; `Settings::get('danse_notification_delivery', TRUE)`.
- Drush: `danse:notifications:create` (`dnc`), `danse:event-tracking:status|pause|resume`.
- No module-defined permissions; all admin surfaces reuse core `administer site configuration`.
