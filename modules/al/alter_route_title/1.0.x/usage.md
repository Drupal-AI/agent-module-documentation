Alter Route Title lets an administrator replace the static page title of existing contrib/custom module routes from an admin form, without writing code.

---

Many contributed and custom modules ship routes whose title is a fixed `_title` string in their `*.routing.yml`. Changing that wording normally means overriding the route in your own module or patching someone else's. Alter Route Title removes that need: it enumerates the routes of every enabled non-core module, shows each route's machine name, current title and path, and gives you a text field per route to type a new title. A `RouteSubscriber` then overwrites the matching route's `_title` default whenever routes are rebuilt. Routes that build their title dynamically through a `_title_callback` are intentionally left alone, so you only affect the routes that use a hard-coded static title. The overrides live in one config object (`alter_route_title.configuration`), so they move between environments through normal configuration export/import. The typed values are restricted to letters, digits, spaces and underscores (max 128 characters), so this is for wording/branding, not for markup or dynamic tokens.

---

- Rename a contrib module's admin page title to match your site's terminology.
- Give a third-party module's route a clearer, more descriptive title without patching it.
- Rebrand the visible `<h1>`/page title of a custom module route from the UI.
- Shorten an overly long default route title on a settings page.
- Standardise capitalisation/wording of admin titles across several contrib modules.
- Apply a client's preferred label to a route title without a code deployment.
- Translate-free relabelling of a route title for a single-language site.
- Fix an awkward or misspelled default title shipped by a contrib module.
- Make two related routes share a consistent title naming scheme.
- Override the title of a custom module route you own but do not want to redeploy just to change a string.
- Present a friendlier title on an integration/settings page aimed at editors.
- Keep title overrides in configuration so they are versioned and reviewable in Git.
- Export the route-title overrides from staging and import them on production.
- Move a set of title overrides between sites by copying the single config object.
- Audit which routes have customised titles by inspecting the config `routetable`.
- Adjust a route title after a module update changed the wording you relied on.
- Relabel a utility route to hide implementation-specific jargon from end users.
- Provide a distinct title for a route so it reads better in the browser tab.
- Tidy the title of a rarely used admin route for consistency in navigation.
- Roll back a title override by clearing the field and saving (empty value = no override).
- Keep dynamic titles intact: leave `_title_callback`-driven routes untouched while relabelling static ones.
- Give a batch of custom-module routes house-style titles from one screen.
