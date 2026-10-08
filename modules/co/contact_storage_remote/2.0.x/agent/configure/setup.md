<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Storage Remote — configure

Per contact form: *Structure → Contact forms → Manage → Contact Storage Remote*
(`/admin/structure/contact/manage/{contact_form}/contact-storage-remote`). All routes require
`manage contact_storage_remote contact_form settings`.

Tabs / actions:
- **Info** (`InfoController`) — shows enabled remote-storage plugins for the form.
- **Conditions** (`ConditionsController`) — list; **Add condition** creates a
  `contact_storage_remote_condition` config entity; edit/delete forms manage them. Shipped
  condition: `FieldValue` (send only when a mapped field equals a value).
- **Mail** (`RemoteStorageMailSettingsForm`) — remote mail settings for the form.

Extending:
- Transport plugin: implement `RemoteStoragePluginInterface` / extend `RemoteStoragePluginBase`,
  annotate `@ContactStorageRemoteStorage` (supports `supports_field_mapping`). It receives the
  submitted `contact` Message entity; put any HTTP client, TLS, and credential handling here.
- Condition plugin: annotate `@ContactStorageRemoteCondition`, extend `ConditionPluginBase`.

The base module contains no outbound HTTP client — install/author a transport plugin to
actually deliver submissions.
