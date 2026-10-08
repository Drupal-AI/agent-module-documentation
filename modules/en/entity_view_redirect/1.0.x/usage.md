<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity View Redirect intercepts the canonical view page of nodes, taxonomy terms, and users and redirects it to the entity's edit form or an admin-configured internal path.

---

Some entities exist to be edited, not viewed: content used as a data store, records managed only through their form, or pages actually built by Views rather than the entity's own display. Entity View Redirect turns off the canonical "view" page for Drupal core's node, taxonomy term, and user entities by sending a request for that page to the edit form (the default) or to a custom internal path you configure. The redirect is enabled per node type and per taxonomy vocabulary through their existing settings forms (a "third-party setting" on the bundle), and once globally for users via the account settings form. The custom path is a site-administrator-supplied internal path and may include a `%` token that is replaced with the current entity's ID, so you can send each entity to a per-entity destination such as an analytics or address-book page. Users holding the "Bypass entity view redirect" permission still reach the normal view page. The redirect fires from a kernel REQUEST event subscriber after routing and access have already been resolved by core, so core view-access checks on the canonical route still apply.

---

- Disable the node view page for a content type used purely as a data store, sending visitors straight to the edit form.
- Redirect a taxonomy term's canonical page to the term edit form for vocabularies you only manage administratively.
- Redirect a user profile page to the user's account edit form.
- Send a node type's view page to a custom internal path such as `/node/%/analytics` (the `%` becomes the node ID).
- Send a vocabulary's term view page to a custom listing such as `/taxonomy/%/list`.
- Send the user view page to a custom path such as `/user/%/address-book`.
- Point all three entity types at a single static landing path like `/homepage`.
- Keep editors on the form when your content is never meant to be rendered as a standalone page.
- Replace the default entity view with a Views-built page by redirecting the canonical route to that view's path.
- Enable the redirect on only selected node types while leaving others viewable.
- Grant trusted roles the "Bypass entity view redirect" permission so they can still open the real view page.
- Preview the canonical page as an administrator by holding the bypass permission.
- Configure per-bundle behavior directly from the node type or vocabulary edit screen, no separate admin page.
- Turn the user redirect on or off from Configuration → People → Account settings.
- Route content records to editing to enforce an "edit-only" workflow.
- Remove the practical usefulness of the default view route without unpublishing content.
- Combine node, term, and user redirects to make an entire site form-driven.
- Migrate away from default entity pages gradually by toggling one bundle at a time.
- Send legacy view URLs to a new canonical location within the site.
- Keep the destination admin-controlled so the behavior is predictable across roles.
- Test the effect per content type before enabling site-wide, since the toggle is per bundle.
- Document which bundles have the redirect enabled so the missing view pages are expected.
- Clear caches after enabling or disabling to make sure the routing behavior is current.
