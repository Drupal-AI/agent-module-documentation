<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Approval Dashboard - agent index

**Approve/activate pending user accounts** from a Views dashboard + confirmation form. Version **2.0.0**, core `^9 || ^10`. Submodule: `user_export`.

- Form route `user_approval_dashboard.user_approval_form` at `/admin/config/dashboard/user-approval`, permission `administer site configuration`; reads uid from request `id`, calls `$user->activate()`.
- Dashboard View `views.view.dashboard`. `user_export` submodule exports user data (JSON/XML/CSV; deps rest, serialization, csv_serialization).
- Approve action is admin-gated + Form API CSRF -> SOUND (no anon activation).