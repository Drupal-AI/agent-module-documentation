<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stylify (stylify) — agent index

**On-site CSS editor: write and live-preview global/route/entity/content-type stylesheets, stored in the DB and injected per page.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Configure:** `/admin/config/system/stylify` (`manage stylify settings`)
- **Write routes:** `/stylify/sheet/{save,lock,unlock}` (POST) require an editor permission + `_user_is_logged_in` + `_csrf_request_header_token`; `/stylify/sheet/check-lock` (GET)
- **Permissions (all `restrict access: true`):** edit global/admin/entity stylify css, `access stylify css editor` (break-glass), `manage stylify settings`
- **Services:** lock_manager, resolver, storage, css_validator, access_checker, request_guard (flood), attachment_builder
- **Security:** All mutating endpoints are permission-gated, login-required and CSRF-protected, with flood control; CSS is validated before storage. Saved CSS is served to visitors, so permissions are access-restricted. No security findings.

See [configure/stylesheets.md](configure/stylesheets.md)
