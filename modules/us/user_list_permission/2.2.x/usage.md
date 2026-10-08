<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User List Permission adds one permission, `access people list`, that lets a role open the `/admin/people` user list without being granted the broad `administer users` permission.

---

This module fixes a specific coupling in Drupal core: viewing `/admin/people` requires `administer users`, and that same permission also carries the power to edit any account, change email addresses and passwords, block and cancel accounts, and assign roles. So a community manager who only needs to look up who registered, a support agent who needs to find an account, or a reporting user who needs a headcount all have to be trusted to take over any account on the site — or be given nothing. There is no read-only middle setting in core. This module supplies the missing permission, `access people list`, and marks it `restrict access: true`. On install it does two things automatically: it rewrites the core People view (`views.view.user_admin_people`) so its access requirement changes from `administer users` to `access people list` — but only if the view is still on the core default, so a customised view is left untouched — and it grants `access people list` to every existing role that already holds `administer users`, so current administrators keep working with no manual step. A route subscriber also targets the non-Views `entity.user.collection` route. Because the People list served with Views is a Views display, the actual re-gating in a standard install comes from that rewritten view access, and Views copies it onto the `/admin/people` route. Crucially the list's operations links (edit, cancel) and its bulk-action form stay independently access-checked by core, so a role that has only `access people list` can see the list but cannot edit, block, cancel or change the roles of any account through it — those actions still demand `administer users`. Be aware that the list itself discloses account data: usernames, status, roles, member-for and last-access, plus email if the site's copy of the view includes a mail column. The module requires Drupal core `>=11.1` and declares `php: 8.3`, both tighter than most contrib — check compatibility before planning around it. It has no configuration UI; the whole feature is the one permission you grant on `/admin/people/permissions`.

---

- Let support staff view the user list without giving them `administer users`.
- Grant a helpdesk role read-only access to `/admin/people`.
- Give a community manager the ability to look up who recently registered.
- Let a reporting or analytics role count and review user accounts.
- Apply least-privilege to a role that needs visibility but not control over users.
- Separate the ability to view users from the ability to edit or cancel them.
- Reduce the number of full administrators on a site.
- Provide account-lookup access for an audit or compliance review.
- Let a moderator find a registrant by name or email without account-takeover power.
- Meet a separation-of-duties requirement between viewing and managing users.
- Avoid building and maintaining a duplicate custom user view just to control its access.
- Grant `access people list` on `/admin/people/permissions` to the chosen roles.
- Keep the existing People view in sync instead of forking it for a limited role.
- Preserve current admins automatically: install grants the new permission to roles already holding `administer users`.
- Migrate an existing site where a custom People view already sets its own access (the module leaves it untouched).
- Confirm a role can reach `/admin/people` but still gets 403 on user edit/cancel routes.
- Audit which roles can see the user list by reviewing who holds `access people list`.
- Give a manager visibility of the membership without any management rights.
- Restrict privilege creep by handing out `access people list` instead of `administer users`.
- Let a role review last-access times to spot dormant accounts, without editing them.
