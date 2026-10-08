<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Save State attaches JavaScript to selected forms that periodically writes their current field values to the browser's localStorage, letting users recover unsaved input after a reload or crash.

---

An admin picks which form IDs get the behaviour on the settings form at admin/config/user-interface/form-save-state (route form_save_state.admin, perm 'administer site configuration'). For each enabled form ID, hook_form_alter() attaches the form_save_state/save library and passes the normalized form ID in drupalSettings; the front-end JS then autosaves and restores field values via localStorage. All persistence is client-side in the visitor's own browser — nothing is sent to or stored on the server. Because values live in localStorage, be mindful on shared/public computers where another user of the same browser profile could read cached input; avoid enabling it for forms with sensitive data. Use it for long content, webforms, or multi-field admin forms where accidental loss is costly.

---

- Recover a long node body after an accidental page reload.
- Autosave webform answers as a visitor fills them in.
- Protect editors from losing work on large admin forms.
- Restore form input after a browser crash.
- Reduce frustration on multi-step data-entry forms.
- Keep draft field values while a user navigates away and back.
- Enable autosave only for specific high-value form IDs.
- Safeguard contest or application form entries.
- Preserve unsaved comment text across reloads.
- Improve UX on slow connections where submits may fail.
- Avoid re-typing long survey responses.
- Turn on recovery for content types prone to long editing sessions.
- Cut support requests about lost form data.
- Add resilience to forms without server-side draft support.
- Let authors resume editing after a session timeout page.
- Selectively exclude sensitive forms from client-side caching.
