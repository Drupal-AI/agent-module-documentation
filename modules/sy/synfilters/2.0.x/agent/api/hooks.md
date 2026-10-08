<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synfilters hooks & install behavior

All logic lives in three thin entry points in `synfilters.module` /
`synfilters.install`, each forwarding to a static method. There is no configuration,
no service, and no plugin. Everything is keyed to one View: **id `product`, display `embed`**
(the exposed form `#id` `views-exposed-form-product-embed`).

## Install: `synfilters_install()` → `update_views_view_product()`
File: `synfilters.install`.

On enable it edits the existing `views.view.product` config (via
`\Drupal::configFactory()->getEditable('views.view.product')`):
- Appends `taxonomy.vocabulary.product_options` to `dependencies.config` (if missing).
- Appends `taxonomy` and `better_exposed_filters` to `dependencies.module` (if missing).
- Saves with `->save(TRUE)`.

If no `views.view.product` config exists, `getEditable()` returns an empty editable config and
the method still saves — so it is only meaningful on a site that already has that View. It is
idempotent (guards each value with `in_array`). It does **not** create the View.

## `hook_form_views_exposed_form_alter()` → `FormViewsExposedFormAlter::hook()`
File: `src/Hook/FormViewsExposedFormAlter.php`.

Runs for every Views exposed form, but acts only when **all** hold:
1. `$form['#id'] === 'views-exposed-form-product-embed'`.
2. The current route has a `taxonomy_term` parameter and it is a `TermInterface`
   (`\Drupal::routeMatch()->getParameter('taxonomy_term')`).
3. That term has children: `entityTypeManager()->getStorage('taxonomy_term')
   ->loadTree($term->bundle(), (int) $term->id())` returns a non-empty array.

Effect: sets `$form['#prefix'] = '<div class="hidden">'` and `$form['#suffix'] = '</div>'`,
i.e. it hides the exposed filter form (leaf terms — no children — keep their filters visible).
`#prefix`/`#suffix` are static literals; no request or entity data is interpolated into markup.

## `hook_views_pre_render()` → `ViewsPreRender::hook()`
File: `src/Hook/ViewsPreRender.php`.

Acts only when `$view->id() === 'product'` and `$view->current_display === 'embed'`.

Effect: resolves the current path
(`\Drupal::service('path.current')->getPath()`), converts it to its alias
(`\Drupal::service('path_alias.manager')->getAliasByPath($current_path)`), and assigns that alias
to `$view->exposed_widgets['#action']`. This makes the exposed form submit to the current page's
clean/aliased URL instead of the raw internal path. If the path has no alias, `getAliasByPath()`
returns the internal path unchanged.

## Notes / changes vs 8.x-1.x
- Same three behaviors as the 1.x line; 2.x moves the two hook bodies into dedicated
  `src/Hook/*` classes (typed `public static function hook(...)`) and requires **Drupal 11/12**
  (`core_version_requirement: ^11 || ^12` in `synfilters.info.yml`) — earlier docs listed
  `^8||^9||^10||^11`.
- There is **no** `composer.json` in the module and **no** `config/schema/`; the earlier
  data.json claim of `provides_config_schema: true` was incorrect and is now `false`.
- Operate it by simply enabling the module on a site that runs the matching `product` catalog
  View; there is nothing to configure afterward.
