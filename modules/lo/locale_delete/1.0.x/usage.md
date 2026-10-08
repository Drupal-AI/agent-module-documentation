<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a delete action for individual interface-translation strings, which Drupal core's Translate interface does not offer.

---

Core lets you edit interface translations but not remove a source string and its translations. This module adds a confirmation route `/admin/config/regional/translate/delete/{lid}` (permission `use locale delete`) backed by a `ConfirmFormBase`. Confirming deletes the row from `locales_source` and all matching rows from `locales_target` for that `lid`, logs the action, and returns to the Translate page. Queries are parameterized and the delete is protected by the standard confirm-form flow (CSRF token + explicit confirmation step).

Setup is just enabling the module and granting `use locale delete` to trusted translation admins; link to the delete route by `lid` from your own listings, or reach it directly. There is no batch/bulk UI — one string at a time.

---

- Permanently delete an interface-translation string that core only lets you edit.
- Remove an obsolete or wrong source string from `locales_source`.
- Delete all translations of a string from `locales_target` in one action.
- Reach the delete confirm form at `/admin/config/regional/translate/delete/{lid}`.
- Grant `use locale delete` to trusted translation administrators.
- Confirm the deletion via the standard confirm-form (CSRF-protected) step.
- See the source text in the confirmation question before deleting.
- Get a status message and a log entry after each deletion.
- Return automatically to the core Translate page after deleting.
- Link to the delete route by `lid` from a custom translations listing.
- Clean up leftover strings after removing a module or feature.
- Tidy the interface-translation database of stale entries.
- Restrict destructive translation deletion to a dedicated permission.
- Use it alongside core's Translate UI as the missing delete action.
- Verify the deleted string's source text via the logged notice afterwards.