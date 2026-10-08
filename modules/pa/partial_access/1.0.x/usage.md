<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Show a truncated (paywalled) node body to non-privileged roles.

---

Partial Access provides role-based partial node view — showing only a percentage of a blog node's body to visitors who aren't the author/an editor and lack a configured paid-access role (a soft paywall/teaser).

**Security warning (as shipped, 1.0.0):** the truncation is enforced ONLY on the HTML render path (a `KernelEvents::VIEW` subscriber mutates the loaded node's `body` before it renders) — it implements NO `hook_node_access()`/field access. So the full 'restricted' body is **exposed via JSON:API (`/jsonapi/node/blog/{uuid}`), REST, Views feeds, and search indexing**, completely bypassing the paywall. **Do not rely on it for real access control**; use authoritative access/subscription enforcement. Depends on core `node` and `user`; supports Drupal 11.

---

- Show a truncated node body.
- Paywall by role/percentage.
- Full access to authors/editors/paid roles.
- Provide a teaser to others.
- WARNING: enforced only on the HTML render path.
- WARNING: full body exposed via JSON:API/REST.
- Implement no authoritative access hook.
- Not be relied on for access control.
- Depend on core `node` and `user`.
- Support Drupal 11.
- Aid soft paywalls.
- Handle partial view.
- Support Drupal.
- Support Drupal.
- Support Drupal.
