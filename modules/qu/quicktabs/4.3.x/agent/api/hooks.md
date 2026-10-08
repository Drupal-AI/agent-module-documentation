# Quick Tabs hooks & API

## `hook_quicktabs_instance_alter(QuickTabsInstance $qt)`

Declared in `quicktabs.api.php`. Alters a `quicktabs_instance` at render time —
inject a dynamic View argument, reorder, or hide tabs. Modify `$qt` in place
(reassigning the variable has no effect on the caller).

- Fires once per request, before rendering, on **both** render paths: the full
  tabset (`QuickTabsInstance::getRenderArray()`, used by the block) and an
  individual AJAX-loaded tab (`QuickTabsInstance::renderTab()`, used by
  `QuickTabsController`). A per-request guard ensures it runs only once per
  instance, so it is safe to append to config rather than replace it.
- Work with tab data via `$qt->getConfigurationData()` / `$qt->setConfigurationData()`.
- Reordering caveat: AJAX tab links carry the tab's numeric index, resolved
  against config *after* this hook. If you reorder, reindex keys `0..N` so the
  AJAX index still resolves to the intended tab.
- Cacheability: the instance is added as a cacheable dependency on both paths, so
  metadata you add here propagates to the block render and the AJAX response:

```php
function mymodule_quicktabs_instance_alter(\Drupal\quicktabs\Entity\QuickTabsInstance $qt) {
  if ($qt->id() === 'my_instance') {
    $tabs = $qt->getConfigurationData();
    $tabs[1]['content']['view_content']['options']['args'] = \Drupal::currentUser()->id();
    $qt->setConfigurationData($tabs);
    $qt->addCacheContexts(['user']);
  }
}
```

## Plugin discovery alter hooks

- `hook_quicktabs_tab_type_info` — alter discovered TabType definitions.
- `hook_quicktabs_tab_renderer_info` — alter discovered TabRenderer definitions.

## Services

- `plugin.manager.tab_type` — `TabTypeManager`, discovers TabType plugins.
- `plugin.manager.tab_renderer` — `TabRendererManager`, discovers TabRenderer plugins.

## Entity API

Load/create instances via entity storage, e.g.:

```php
$qt = \Drupal::entityTypeManager()
  ->getStorage('quicktabs_instance')
  ->load('my_instance');
$render = $qt->getRenderArray();
```

Instance getters/setters of note: `getConfigurationData()`,
`setConfigurationData()`, `getRenderArray()`, `renderTab()`, plus the exported
properties `renderer`, `options`, `hide_empty_tabs`,
`remember_last_clicked_tab`, `default_tab`.

No Drush commands are provided.
