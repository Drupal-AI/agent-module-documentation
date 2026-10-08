<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single Page Protection provides password protection for specific pages, redirecting to a password form until the correct password is entered.

---

Single Page Protection (project `spp`, module `single_page_protection`) password-protects specific
pages: a `KernelEvents::REQUEST` subscriber checks whether the requested page is protected and, if the
password hasn't been entered in the session, redirects the visitor to a password form before the page
renders. The password check uses `hash_equals()` (constant-time comparison), and configuration is at
`single_page_protection.admin_settings`. It depends on core System and Filter and provides its own
permissions.

Use it for lightweight password-gating of particular pages (a members' notice, a pre-launch page). It
is reasonably built — a request-level gate (not display-only) with a constant-time password compare.
Important scope caveat: protection is **path-based** — it gates the configured page paths, but it is not
entity/data access control, so if the underlying content must be truly confidential, ensure it isn't
reachable through other routes (the node's canonical path vs alias, JSON:API/REST, feeds, other Views).
For casual page-gating it works as intended; for real confidentiality, back it with entity access.

---

- Password-protect specific pages.
- Redirect to a password form when protected.
- Gate pages at the request level.
- Compare passwords with hash_equals.
- Configure at single_page_protection.admin_settings.
- Depend on core System and Filter.
- Provide its own permissions.
- Protect a members' notice page.
- Gate a pre-launch page.
- Store entered-password state in session.
- Know protection is path-based.
- Ensure content isn't reachable via other routes.
- Back with entity access for confidentiality.
- Use for lightweight page-gating.
- Check protection before rendering.
- Not rely on it for JSON:API/REST protection.
- Enter a password to view.
- Protect matched page paths.
- Use constant-time compare.
- Gate pages by password.
