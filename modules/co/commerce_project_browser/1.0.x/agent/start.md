<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Project Browser (commerce_project_browser) — agent index

**Adds Project Browser *sources* that list Drupal recipes published on Packagist, filtered
by keyword/category, and surfaces each as a local action on the admin page where it is
relevant (e.g. "Browse marketplace" on the payment-gateway collection) instead of a tab on
Extend.** It is a discovery layer only — installing a browsed recipe uses Project Browser +
Package Manager's own flow; no install code lives here.

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** `^11` (per `.info.yml`; Drupal 11 only)
- **Depends:** `project_browser:project_browser` (hard). Drupal Commerce is optional — each
  shipped category self-hides when its module is absent; the module itself needs only
  Project Browser.
- **Configure:** reuses `project_browser.settings` (no settings form of its own).
- **No** entity, cron, queue, webhook, JS, template, `.install`, `.module`, secret, or Drush command.

## Mental model (how one category becomes a browsable, in-context source)
A **category** = one Packagist keyword + one browsable source + optionally one local action.
Add a `#[ProjectBrowserCategory]` plugin class in ANY module under
`Plugin/ProjectBrowserCategory/` and everything else is derived:

| Derived thing | By | Example (`id: commerce_payment`) |
| --- | --- | --- |
| Project Browser source | `SourceDeriver` | `commerce_packagist_recipes:commerce_payment` |
| Browse URL | route `project_browser.browse` | `/admin/modules/browse/commerce_packagist_recipes:commerce_payment` |
| Local action | `LocalActionDeriver` | on `entity.commerce_payment_gateway.collection` |
| `enabled_sources` entry | `EnabledSourcesOverride` (runtime config override) | added automatically |

A recipe becomes listed the moment its own `composer.json` says `"type": "drupal-recipe"`
and carries a matching `keywords` entry — there is no catalog file to maintain. See
[extending.md](extending.md) for the plugin/deriver/override mechanics and the alter hook.

## Shipped category plugins (`src/Plugin/ProjectBrowserCategory/`)
| Class / id | Keyword | Requires module | Local action route |
| --- | --- | --- | --- |
| `Commerce` / `commerce` | `commerce` | `commerce` | `commerce.configuration` (catch-all: every Commerce recipe) |
| `Payment` / `commerce_payment` | `commerce_payment` | `commerce_payment` | `entity.commerce_payment_gateway.collection` |
| `Shipping` / `commerce_shipping` | `commerce_shipping` | `commerce_shipping` | `entity.commerce_shipping_method.collection` |

Attribute args: `id` (also the Packagist keyword), `label`, `modules` (all must be installed
or the whole category+source+action is hidden), `actionRoute` (omit = no action; a
nonexistent route is skipped, not fatal), `actionTitle` (default local-action label is
"Browse marketplace"). Category id = Packagist keyword.

## The source plugin (`src/Plugin/ProjectBrowserSource/PackagistRecipes.php`, `@internal`)
Never used directly — `SourceDeriver` makes one derivative per available category, each
locked to that keyword. `getProjects()` pipeline:
- **Search:** `GET https://packagist.org/search.json?type=drupal-recipe&tags=<keyword>` →
  results keyed by package name. Cached 1h (`cache.project_browser`,
  cid `commerce_project_browser:search:<tag>`). Errors are logged and yield an empty list.
- **Per-package metadata:** `GET https://repo.packagist.org/p2/<name>.json` (falls back to
  `…~dev.json`) reads the delta-encoded p2 first-version entry for `extra["drupal/commerce_project_browser"]`
  (`title`, `logo`) and the `abandoned` flag. Cached 1h. Note: the human `packagist.org/packages/<name>.json`
  summary omits `extra`, so p2 is required.
- **Card fields:** `title` = `extra.title` else humanized package name; `body.summary` =
  Packagist description; `projectUsageTotal` = Packagist `downloads` (Composer installs, NOT
  drupal.org "sites report using"); `isMaintained` = NOT flagged abandoned; `isCovered` =
  NULL (Packagist has no security-advisory equivalent); `type` = Recipe; `logo` = local
  recipe `logo.png` if on disk (via the logo route) else remote `extra.logo`.
- **Filters (`getFilterDefinitions`):** `search` (TextFilter, client-side title substring)
  and `categories` (MultipleChoiceFilter with only `centarro_certified`). The source's own
  keyword is deliberately NOT offered/shown (every card has it).
- **Sorts (`getSortOptions`):** `usage_total` ("Most popular" — certified first, then most
  installed, ties alphabetical), `a_z`, `z_a` (strictly alphabetical, certified do NOT jump).

## Centarro certification (`src/CertifiedProjects.php`)
Reads certified package names from the `extra["centarro-certified-recipes"]` block of the
Centarro-owned `centarro/certified-projects` metapackage (p2 release, falling back to `~dev`),
accepting a plain list or a keyed map. **Fails closed** — unreachable manifest certifies
nothing. Never trusts a recipe's self-set keywords. Certified recipes get a "Centarro
Certified" category badge and lead "Most popular". Cached 1h (`commerce_project_browser:certified`).

## Local logo (`src/Controller/LocalLogoController.php` + route)
`commerce_project_browser.local_logo`: `/admin/modules/commerce-project-browser/logo/{vendor}/{name}`,
`_permission: 'administer modules'`. Streams a locally-present recipe's own `logo.png`
(preferred over remote `extra.logo` because Packagist metadata lags its search index).
`LocalRecipeFinder` (`src/LocalRecipeFinder.php`) locates recipes by scanning `core/recipes`
and Project Browser's recipes path for `recipe.yml`+`composer.json` on disk (NOT via
`\Composer\InstalledVersions`, because `core-recipe-unpack` removes applied recipes from
Composer's bookkeeping). Path is resolved through a package→dir map + `realpath` + a
`str_starts_with` containment guard.

## Routes / permissions / services
- **Route:** only `commerce_project_browser.local_logo` (above). No `*.permissions.yml`;
  the route reuses core's `administer modules`.
- **Services (`.services.yml`):** `plugin.manager.commerce_project_browser_category`,
  `commerce_project_browser.local_recipe_finder`, `commerce_project_browser.certified_projects`,
  `commerce_project_browser.enabled_sources_override` (tagged `config.factory.override`, priority 100).

## Security posture (safe to state publicly)
Catalog hosts are hardcoded (packagist.org / repo.packagist.org) — no config- or
request-chosen host. All HTTP uses the default client with TLS verification (no
`verify => false`). No installer code here — installing rides Project Browser + Package
Manager's admin-gated flow. The one route is `administer modules`-gated and its file
streaming is path-traversal-guarded (map lookup + realpath containment). No secrets are
handled. Certification is read from a Centarro-owned manifest and fails closed. The config
override augments (does not replace) Project Browser's enabled sources.

## Subdocs
- **Extending: category plugins, derivers, the config override, `logo`/`title` display
  metadata, the certified manifest, and `hook_commerce_project_browser_categories_alter()`**
  → [extending.md](extending.md)
