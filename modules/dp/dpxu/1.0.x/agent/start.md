<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Designated Proxy User (dpxu) — agent index

**Paired `dpxu_manager`/`dpxu_managed` roles so one account creates and manages others, with optional email interception.**

- **Version:** 1.0.x · **Core:** ^10 || ^11 · **Depends on:** user
- **Routes:** `dpxu.settings_form` (`administer dpxu configuration`); `dpxu.user_create` `/user/add/managed-user` (`create dpxu users`); `dpxu.user_edit` `/user/{manager}/edit/managed-user/{user}` (`edit dpxu users`); `dpxu.contact_manager` `/user/{user}/message_user_manager` (role `dpxu_managed`).
- **Permissions:** administer/create/edit dpxu users, `edit dpxu manager field`, `access dpxu listings`, `access dpxu contact form`.
- **Service:** `dpxu.user_tools` (`ProxyUserTools`) — ownership checks, email interception, tempstore contact flags.
- **Access enforcement:** in addition to route permissions, `getManagedUserEditForm()` verifies the current user is the manager AND owns the target account (or has `administer users`), else redirects — no cross-manager IDOR. Manager-UID field edit-gated by `hook_entity_field_access`.
- **Security:** routes permission-gated plus service-level ownership checks; email interception strips one-time-login URLs before forwarding. No anonymous or unauthenticated endpoints. No findings.

See [configure/managed-users.md](configure/managed-users.md)
