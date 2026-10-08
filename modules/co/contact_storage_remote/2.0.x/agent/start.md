<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Storage Remote (contact_storage_remote) — agent index

**Framework to forward core Contact-form submissions to remote systems via plugins.**

- **Version:** 2.0.x  **Core:** ^10 || ^11  **Depends:** contact
- **Permission:** `manage contact_storage_remote contact_form settings` (gates all routes).
- **Routes:** under `/admin/structure/contact/manage/{contact_form}/contact-storage-remote` — info, conditions (add/edit/delete), mail settings; plus dynamic routes from `src/Routing/Router.php`.
- **Plugin types:** `@ContactStorageRemoteStorage` (transport; `RemoteStoragePluginBase`) and `@ContactStorageRemoteCondition` (`FieldValue` shipped). Config entity: `contact_storage_remote_condition`.
- **Security:** admin-permission-gated config only; this base ships no HTTP transport of its own — TLS/secret posture depends on the concrete remote-storage plugin supplied by a companion module. No anonymous or mutating public endpoints.

See [configure/setup.md](configure/setup.md).
