<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Optimize JS — agent index

Conditionally injects the **Google Optimize `optimize.js`** snippet on selected pages for A/B testing. Version **2.0.0**. Core `^9.3 || ^10`.

- Config form: `/admin/config/system/google_optimize` (route `google_optimize_js.settings`, permission `administer google optimize`).
- `Inclusion` service decides per-request inclusion using path, alias, path matcher and admin-route context.
- Depends on `path_alias`. Integration/front-end only — no access-control role; container ID is public client-side.
