<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events & JS widget-change hook

## `TriggerWidgetChangeJavaScriptEvent`
Symfony event dispatched by `FacetsForm::buildForm()` for each rendered form. It lets third-party
code opt the form into dispatching a client-side JS event when a user changes a widget. By default
the JS event is **off**.

Subscribe and call `->triggerWidgetChangeEvent()` (or `->disableTriggerWidgetChangeEvent()`):
```php
public static function getSubscribedEvents(): array {
  return [TriggerWidgetChangeJavaScriptEvent::class => 'onEvent'];
}
public function onEvent(TriggerWidgetChangeJavaScriptEvent $event): void {
  // $event->getFacetsSourceId(), $event->getBlockSettings()
  $event->triggerWidgetChangeEvent();
}
```
When at least one subscriber enables it, `FacetsForm` attaches the `facets_form/plugin.<widget_id>`
library for each widget that has a JS snippet, plus `facets_form/plugin_base`. See the
`facets_form_live_total` submodule for a working use case.

## Widget JS snippets (auto-discovered libraries)
`hook_library_info_alter()` (`facets_form.module`) auto-creates a library
`plugin.<widget_id>` for every eligible widget that ships a file at
`<provider>/js/plugin/<widget_id>.js` (`facets_form_get_plugins_with_js_snippet()`). A base
`plugin_base` library (`js/plugin_base.js`, deferred) depends on all of them. So: to add live JS
behavior to a widget, just drop `js/plugin/<widget_id>.js` in the widget's module — no
`.libraries.yml` entry needed. The browser widget-change event is named `facets_form`.

## Query-type mapping hook (used by submodules)
Submodules that add a custom `@FacetsQueryType` register it with core Facets via
`hook_facets_search_api_query_type_mapping_alter($backend_plugin_id, array &$query_types)`, e.g.
`$query_types['facets_form_date_range'] = 'facets_form_date_range_query_type';`.
