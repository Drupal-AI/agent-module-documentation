<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions by Term Redirect improves the UX of the Permissions by Term access system: when an anonymous visitor hits a node they can't view because of a term restriction, instead of a bare "Access Denied" they are sent to the login form, and after logging in they are taken straight back to the page they originally requested.

---

It subscribes to the `permissions_by_term.access.denied` event (`PermissionsByTermAccessDeniedEventSubscriber`). When the denied node matches the current route's node and the user is anonymous, it triggers the page-cache kill switch, stores the requested node id in a visitor cookie (`permissions_by_term_redirect.requested_nid`), and issues a temporary (307) redirect to `user.login` (with caching disabled). On the login side, `hook_user_login()` reads that cookie (ignoring password-reset routes), deletes it, and sets the request's `destination` to `entity:node/{nid}` so core returns the user to the originally requested node — where Permissions by Term re-checks access normally. Authenticated users who are denied still just get Access Denied (no redirect loop). It depends on `permissions_by_term`, defines no permissions or configuration, and the redirect targets are internal node routes (no open-redirect). It changes redirect behaviour only; the actual access enforcement remains in Permissions by Term.

---

- Send anonymous users who hit term-restricted content to the login form instead of a 403.
- Return users to the exact page they wanted after they log in.
- Improve conversion on gated/members-only content.
- Preserve the requested destination across the login step via a cookie.
- Avoid confusing bare "Access Denied" pages for logged-out visitors.
- Keep authenticated-but-denied users on a normal Access Denied (no loop).
- Skip the redirect during password-reset flows to avoid interference.
- Disable page caching for the denial redirect so it isn't served stale.
- Rely on internal node routes for the return, avoiding open-redirect risk.
- Let Permissions by Term keep enforcing access after login (no bypass).
- Streamline member journeys to protected taxonomy-tagged pages.
- Reduce support requests about "access denied" from anonymous users.
- Deep-link marketing to gated content and log users in en route.
- Work automatically once enabled — no configuration needed.
- Complement Permissions by Term without changing its access logic.
- Handle term-restricted nodes consistently site-wide.
