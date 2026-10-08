<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A floating toolbar for quick user switching via Masquerade.

---

Masquerade Toolbar provides a floating toolbar for quick user switching via the Masquerade module — so an authorised admin can search for and masquerade as another user from a floating toolbar, and switch back quickly, streamlining support/testing.

Security: access is properly gated — the toolbar and its user-autocomplete require the `use masquerade toolbar` permission AND `masquerade as any user`/`masquerade as super user` (via a custom access checker), so it does not weaken Masquerade's permission model. Depends on `masquerade`; supports Drupal 10 and 11.

---

- Provide a masquerade toolbar.
- Quickly switch users.
- Search users to masquerade as.
- Switch back easily.
- Gate by `use masquerade toolbar`.
- Require masquerade-as permissions.
- Not weaken the permission model.
- Depend on `masquerade`.
- Support Drupal 10 and 11.
- Aid support/testing.
- Handle user switching.
- Masquerade safely
- Support Drupal.
- Support Drupal.
- Support Drupal.
