<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Permissions dynamically strips a user's non-exempt roles on any host that is not the designated edit domain, so authoring and admin capabilities exist only on the edit domain.

---

Domain Permissions replaces Drupal core's `access_policy.user_roles` service (via a `ServiceModifierInterface`) with its own `UserRolesAccessPolicy`. On the edit domain a user keeps all their roles; on every other host the effective role set is reduced to only the roles named in the `domain_perm_roles_exempt` settings override (default `anonymous` and `authenticated`). The edit domain is identified by its host name containing the substring `-content` (for example `edit-content.example.com`). Because the override happens at the access-policy layer, the reduced role set drives every permission check on the request. The policy declares the `url.site` and a custom `roles_exempt` cache context (alongside core's `user.roles`) so calculated permissions vary per domain and per exempt-role configuration. It is a security-hardening / defense-in-depth feature: it shrinks the attack surface of the public domain and is configured entirely through `settings.php` — it ships no admin UI, no routes, no permissions, and no module dependencies (it does not require the Domain project). Requires Drupal core 10.3–11, which is where the pluggable Access Policy API exists.

---

- Confine authoring and administration to a dedicated edit domain while the public domain stays read-only for privileged users.
- Reduce the attack surface of a public multi-domain site (a hijacked editor session on the public host carries no privileged roles there).
- Strip all non-exempt roles from users when they browse a non-edit host.
- Keep only `anonymous` and `authenticated` roles active on the public domain by default.
- Add specific roles to `domain_perm_roles_exempt` so they remain effective on every domain (for example a `support` role that must work everywhere).
- Segregate an editorial workflow onto a separate `-content` host without touching per-node access.
- Enforce role reduction at the access-policy layer so it applies uniformly across all permission checks, not per feature.
- Harden a site that shares one Drupal codebase across an authoring host and one or more public hosts.
- Ensure admin toolbar/menu, node edit, and config routes are unavailable to privileged users on the public domain.
- Provide domain-aware permissions without writing a custom access policy from scratch.
- Serve as a working reference implementation of the core Access Policy API to fork for custom edit-domain logic.
- Vary render and access caching per domain so a page cached on one host is not served with another host's permission set.
- Configure the whole behavior from `settings.php` with a single `$settings['domain_perm_roles_exempt']` array.
- Verify hardening by logging in as an editor on the edit host (roles intact) and a public host (roles stripped).
- Combine with correct `trusted_host_patterns` so only your real hosts resolve as edit vs non-edit domains.
- Run on Drupal 10.3, 10.4, or 11 sites that use the Access Policy API.
- Apply the same reduced-role behavior to authenticated API/other requests, since it works at the permission-calculation layer.
- Use it as a lightweight alternative to standing up the full Domain project when you only need role reduction by host.
- Name the edit domain with a `-content` host segment (for example `edit-content.example.com`) so the module recognizes it.
