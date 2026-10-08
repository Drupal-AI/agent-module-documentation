Registers user accounts with Rabbit Hole so you can control what happens when a user profile is viewed at its canonical `/user/*` page — display, access denied, page not found, or redirect.

---

`rh_user` is the Rabbit Hole submodule for core Users. Enabling it registers a Rabbit Hole entity plugin for the `user` entity type, adding the "Rabbit Hole settings" to the user account settings and (when overrides are allowed) individual user edit forms. Public user profile pages are frequently unwanted — for privacy, to reduce spam-target surface, or because the site simply doesn't use profiles — and this submodule lets you 404, deny access, or redirect them without writing custom access code. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up user support. It depends on `rabbit_hole` and core `user`.

---

- Return access denied on `/user/*` to hide member profiles.
- Return 404 for user profile pages on a site that doesn't use them.
- Redirect a user's page to a public "author" Views listing.
- Set a default behavior for all users, overridable per account.
- Redirect profiles to a contact form or dashboard with a 301/302.
- Hide profile pages from crawlers for privacy and SEO.
- Redirect using a token such as `[user:field_homepage]`.
- Return "page not found" instead of "access denied" to hide existence.
- Override the default behavior for a specific spotlighted user.
- Configure a fallback action for empty/invalid redirect targets.
- Let admins bypass the action to view real profile pages.
- Grant a role permission to administer Rabbit Hole on users only.
- Redirect the anonymous/system user page away.
- Send authors' profile pages to their content listing.
- Redirect a user page to `<front>`.
- Reduce account-enumeration surface by denying profile access.
- Route member profiles to an external community platform.
- Prevent user pages from resolving on a headless site.
