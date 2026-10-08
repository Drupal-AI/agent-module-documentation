<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Storage Remote forwards submissions from core Contact forms to remote/external
systems through a pluggable "remote storage" plugin architecture.

---

The module itself is a framework: it defines a `RemoteStoragePlugin` type
(`plugin.manager.contact_storage_remote.remote_storage`, annotation
`@ContactStorageRemoteStorage`) whose plugins receive a submitted `contact` Message entity and
push it to a destination, with optional per-plugin field mapping and settings forms. Concrete
transport plugins (HTTP/CRM/etc.) are provided by companion modules; this base package ships
the manager, base classes, a field-mapping helper, a mail settings form, and a **conditions**
system (`@ContactStorageRemoteCondition`, config entity `contact_storage_remote_condition`,
with a `FieldValue` condition) so a form's remote push can be limited to submissions matching
field-value rules.

All management routes hang off the contact-form UI at
`/admin/structure/contact/manage/{contact_form}/contact-storage-remote…` and are gated by the
single permission **"manage contact_storage_remote contact_form settings"**. Configure a
contact form: enable one or more remote-storage plugins, map contact fields to the remote
payload, and optionally add conditions that must be met before sending. Any TLS/secret
handling lives in the concrete transport plugin, not in this base module.

---

- Send core contact-form submissions to an external system.
- Enable a remote-storage plugin per contact form.
- Map contact-form fields onto a remote payload.
- Restrict remote sending with field-value conditions.
- Add a condition config entity to a contact form.
- Edit or delete existing remote-storage conditions.
- Configure remote mail settings for a contact form.
- List which remote-storage plugins a form uses.
- Gate all settings behind one dedicated permission.
- Build a custom transport by implementing a remote-storage plugin.
- Build a custom condition via `@ContactStorageRemoteCondition`.
- Only forward submissions matching a chosen field value.
- View remote-storage info for a contact form.
- Combine multiple remote-storage plugins on one form.
- Keep contact submissions in sync with a CRM.
