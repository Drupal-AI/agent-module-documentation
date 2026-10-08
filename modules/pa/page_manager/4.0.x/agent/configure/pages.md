# Pages & variants (config entities)

Two config entity types (schema `config/schema/page_manager.schema.yml`):

## `page` (`Entity\Page`)
Exported keys: `id`, `label`, `description`, `use_admin_theme`, `path`, `access_logic`
(`and`/`or`), `access_conditions` (condition plugin configs), `parameters` (typed route
params, e.g. map `{node}` → entity type `node` for upcasting). `admin_permission =
administer pages`. A page owns an ordered set of `page_variant` entities.

Example install config ships at `config/install/page_manager.page.node_view.yml` (overrides
`/node/{node}`).

## `page_variant` (`Entity\PageVariant`)
Exported keys: `id`, `label`, `variant` (the DisplayVariant plugin id), `variant_settings`
(that plugin's config — blocks, layout, status code…), `page`, `weight`,
`selection_criteria` (condition plugin configs), `selection_logic` (`and`/`or`),
`static_context` (fixed contexts you attach).

## Routing / how a request resolves
`Routing\PageManagerRoutes` builds a route per enabled page. `Routing\VariantRouteFilter`
(priority -1024, runs last) picks the **first** variant, ordered by `weight`, whose
selection criteria pass against the available contexts; if none match, Page Manager yields so
the original route (if it was an override) still works. `PageAccessCheck` (`_page_access`)
enforces the page's access conditions.

Build these through the **page_manager_ui** wizard (Structure → Pages, route
`entity.page.collection`) or write the config YAML directly. Programmatically:
`\Drupal::entityTypeManager()->getStorage('page')` / `'page_variant'`.
