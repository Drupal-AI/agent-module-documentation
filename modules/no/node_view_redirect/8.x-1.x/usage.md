Node View Redirect sends a node's canonical view page to a configured internal path, chosen per content type, when the visitor is not an editor of that content type.

---

Some content types exist mainly as data behind a canonical URL and should not render their own view page for ordinary visitors — a record that belongs on a related landing page, a container node whose page should point elsewhere. Node View Redirect enables a redirect per content type: on each request to a node's `entity.node.canonical` route it checks whether that bundle is enabled and whether the current user holds authoring/editing permissions for it (create, edit, delete, or revision permissions). Users with those permissions still see the node so they can manage it; everyone else is redirected to the configured path. A per-bundle "no permission exception" option forces the redirect for all users, editors included. The target path is set by an administrator on the module's settings form and validated as an existing internal route; an invalid configured path yields a 404. Configuration lives under Administration › Configuration › Workflow.

---

- Redirect a content type's node view to a related landing page.
- Keep a "data only" content type from rendering its own page for visitors.
- Point a node's canonical URL at an existing internal path.
- Redirect one content type while leaving others untouched.
- Let editors still open the node while anonymous users are redirected.
- Force the redirect for everyone, including editors, via "no permission exception".
- Send container/reference nodes to their parent page.
- Route a legacy content type to a replacement route.
- Redirect nodes of a bundle to a Views page or listing.
- Keep authors able to create and edit while the public view is redirected.
- Enable redirects only for the content types you check on the settings form.
- Configure a different destination path per content type.
- Turn the redirect off for a content type by unchecking it.
- Restrict who can change the redirect configuration to trusted administrators.
- Preserve the current interface language when redirecting.
- Return a 404 when a configured redirect path no longer resolves.
- Redirect based on the visitor's permissions for that bundle.
- Replace a themed node page with a curated destination.
- Avoid exposing raw node pages for structural content types.
- Set up redirects without writing code, from the admin UI.
- Test redirect behavior for both editor and anonymous roles.
- Review configured paths after content or route changes to avoid loops.
