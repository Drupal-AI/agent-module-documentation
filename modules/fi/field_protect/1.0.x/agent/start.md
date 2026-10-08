<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Protect (field_protect) — agent index

**Client-side 'unlock' guard over configured entity-form field widgets to prevent accidental edits (UI only).**

- **Version:** 1.0.x
- **Core:** ^9.2 || ^10
- **Depends:** drupal:field
- **Enable per widget:** form-display third-party setting `field_protect.enabled` + `message`.
- **Routes:** `field_protect.settings` (`/admin/config/content/field-protect`, `administer site configuration`, "Forget" button); `field_protect.remember` (POST `/field-protect/remember`, `remember field unlock`).
- **Mechanism:** `hook_field_widget_complete_form_alter` adds an unlock button + JS on edit (not create) forms; unlock decisions stored in state key `field_protect.remembered`.

**Security:** this is a UI-only guard — it implements **no server-side field access** (`hook_entity_field_access`), so it is NOT a permission boundary; a user who can already save the field still can (API/form manipulation). `Remember::invoke` stores the client-supplied `rememberHash` in state unvalidated (permission-gated, low impact — only affects which fields show locked). Warning text is XSS-filtered to plain text. Config/forget route is admin-gated. Use real field-access modules where enforcement matters.

See [configure/protect.md](configure/protect.md).
