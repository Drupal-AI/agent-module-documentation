<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Status Popup turns the user edit form's status field into a primary/danger button (Block or Activate) that opens an AJAX modal confirm form, and exposes a Views field rendering the same action links.

---

Both status-change routes (`/admin/user/{user}/status/block` and `.../active`) require the `administer users` permission and use standard `ConfirmFormBase` forms, so CSRF and access are handled by core. The button and Views field are only rendered for users who already hold `administer users`. The confirm forms return to the referring page.

---

- Block a user account from a modal without leaving the user edit form.
- Activate a blocked user with a one-click confirmation dialog.
- Show account status (Blocked/Activated) inline as a labelled button.
- Add a status-action column to an administrative user View.
- Bulk-triage sign-ups from a Views listing of accounts.
- Give moderators a faster block/activate workflow than the core checkbox.
- Present status changes as an explicit confirm step to avoid mistakes.
- Keep the native status checkbox hidden while preserving its behaviour.
- Surface pending/blocked users in a custom admin dashboard View.
- Confirm destructive account changes via a themed modal.
- Restrict the action to holders of `administer users`.
- Integrate account moderation into an existing Views-based user report.
- Provide quick approve/reject links on a registration-review screen.
- Use the AJAX modal to stay on the current page after the change.
- Theme the action markup via the provided `user-status-action` template.
- Pair with User Registration Limit to manage a bounded membership.
