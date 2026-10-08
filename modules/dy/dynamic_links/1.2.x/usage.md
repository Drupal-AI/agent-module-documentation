<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic links lets an administrator create a single path that redirects (or transparently serves) the first target the current user can actually access.

---

Dynamic links is a small, dependency-free Drupal 10.3+/11 module. Each "dynamic link" is a configuration entity with its own path (for example `/tasks`) and an ordered list of target paths. When a user visits the dynamic link's path, the module walks the target list, checks each target's access for the current user, and either issues an HTTP redirect to the first accessible target or, in subrequest mode, renders that target's content in place without changing the URL. Targets can be stored either as raw internal paths or as resolved route names + parameters, and two events (`DynamicLinkRoutesEvent`, `DynamicLinkRedirectsEvent`) let other modules alter the candidate list per link or globally. Access to the dynamic link path is granted only when at least one target is reachable, so the link inherits the access of whatever it points at. Typical uses are role-aware landing pages and menu links that resolve to different destinations depending on who is logged in.

---

- Create a single `/dashboard` link that sends editors to the content overview and everyone else to their user page.
- Build a role-aware home page that redirects each user to the first section they are permitted to see.
- Make a menu link that resolves to different destinations depending on the visitor's permissions.
- Give administrators an `/admin` shortcut that falls through a priority list of admin reports until one is accessible.
- Point a stable, memorable URL at whichever of several views the current user can reach.
- Redirect anonymous users to a login/marketing page while sending authenticated users straight to their workspace.
- Serve the first accessible page transparently (subrequest mode) so the browser keeps showing the friendly `/tasks` URL instead of the target path.
- Provide a "my tasks" link that tries `/tasks/all`, then `/tasks/own`, then `/user`, stopping at the first one allowed.
- Consolidate several legacy paths behind one canonical entry point that picks the live destination at request time.
- Create per-role quick links in a toolbar or block where the same href works for every user.
- Let a multi-role user (for example editor + shop manager) land on the most relevant section automatically.
- Store target lists as routes so parameterized destinations survive path/alias changes.
- Preview a link's resolved destination and cacheability (contexts, tags, max-age) directly on the edit form before publishing.
- Enable or disable a dynamic link without deleting it; disabled links register no route.
- Forward POST form submissions through a subrequest-mode dynamic link to the underlying target form.
- Let a custom module reorder or filter a link's candidate targets at runtime via the routes/redirects events.
- Add site-specific candidate destinations to every dynamic link by subscribing to the base event name.
- Add extra candidates to just one dynamic link by subscribing to the per-link event name (`EventClass::<link_id>`).
- Manage all dynamic links from a single admin listing at `/admin/structure/dynamic-link` showing status, path and storage mode.
- Ship dynamic links as configuration so they deploy across environments with the rest of your config.
- Replace ad-hoc redirect logic in custom `hook_page_attachments`/controllers with a declarative, configurable entity.
