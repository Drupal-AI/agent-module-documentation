<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Project Browser source that lists your codebase's own `extra_*` recipes so site builders can discover and apply them from the Project Browser UI.

---

Project Browser Extra Recipes is a small companion to core's Project Browser module. It contributes one Project
Browser source plugin, `extra_recipes` (`Drupal\extra_project_browser\Plugin\ProjectBrowserSource\ExtraRecipes`),
that scans the local codebase for recipe directories whose machine name starts with `extra_` and presents them as
browsable, applyable entries alongside Project Browser's other sources. It does not fetch anything from a remote
service: on each request it walks the recipe locations on disk (the recipes path used by core's Recipes source and
the project-root `../recipes` directory) with a Symfony Finder looking for `recipe.yml` at depth 1, reads each
recipe's name and description from its `recipe.yml`, and reads the Composer package name and homepage from an
adjacent `composer.json` when one exists. A short hardcoded exclusion list keeps chosen `extra_*` recipes out of
the list. Results are sorted by title, cached in the `cache.project_browser` bin, and filtered/paged in memory. On
install the module auto-enables the source in `project_browser.admin_settings`; on uninstall it removes it. It has
no settings form, routes, permissions, config schema, entities or Drush commands of its own, and no content or
access-control role.

---

- Make your site's private, site-specific `extra_*` recipes visible inside Drupal's Project Browser UI.
- Let site builders discover custom recipes without remembering their machine names or paths.
- Apply local `extra_*` recipes from the same UI used to find contributed projects.
- Surface recipes stored in the project-root `recipes/` directory as a browsable catalog.
- Surface recipes located under the path used by Project Browser's core Recipes source.
- Give teams that maintain internal recipe libraries a discovery front end.
- Show each recipe's human-readable title and description pulled from its `recipe.yml`.
- Expose each recipe's Composer package name and homepage link from its `composer.json` when present.
- Keep specific `extra_*` recipes hidden from the browser via the built-in exclusion list.
- Search the extra recipes list by title from the Project Browser search box.
- Provide a recipes-only source that complements, rather than replaces, Project Browser's core sources.
- Auto-enable the `extra_recipes` source on install so no manual Project Browser configuration is needed.
- Standardise how a distribution or agency exposes its own recipe bundles across many sites.
- Present recipes as `ProjectType::Recipe` entries so they render with Project Browser's recipe handling.
- Cache the scanned recipe list in the Project Browser cache bin for fast repeat browsing.
- Onboard editors to a curated set of internal site-building recipes.
- Let CI/build pipelines drop recipes into the codebase and have them appear automatically after a cache clear.
- Browse recipes with the recipe logo shipped by the core Project Browser module.
- Remove the extra recipes source cleanly by uninstalling the module.
- Complement contributed-module browsing with local recipe browsing in one interface.
