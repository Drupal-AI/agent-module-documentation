<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notify — transports, consumer fields, routes & config

All Notify configuration is split between **transport config entities** (a delivery channel) and
**per-consumer fields** (who wants what). There is no site-wide settings form of substance.

## Routes & permissions (`headless_cms_notify.routing.yml`)

Every route requires `_permission: administer headless_cms settings`.

| Route | Path | Purpose |
|---|---|---|
| `entity.headless_notify_transport.collection` | `/admin/config/headless-cms/notify/transports` | List transports (`HeadlessNotifyTransportListBuilder`) |
| `entity.headless_notify_transport.add_form` | `…/notify/transports/add` | Add transport |
| `entity.headless_notify_transport.edit_form` | `…/notify/transports/manage/{id}` | Edit transport |
| `entity.headless_notify_transport.delete_form` | `…/notify/transports/manage/{id}/delete` | Delete transport |
| `headless_cms_notify.settings` | `/admin/config/headless-cms/notify/settings` | Info page only |

`HeadlessCmsNotifySettingsForm` (route `headless_cms_notify.settings`) edits the empty
`headless_cms_notify.settings` config object and just renders a link telling you configuration is
done in the *consumer settings*.

## Transport config entity (`headless_notify_transport`)

`src/Entity/HeadlessNotifyTransport.php` — a `ConfigEntityType` with `config_prefix: transport`,
`admin_permission: administer headless_cms settings`. Exported keys: `id`, `label`,
`transport_plugin`, `transport_plugin_configuration`. It implements
`EntityWithPluginCollectionInterface`; the selected plugin is held in a
`HeadlessNotifyTransportPluginCollection` (single lazy collection). `preSave()` and `validate()`
reject a transport with no plugin, or a plugin id that no longer exists.

### Add/edit form (`Form\HeadlessNotifyTransportForm`)

- `label` + machine-name `id`.
- `transport_plugin` — a `select` of all discovered transport plugins, with an **AJAX** callback
  (`ajaxUpdateSettings`) that rebuilds the settings container when you change plugin. If no plugin
  modules are enabled it shows *"No transport plugins available!"*.
- `transport_plugin_configuration` — a `#tree` container into which the plugin's own
  `buildConfigurationForm()` is injected (when the plugin implements
  `Plugin\HeadlessNotifyTransportPluginFormInterface`). Plugin validate/submit are proxied via a
  cloned form-state (`createPluginFormState()` + `moveFormStateErrors/Storage`).

![Add Headless Notify Transport form](../../../../../../../../../screenshots/headless_cms/1.2.x/notify-transport-add.png)

## Per-consumer fields (`headless_cms_notify.basefields.inc`)

Installed onto the `consumer` entity in `headless_cms_notify_install()`; surfaced in the consumer
form's *Additional Settings → Headless CMS → Notify* section by
`headless_cms_notify_form_consumer_form_alter()`.

| Field | Type | Meaning |
|---|---|---|
| `headless_cms_notify_enabled` | boolean | Master switch for this consumer |
| `headless_cms_notify_transport` | entity_reference → `headless_notify_transport` | Which transport delivers this consumer's notifications |
| `headless_cms_notify_notification_types` | list_string (multi) | Which message types to send (options = discovered types) |
| `headless_cms_notify_entity_types` | list_string (multi) | Entity types to watch for `entity_operation` (options from `headless_cms_notify_entity_type_values()`) |

`hook_options_list_alter` rewrites the transport field options to `"<label> (<plugin label>)"`.

## Config object & schema

`config/install/headless_cms_notify.settings.yml` is effectively empty; `config/schema` declares
`headless_cms_notify.settings` (empty mapping) and `headless_cms_notify.transport.*` config-entity
schema. There is no other site-wide setting — the transport entities and consumer fields are the
whole configuration surface.
