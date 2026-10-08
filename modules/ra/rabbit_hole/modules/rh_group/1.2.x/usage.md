Registers Group entities (from the Group module) with Rabbit Hole so you can control what happens when a group is viewed at its canonical page — display, access denied, page not found, or redirect — per group type or per group.

---

`rh_group` is the Rabbit Hole submodule for the contributed Group module. Enabling it registers a Rabbit Hole entity plugin for the `group` entity type, adding the "Rabbit Hole settings" vertical tab to group type edit forms and (when overrides are allowed) individual group edit forms. Sites often want a group's canonical page to redirect to a members dashboard, a content listing, or a landing page rather than the default group view — and some groups shouldn't be viewable standalone at all. This submodule enables those behaviors without custom access or routing code. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up group support. It depends on `rabbit_hole` and `group`.

---

- Redirect a group's canonical page to its members dashboard.
- Redirect a group page to a Views listing of its content.
- Return access denied on group pages for non-members.
- Return 404 for group types that shouldn't have a public page.
- Set a per-group-type default behavior, overridable per group.
- Redirect using a token such as `[group:field_home]`.
- Return "page not found" instead of "access denied" to hide existence.
- Override the group-type default on a specific flagship group.
- Configure a fallback action for empty/invalid redirect targets.
- Redirect legacy group URLs to new paths with a 301.
- Use a temporary 302 redirect during a group migration.
- Let group admins bypass the action to view the real group page.
- Grant a role permission to administer Rabbit Hole on groups only.
- Send a group page to an external community platform.
- Redirect a group page to `<front>`.
- Hide inactive/archived group pages from visitors.
- Route a group page to a join/apply form.
- Prevent group pages from resolving on a headless site.
