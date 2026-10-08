<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Entity Reference simplytest.me demo (better_entity_reference_simplytest) — agent index

Submodule of **better_entity_reference**. A single-purpose bridge: it applies the parent's
`demo_content` recipe from `hook_install`, so an evaluation sandbox (which can only enable a
module, not run `drush recipe:apply`) lands with the demo built. Version `1.0.x` (ships with the
parent, beta12). Package *Better Entity Reference*. License GPL-2.0-or-later. Evaluation only.

- **Dependency:** `better_entity_reference:better_entity_reference`. Core `^10.6 || ^11.3 || ^12`.
- **No routes, controllers, plugins, services, permissions or config schema.** Ships only
  `.info.yml` and `.install`.

## What it does (from source: `better_entity_reference_simplytest.install`)

- `hook_install()` resolves `<better_entity_reference path>/recipes/demo_content`, and if the dir
  exists runs `RecipeRunner::processRecipe(Recipe::createFromDirectory($path))`, creating the
  `ber_demo` content type with one field per Better widget.
- **Idempotency:** if a `ber_demo` node type already exists it adds a status message and returns
  (recipes throw when re-applied); a missing recipe or a runner exception is caught and reported
  via messenger + logger, not thrown.
- The parent's `info.yml` carries `simplytest_dependencies: [better_entity_reference_simplytest]`
  — a simplytest.me convention (ignored by Drupal core) that asks a sandbox to auto-enable this.

No security-relevant surface: no routes or endpoints; install-time recipe application only.

Parent index: [../../../../agent/start.md](../../../../agent/start.md).
