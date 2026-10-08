<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Protect guards individual entity-form field widgets so editors can't change them by accident: a protected field is visually locked and must be explicitly "unlocked" (after reading a warning) before it can be edited.

---

Protection is enabled per widget via a form-display third-party setting (`enabled` + a warning `message`). On the entity edit form (not on entity creation) `hook_field_widget_complete_form_alter()` injects an "Unlock field" button, a `field-protected` CSS class, and a JS behaviour; the warning message is XSS-filtered to plain text. If the editor holds the `remember field unlock` permission, a per-user/field hash (`Crypt::hashBase64` of message+entity-type+bundle+field+uid) is passed to JS, and a POST to `/field-protect/remember` records that hash in Drupal `state` so the field shows unlocked next time. A settings form (`/admin/config/content/field-protect`, `administer site configuration`) offers a "Forget" button that clears all remembered unlocks.

Security note: this is a **UI-only, client-side** guard against accidental edits — it does NOT implement `hook_entity_field_access` or any server-side field access control, so it must not be relied upon to prevent unauthorised viewing or writing of a field; anyone who could already save the field can still save it (e.g. via API, or by manipulating the form). The remember endpoint (`Remember::invoke`, POST, `remember field unlock`) writes the request-supplied `rememberHash` into state without validating it, so a permission-holder can inject arbitrary hashes; impact is limited to which fields appear locked in the UI. Treat Field Protect as an ergonomics feature, not a permission boundary.

---
- Enable protection on a specific field widget in a form display
- Set a custom warning message shown before unlocking
- Prevent accidental edits to critical fields (e.g. SKU, price)
- Require an explicit click to unlock a field for editing
- Show a lock icon/summary in the form-display settings summary
- Skip protection automatically on entity-creation forms
- Grant `remember field unlock` to let editors dismiss the guard
- Persist a per-user unlock decision via `/field-protect/remember`
- Clear all remembered unlocks with the "Forget" admin button
- Re-lock all fields site-wide after a policy change
- Reinforce editorial care around high-impact fields
- Combine with real field-access modules for actual access control
- Customise the lock styling via the module's CSS library
- Localise the warning message per field
- Protect date/reference fields that trigger downstream logic
- Reduce support tickets from fat-finger field edits
- Show a lock summary badge in the form-display UI
- Keep protection off for brand-new entities automatically
