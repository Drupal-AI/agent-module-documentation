<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comments Ban lets administrators stop specific user accounts from posting comments, while keeping those accounts otherwise active on the site.

---

Comments Ban is a targeted comment anti-abuse tool: it blocks named **authenticated** users from
posting comments without banning them from the whole site. It works by adding a boolean field
("User banned from comments") to the user entity and attaching a validation constraint to the
comment entity — when a banned user submits a comment, the constraint fails server-side and the
comment is rejected. Administrators ban a user by ticking the checkbox on that user's edit form, or
by using the "Remove comment and ban user" bulk action on a comments view (which deletes the
offending comment and bans its author in one step). Unbanning is done by unticking the checkbox, or
via the "Unban user from the comments" bulk action, or from the dedicated management view at
`/admin/config/people/banned-from-comments` that lists every banned user. Managing the ban field and
the view requires the core `administer users` permission; the ban/unban bulk actions require the
core `administer comments` permission. The module has no settings form and depends only on core
Comment; it sits in the Spam control package.

---

- Ban an individual authenticated user from posting comments.
- Keep the banned user's account active for login and browsing.
- Enforce the ban server-side via a comment validation constraint (not just a UI hint).
- Ban a user directly from their profile edit form with a single checkbox.
- Remove an offending comment and ban its author in one bulk action on a comments view.
- Unban a user with a checkbox, a user-view bulk action, or the management view.
- Review every banned user on the `/admin/config/people/banned-from-comments` page.
- Gate ban-field editing and the management view behind core `administer users`.
- Gate the ban/unban bulk actions behind core `administer comments`.
- Combat persistent comment spam and abuse from specific accounts.
- Moderate commenters without touching their broader site access.
- Rely only on core Comment — no third-party libraries or services.
- Clean up its field, actions and view automatically on uninstall.
