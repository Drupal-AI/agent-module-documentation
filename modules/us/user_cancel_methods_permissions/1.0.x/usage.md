<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Cancel Methods Permissions adds permissions controlling which user cancel methods each role may use.

---

User Cancel Methods Permissions adds a **permission per account-cancellation method** — so you control
which cancel methods (block, block-and-unpublish, delete-and-reassign, **delete account and all content**) each
role is allowed to choose when cancelling an account. It generates one permission (`allow user cancel method
X`) per method, in the Administration package.

Use it to restrict destructive cancel methods to trusted roles. This is a **security-positive** access-control
hardening: by default the cancel form offers all methods, so a user could pick the most destructive one; this
gates each method behind a permission. It is implemented correctly — `hook_user_cancel_methods_alter()` sets
each method's `access` from `hasPermission('allow user cancel method X')`, so methods the user lacks permission
for are hidden/denied. Two intentional exceptions: the site's **default** cancel method is always allowed
(users always have a way to cancel), and the check is **skipped on the admin account-settings form**
(`entity.user.admin_form`, already admin-gated) so admins can set the default. It adds these permissions and
nothing else. Grant the method permissions per role.

---

- Add a permission per cancel method.
- Control which methods a role may choose.
- Gate destructive cancel methods.
- Generate allow user cancel method X perms.
- Restrict delete-account-and-content.
- Harden account cancellation.
- Set each method's access from the permission.
- Always allow the default method.
- Skip the admin settings form (admin-gated).
- Grant method permissions per role.
- Add these permissions and nothing else.
- Handle cancel-method access.
- Restrict cancel methods.
- Configure the permissions.
- Gate cancellation.
- Secure account deletion.
- Handle the permissions.
- Limit cancel methods.
- Configure per role.
- Provide method permissions.
