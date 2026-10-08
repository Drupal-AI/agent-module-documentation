<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Owner or Admin Filter is a Views filter that limits results to content owned by the logged-in user, while users with the administer-nodes permission see everything.

---

Owner or Admin Filter provides a Views filter that narrows results to those owned by the current
user — unless the user has the administer-nodes permission, in which case all rows are shown. It works
by adding a WHERE clause using core Views' query substitutions (`***CURRENT_USER***` and
`***ADMINISTER_NODES***`), so non-admins see `uid = self` rows and admins see everything; it correctly
adds a `user` cache context so results aren't shared across users. It is not exposed and takes no
operator. Depends on core Views.

Use it to build "my content" listings that automatically fall back to full visibility for
administrators. Important distinction: this is a **display filter, not an access-control boundary**. It
shapes which rows a View returns, but it does not restrict access to the underlying entities — the same
content remains reachable through its canonical route, other Views, JSON:API/REST, etc. Use it for
convenience listings, not to enforce confidentiality; for real per-user access use node/entity access.

---

- Show only the current user's own rows in a View.
- Let administer-nodes users see everything.
- Build a 'my content' listing.
- Use core Views query substitutions.
- Add a user cache context correctly.
- Filter by ownership plus permission.
- Depend on core Views.
- Fall back to full visibility for admins.
- Not expose the filter or operator.
- Understand it is a display filter, not access.
- Not restrict canonical-route access.
- Not restrict JSON:API/REST.
- Use for convenience listings.
- Use node/entity access for confidentiality.
- Narrow results to uid = self.
- Show all rows to admins.
- Avoid custom query code.
- Add to a content View.
- Scope listings per user.
- Keep it presentational, not a boundary.
