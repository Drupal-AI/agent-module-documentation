# Canvas plugin types

Canvas defines three plugin managers. All plugin classes are `@internal` in 1.x, but these
are the documented extension points.

## 1. Component sources — `canvas.component_source`
- Manager: `Drupal\canvas\ComponentSource\ComponentSourceManager`
- Attribute: `Drupal\canvas\Attribute\ComponentSource`
- Directory: `src/Plugin/Canvas/ComponentSource/`
- Interface: `Drupal\canvas\ComponentSource\ComponentSourceInterface` (base: `ComponentSourceBase`)
- Alter hook name: `canvas_component_source`

A ComponentSource teaches Canvas how to discover a family of components, describe their
props/slots as JSON-Schema shapes, build their config-form/inputs, and render an instance.
Built-in plugins:
- `SingleDirectoryComponent` — Drupal SDC components (`*.component.yml`).
- `BlockComponent` — core/contrib Block plugins exposed as components.
- `JsComponent` — JavaScript code components (`js_component` config entities).
- `Fallback` — placeholder for a missing/removed component so the tree still renders.

Implement one to add a new kind of component (e.g. remote/React-Server, Web Components).

## 2. Builder extensions — `canvas.extension`
- Manager: `Drupal\canvas\Extension\CanvasExtensionPluginManager`
- Attribute: `Drupal\canvas\Extension\CanvasExtension`
- Discovery: **YAML**, file `{module}.canvas_extension.yml` (skips annotation scan)
- Interface: `CanvasExtensionInterface`; type enum `CanvasExtensionTypeEnum`
- Alter hook name: `canvas_extension_info`
- Discovery cache is tagged `config:core.extension` (installing/uninstalling a module reindexes).

Registers a client-side extension surfaced in the Canvas UI. Each entry keyed by extension id
supports:
- `name` (required), `description` (required)
- `icon` — path to an SVG (absolute, or relative to the module, no leading `/`; optional)
- `url` — fully-qualified URL, or a path relative to the providing module (e.g. `dist/index.html`)
- `type` — `canvas` (a full extension page, deep-linked via `/canvas/app/{extension_id}`) or
  `code-editor` (augments the code-component editor). Default: `canvas`.
- `api_version` — Canvas Extension API version (e.g. `'1.0'`).
- `permissions` — optional list of permissions required to use the extension (default: none).

The React app renders the extension in an iframe.

## 3. Adapters — `canvas.adapter`
- Manager: `Drupal\canvas\Plugin\AdapterManager`
- Directory: `src/Plugin/Adapter/`
- Annotation: `Drupal\canvas\Annotation\Adapter`; interface `AdapterInterface` (base `AdapterBase`)
- Alter hook name: `canvas_adapter_manager_info`

Adapters transform/convert data values between shapes when wiring props (data adaptation in
the prop-source / shape-matching pipeline). Built-in adapters: `DayCountAdapter`,
`ImageAdapter`, `ImageAndStyleAdapter`, `ImageUriAdapter`, `UnixTimestampToDateAdapter`.

## Related pre-save plugin attributes (internal)
`src/Attribute/ComponentPreSaveUpdate.php` and `NotAppliedOnComponentPreSave.php` mark
component pre-save update routines — internal versioning machinery, not a general extension
point.
