<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Server-side handlers & runtime

How a placed component is rendered and how server data reaches the browser. The block plugin
`JSComponentBlockType` (`Plugin/Block/JSComponentBlockType.php`, id `js_component`, one derivative
per component) drives everything.

## Data flow at render
1. Block `build()` resolves the `JSComponent` instance and renders either the Twig template
   (`#theme` = component id) or an inline `<div id="{root_id}">`.
2. Settings entered in the block form live in block config `js_component`; on output they are
   token-processed (if `settings_allow_token`) and empties stripped, then published to
   `drupalSettings.jsComponent[<plugin_id>][<root_id>].settings` (scope `dom`) or written as
   `data-<key>` attributes (scope `attribute`).
3. `data` is built by dispatching `BuildComponentDataEvent` and published to
   `drupalSettings.jsComponent[<plugin_id>][<root_id>].data`.
4. The component library `js_component/<component_id>` is attached if it exists.

## Data providers — `JsComponentDataProviderInterface`
Declare a class under `handlers.data_provider` in the YAML. It must implement `fetch(): array`;
extend `JsComponentDataProviderBase` to get a constructor that receives the component
`$configuration` (and, via `create()`, the service container). Its returned array is merged into the
component's `data`.

```php
class MyDataProvider extends JsComponentDataProviderBase {
  public function fetch(): array {
    return ['items' => [...]];   // → drupalSettings.jsComponent[<id>][<root>].data
  }
}
```

## Custom settings form — `JSComponentFormInterface`
Declare a class under `handlers.component_form` to replace the auto-generated settings form (e.g. to
add AJAX or validation). Extend `JSComponentBaseForm` (implements build/validate/submit +
`getConfiguration()` + AJAX wrapper helpers). The block calls `buildComponentForm()`,
`validateComponentForm()`, and `submitComponentForm()` as a subform. If a `component_form` handler is
present it takes precedence over the simple auto-built elements.

Both handler kinds may opt into container injection by implementing
`JsComponentInjectContainerInterface::create(array $configuration, ContainerInterface $container)`;
otherwise they are constructed with just `$configuration`.

## Build-data event — `js_component.build_component_data`
Constant `Events::BUILD_COMPONENT_DATA`. Subscribe to `BuildComponentDataEvent` to contribute data
without a data-provider class. The event exposes `getComponent()`, `getConfiguration()`, and
`addComponentData(array $data)`; all collected arrays are `array_replace_recursive`-merged into the
component `data`. The module's own `JSComponentBuildEventSubscribe` already adds (a) any
`component_data` from block config and (b) the `data_provider` handler's `fetch()` output.

## Programmatic access to the manager
Service `plugin.manager.js_component` (`JSComponentManagerInterface`):
- `getDefinitions()` / `getDefinitionInstances()` — all discovered components (as `JSComponent`
  instances, keyed by plugin id).
- `createInstance($plugin_id, ['overrides' => ['root_id' => ...]])` — instantiate one; `overrides`
  currently supports `root_id`.

`JSComponent` instance accessors: `label()`, `rootId()`, `settings()`, `settingsScope()`,
`settingsAllowToken()`, `libraries()`/`hasLibraries()`/`processLibraries()`, `template()`/
`hasTemplate()`/`getTemplatePath()`/`getTemplateName()`, `provider()`, `componentId()`,
`classHandlers()`, `settingsClassHandler()`, `dataProviderClassHandler()`, `getProviderPath()`.
