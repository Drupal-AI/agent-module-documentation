Categorized Token Filter adds a category select-filter to Drupal Token's "Browse available tokens" tree so only the token groups you pick are rendered.

---

Categorized Token Filter is a small extension for the contrib **Token** module. On sites with many entity types and bundles, clicking "Browse available tokens" makes core Token build the entire token tree at once, which can be slow. This module registers a route subscriber that replaces the controller behind Token's `/token/tree` route with its own `CategorizedTokenTreeController`. When the browser is opened in its full ("all") mode, the controller renders a modal form (`TokensModalForm`) offering a multi-select of categories — "Global types", one entry per content-entity token type, and an "Others" bucket — and only builds the token tree for the categories the user selects. Everything else about Token's browser (the CSRF-protected route, the token-tree render, the insert-token JavaScript) is inherited unchanged. Despite the word "filter" in its name it is **not** a text-format filter plugin, provides no permissions, no settings form, and no configuration; installing and enabling it is all that is required.

---

- Speed up the "Browse available tokens" dialog on sites with hundreds of entity types/bundles where the full token tree is slow to load.
- Let editors narrow the token browser to just the entity type they care about (e.g. only Node or only User tokens) before the tree is built.
- Keep the token browser responsive inside long admin forms (pathauto patterns, metatag defaults, mail templates, views token fields, etc.).
- Show only "Global types" (site, current-date, current-user) when authoring a global message and hide per-entity noise.
- Reveal less-common token types via the "Others" category only when explicitly requested.
- Reduce memory/time spent building the token tree on token-heavy multisite or commerce installs.
- Drop-in replacement behavior for anywhere core Token's `token.tree` route is used — no template or theme changes needed.
- Use alongside Pathauto to browse the token set relevant to a specific alias pattern.
- Use alongside Metatag to pick entity-specific tokens for meta defaults without loading everything.
- Use alongside Token Filter / Twig Tweak workflows where authors frequently open the token browser.
- Improve the token-picking experience for site builders configuring email templates in modules that expose the token tree.
- Let developers quickly inspect which token types a given content entity exposes, grouped by category.
- Filter to a single entity token type when debugging why a particular token is or isn't available.
- Avoid browser jank/timeouts opening the token dialog on large content models.
- Present a cleaner, categorized token list to non-technical content editors.
- Install on Drupal 10 or 11 sites that already depend on the Token module.
- Enable with no configuration step — the categorized browser is active immediately after enabling.
- Remove cleanly by uninstalling the module; the token browser reverts to core Token's default controller.
