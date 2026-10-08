<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Custom Permissions — agent index

Views **access plugin granting access via an admin-defined custom callback function** — bespoke/dynamic
access logic beyond permission/role. Config in `views_custom_permissions.settings`; depends on `views`;
provides permissions. Version **2.0.0**. Core `>=8`.

**Access-control feature:** responsibility is on the configured callback — it must return granted/denied
correctly and **fail closed**. Set by developers (privileged config); verify its logic before relying on
it to protect a view.
