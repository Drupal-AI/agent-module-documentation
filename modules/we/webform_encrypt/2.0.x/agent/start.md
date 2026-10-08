<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Encrypt — agent index

Encrypts individual **Webform element** values at rest via an **Encrypt** encryption profile.
No admin settings page, **no configure route** (`configure: null`). All state is a per-element
third-party setting on the webform plus two swapped `webform_submission` handlers (storage +
access). Requires `webform` and `encrypt`; an encryption profile (and its Key) must already exist.

- **Turn encryption on for an element / where the setting is stored / drush** →
  [configure/encrypt-elements.md](configure/encrypt-elements.md)
- **Runtime mechanism: storage handler, serialized `{data, encrypt_profile}`, decrypt gating** →
  [api/storage-handler.md](api/storage-handler.md)
- **The `view encrypted values` permission and the update-access rule** →
  [permissions/permissions.md](permissions/permissions.md)

Key fact: the setting lives at
`webform.webform.<id>` → `third_party_settings.webform_encrypt.element.<element_key>` =
`{encrypt: true, encrypt_profile: <profile_id>}`. Read/write it with
`$webform->getThirdPartySetting('webform_encrypt', 'element')` /
`setThirdPartySetting(...)`.
