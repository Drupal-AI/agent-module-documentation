<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Project Browser — extending & internals

How the category → source → local-action pipeline is wired, and how to add to it.
Parent: [start.md](start.md).

## Add a new category (the whole job)
Drop a class carrying `#[ProjectBrowserCategory]` under `Plugin/ProjectBrowserCategory/` in
**any enabled module** — discovery is automatic, no change to commerce_project_browser and
no config to ship:

```php
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\commerce_project_browser\Attribute\ProjectBrowserCategory;
use Drupal\commerce_project_browser\Plugin\ProjectBrowserCategoryBase;

#[ProjectBrowserCategory(
  id: 'commerce_payment',               // ALSO the Packagist keyword recipes must carry
  label: new TranslatableMarkup('Payment integrations'),
  modules: ['commerce_payment'],        // ALL must be installed or the whole category hides
  actionRoute: 'entity.commerce_payment_gateway.collection', // omit = no local action
  actionTitle: new TranslatableMarkup('Add payment integration'), // omit = "Browse marketplace"
)]
final class Payment extends ProjectBrowserCategoryBase {}
```

Attribute (`src/Attribute/ProjectBrowserCategory.php`) params: `id` (plugin id = keyword),
`label`, `modules` (default `[]` = always available), `actionRoute` (default NULL), `actionTitle`
(default NULL → label falls through to "Browse marketplace"). Base class
(`ProjectBrowserCategoryBase`) exposes `label()`, `getRequiredModules()`, `getActionRoute()`
from the definition.

## What gets derived (and where)
- **Source** — `SourceDeriver` (`src/Plugin/Derivative/SourceDeriver.php`) makes one
  derivative of the `commerce_packagist_recipes` source per **available** category
  (`getAvailableDefinitions()` = all required modules installed), injecting `category` = the
  keyword and `local_task: NULL` (never a tab on Extend). Derived id:
  `commerce_packagist_recipes:<category_id>` — one narrowed listing per keyword, which is the
  only way to deep-link a prefiltered browse page (Project Browser's client does not read
  filter state from the URL).
- **Local action** — `LocalActionDeriver` (`src/Plugin/Derivative/LocalActionDeriver.php`),
  wired via `commerce_project_browser.links.action.yml`, makes an action per category that
  sets `actionRoute`, pointing at `project_browser.browse` with `source` = the derived id and
  `appears_on` = `[actionRoute]`. If the route does not exist it is **skipped** (catches
  `RouteNotFoundException`) — never fatal.
- **enabled_sources** — `EnabledSourcesOverride` (`src/EnabledSourcesOverride.php`), a
  `config.factory.override` (priority 100) on `project_browser.admin_settings`, adds every
  available category's derived source id to `enabled_sources` at runtime. Project Browser
  only serves listed sources, but these are derived, not authored — so the override keeps a
  contributing module from having to ship/keep-in-sync config. It deep-merges (augments),
  cache-tagged `commerce_project_browser_categories` (invalidated on module install/uninstall).

## The category plugin manager
`plugin.manager.commerce_project_browser_category` (`ProjectBrowserCategoryManager`) —
`DefaultPluginManager` over directory `Plugin/ProjectBrowserCategory`, attribute
`ProjectBrowserCategory`, interface `ProjectBrowserCategoryInterface`. Alter hook
`commerce_project_browser_categories`; cache tag `commerce_project_browser_categories`.
Key methods: `getAvailableDefinitions()` / `getAvailableCategories()` (filter to installed
`modules`), and static `getSourceId($category_id)` = `commerce_packagist_recipes:<id>`
(const `SOURCE_PLUGIN_ID`).

## Alter which categories are offered
```php
function mymodule_commerce_project_browser_categories_alter(array &$definitions): void {
  unset($definitions['commerce_shipping']);        // remove one
  // or mutate $definitions[$id]['label'|'modules'|'actionRoute'|'actionTitle']
}
```

## Recipe-side display metadata (optional, in a recipe's own composer.json)
The Packagist search result gives only the composer name + description. A recipe can supply
a human title and logo via an `extra` block read from the p2 metadata endpoint:

```json
{
  "type": "drupal-recipe",
  "keywords": ["commerce", "commerce_payment"],
  "extra": {
    "drupal/commerce_project_browser": {
      "title": "Commerce Recipe: Manual Payment",
      "logo": "https://git.drupalcode.org/project/.../-/raw/1.x/logo.png"
    }
  }
}
```
- `keywords` are OR-matched — tag the specific category AND `commerce` so it shows in both.
- `logo` must be a full public URL (a relative path cannot be resolved). A `logo.png` present
  on disk in the recipe dir takes precedence over `extra.logo` (served via the
  `administer modules`-gated local-logo route).
- `extra` is read only from `repo.packagist.org/p2/{name}.json` (or `…~dev.json`); the
  human `packagist.org/packages/{name}.json` summary omits `extra`. p2 is delta-encoded, so
  only the first version entry carries complete data.

## Centarro certified manifest (curator-controlled)
Certification is never self-asserted. To certify recipes, list their package names in the
`extra["centarro-certified-recipes"]` block of the `centarro/certified-projects` metapackage
(plain list or keyed map both accepted). Read from the newest tagged release, falling back to
the default branch when the release carries no manifest. Missing/unreachable manifest ⇒
nothing certified (fails closed). Certified recipes get a "Centarro Certified" badge/filter
and lead "Most popular"; alphabetical sorts are unaffected.

## Installing a browsed recipe
No code here participates. Project Browser + Package Manager stage the `composer require` and
core's `RecipeActivator` applies it. Package Manager refuses if `composer.lock` is stale vs
`composer.json` or a Composer plugin in use is not in
`package_manager.settings:additional_trusted_composer_plugins` — surfacing as an install
failure unrelated to the recipe.
