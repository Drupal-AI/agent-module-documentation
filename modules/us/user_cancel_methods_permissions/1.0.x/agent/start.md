<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Cancel Methods Permissions — agent index

Adds a **permission per account-cancellation method** (control which methods — block / delete-and-reassign /
**delete account and all content** — each role may choose). Version **1.0.1**. Core `^8||^9||^10||^11`.

**Security-positive** access-control hardening. Correctly implemented: `hook_user_cancel_methods_alter()` sets
each method's `access` from `hasPermission('allow user cancel method X')`. Intentional exceptions: the site's
**default** method is always allowed, and the check is skipped on the admin-gated `entity.user.admin_form`. No
other behavior.
