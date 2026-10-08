<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatically grants configured Drupal roles to a user, on save, based on the Domain Access domains the user is affiliated with.

---

Domain role synchronization bridges the Domain (Domain Access) module and Drupal's role system. An administrator maps one or more roles to a domain from a fieldset added to the Domain edit form; the mapping is stored as third-party settings on the Domain config entity. When a user affiliated with that domain (through the `field_domain_access` field) is created or saved, the module's `user_presave` hook adds the domain's mapped roles to the user. This lets role-only functionality — for example *Menu admin per menu* — become effectively domain-aware, typically by creating one role per domain. In this 1.x dev branch the behavior is one-directional and additive: roles are granted from domain affiliation, roles are never removed when an affiliation ends, and the reverse direction (assigning a domain when a user gains a role) is a roadmap item, not implemented. Requires the `domain` module; supports Drupal 9 through 12; not covered by Drupal's security advisory policy.

---

- Auto-assign an editor role to every user affiliated with a given domain.
- Map a distinct role per domain (for example `brand_a_editor`, `brand_b_editor`) on a multi-domain site.
- Make *Menu admin per menu* domain-aware by giving each domain's editors a per-domain role.
- Bridge any role-only contrib module into a Domain Access site structure.
- Keep role assignments in step with domain affiliation without manual per-user role edits.
- Grant a "content team" role to all users of a specific affiliate domain.
- Onboard new users to a domain and have them pick up the domain's roles automatically on first save.
- Re-apply a domain's roles to existing users simply by re-saving their accounts.
- Configure role-to-domain mapping entirely from the standard Domain edit form (no separate settings page).
- Store role mappings in exportable configuration (third-party settings on `domain.record.*`).
- Add several roles to a single domain at once via a checkboxes fieldset.
- Restrict the mappable roles to real, custom roles (the built-in `authenticated`/`anonymous` roles are excluded from the UI).
- Support a role-per-brand access model across sites sharing one Drupal install.
- Give per-domain moderators the roles their moderation tools expect.
- Ensure domain-affiliated users always hold the roles their domain requires after any account update.
- Combine with Domain Access field configuration so affiliation drives both content visibility and role membership.
- Provide a lightweight alternative to hand-maintaining role assignments in large multi-domain user bases.
- Use configuration management (config export/import) to ship domain-role mappings between environments.
- Pair with role-based permissions so domain affiliation ultimately controls what a user can do.
- Support Drupal 9, 10, 11 and 12 sites running the Domain module.

