<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-bundle configuration (node types, comment types, other entities)

Notifications for **node** and **comment** entities are configured **per bundle** using core
third-party settings, NOT the global settings page. All **other** content entity types are enabled
globally via `enabled_target_entity_types` on `entity_notify.settings` (see settings.md).

## Node types

`entity_notify_form_node_type_edit_form_alter()` adds a *Entity Notify* vertical-tab
(`#type => details`, group `additional_settings`) to the node-type edit form
(`/admin/structure/types/manage/<type>`). It adds `entity_notify_enable` and calls the shared
helper `_entity_notify_get_email_form($form, TRUE, $type)` for the channel widgets. An entity
builder `entity_notify_form_node_type_form_builder()` persists each value via
`$type->setThirdPartySetting('entity_notify', <key>, <value>)`.

Keys stored (schema `node.type.*.third_party.entity_notify`): `enable`, `admin`, `roles`
(sequence), `maillist`, `telegram`, `telegram_bottoken`, `telegram_chatids`, `telegram_proxy`,
`telegram_proxy_server`, `telegram_proxy_login`, `telegram_proxy_password`, `telegram_queue`,
`telegram_endpoint`. Access to this form is core's *administer content types*.

## Comment types

`entity_notify_form_comment_type_edit_form_alter()` is the same pattern on the comment-type edit
form, plus an extra `entity_notify_node_author` checkbox ("Send mail to node author"). Builder
`entity_notify_form_comment_type_form_builder()` stores the same keys plus `node_author` (schema
`comment.type.*.third_party.entity_notify`). Access is core's *administer comment types*.

## Other content entity types

Any content entity type selected in the global `enabled_target_entity_types` (settings.md) uses the
**global** channel values from `entity_notify.settings`. There is no per-bundle UI for these; they
share one recipient/channel configuration.

## Precedence in `_entity_notify_event()`

For a node or comment, `_entity_notify_event()` loads the bundle's `NodeType`/`CommentType` and
**overrides** every recipient/channel variable with that bundle's third-party setting. So node and
comment notifications are driven entirely by per-bundle settings; the global channel values are
used only for the "other" entity types. (Note: a node/comment fires when its entity type matches
regardless of the per-bundle `enable` flag — the switch that actually gates delivery is the global
`enable` plus whether any recipient/channel is set.)

## Migration updates

`entity_notify_update_10001` moved pre-existing global node/comment channel config into per-bundle
third-party settings (iterating `entity_type.bundle.info`). `_10002` added `enable: TRUE`; `_10003`
added `ignore_paths: ''`.
