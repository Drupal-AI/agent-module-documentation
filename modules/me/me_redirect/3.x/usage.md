<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Me Redirect gives your site a stable `/me` URL space that 302-redirects the logged-in user to their own `/user/UID` and `/user/UID/*` account pages.

---

Linking to "your account" normally needs the current user's ID, which menus, templates and static links do not always have. Me Redirect adds a single route, `/me/{user_path}`, that reads the user id **server-side from the session** (`\Drupal::currentUser()->id()`) and issues a **302** to `/user/UID[/tail]` — so `/me` → `/user/123`, `/me/edit` → `/user/123/edit`, `/me/edit/foo` → `/user/123/edit/foo`. An inbound path processor collapses the sub-path (slashes become colons before routing, then back to slashes) so a multi-segment tail like `/me/edit/foo` is preserved. Because the destination is always built as `/user/UID/…` from the session user, it is same-origin and can only ever be the caller's **own** pages — it is not an open redirect and cannot be pointed at another user. The target route still enforces its own access, so `/me` is a convenience, not an access grant. **Anonymous** requests to `/me` receive an Access Denied (403) response. Install with `composer require drupal/me_redirect` and `drush en me_redirect -y`; there is **no configuration page** and nothing to set up beyond enabling it.

---

- Provide a stable `/me` self-URL.
- Redirect `/me` to the current user's profile.
- Link to "your account" without knowing the UID.
- Use `/me/edit` for a self-edit link.
- Map `/me/*` to `/user/UID/*` pages.
- Add a "My account" menu item pointing at `/me`.
- Put a `/me` link in a block or template.
- Reuse the same account link for every logged-in user.
- Derive the user from the session, not request input.
- Keep account links working after user IDs change contexts.
- Send anonymous `/me` requests to a 403 Access Denied.
- Rely on a 302 (temporary) redirect by design.
- Enable the module with no configuration step.
- Install via Composer with no extra dependencies.
- Run on Drupal 10 or 11.
- Avoid an open-redirect surface (same-origin `/user/UID/` only).
- Let target routes enforce their own permissions.
- Link to self-service pages like `/me/edit` or `/me/cancel`.
- Simplify account links in documentation shared across users.
- Verify with `drush en` then visiting `/me` while logged in.
- Test `/me` behavior for anonymous vs authenticated users.
- Review after Drupal core upgrades.
