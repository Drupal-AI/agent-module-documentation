<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Access by User allows access to a view to be restricted by user.

---

Views Access by User **restricts a view's access to specific users** — a Views access plugin so a view
display can be limited to a configured set of user(s), rather than by role/permission. It depends on the Views
module.

Use it to limit a view to named users. It is an **access-control** plugin for Views: it gates the view display's
route/access to the configured user(s). Understand its scope: it controls **access to the view (the listing/page)**
— it does not by itself change access to the underlying entities the view lists (those still enforce their own
entity access), so use it to gate a view UI, not as the sole protection for the data. Verify the configured user
list is correct (a mis-set list could expose or lock out the wrong users). Configure the allowed users on the view
access setting.

---

- Restrict a view to specific users.
- Provide a Views access plugin.
- Gate the view by user(s).
- Depend on the Views module.
- Serve access control (Views).
- Limit view access.
- GATE the view display's route/access to configured users.
- Not change access to the underlying entities (entity access still applies).
- Use it to gate a view UI, not as the sole data protection.
- Verify the configured user list is correct (mis-set = wrong exposure/lockout).
- Configure the allowed users on the view.
- Handle view access.
- Restrict views.
- Configure the users.
- Gate the view.
- Handle the access.
- Limit the listing.
- Set allowed users.
- Verify the list.
- Provide user-based view access.
