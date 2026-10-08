<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CAS User Ban VBO adds a Views Bulk Operations user-cancel action that can also ban the selected CAS usernames.

---

CAS User Ban VBO is a submodule of CAS User Ban that brings the "ban on cancel" behaviour to Views Bulk
Operations. It registers a VBO action plugin (`cas_user_ban_vbo_cancel_user_action`) that extends VBO's own
Cancel User Action and, by reusing the parent module's UserCancelFormsTrait, adds a checkbox to the action's
configuration form so that, when the selected accounts are cancelled from a bulk-operations view, their CAS
usernames are also added to the ban list. It requires both cas_user_ban and views_bulk_operations. The
maintainers recommend selecting this action instead of VBO's default cancel action so that bulk cancellation and
CAS banning happen together.

---

- Cancel many user accounts at once from a VBO-enabled view and ban their CAS usernames in the same operation.
- Add the CAS ban option to the admin/people bulk-operations workflow when using a VBO view.
- Prevent bulk-cancelled CAS users from regenerating their accounts on next login.
- Choose, per bulk operation, whether or not to also ban the selected usernames.
- Reuse VBO's standard cancel-user options (reassign / delete content) alongside the ban checkbox.
- Replace VBO's built-in "Cancel user account" action with the CAS-aware equivalent.
- Skip banning the current user automatically, even if selected in the bulk set.
- Only ban selected accounts that actually have an associated CAS username.
- Integrate CAS banning into custom Views that expose bulk user operations.
- Combine bulk deletion of spam accounts with permanent CAS-identity banning.
