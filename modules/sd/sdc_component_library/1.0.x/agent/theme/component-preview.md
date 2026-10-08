# Component preview page (theme hook + render flow)

Route `sdc_component_library.component_list` →
`\Drupal\sdc_component_library\Controller\ComponentsController::content`. The
controller is built by `create()` with `@plugin.manager.sdc` (core
`\Drupal\Core\Theme\ComponentPluginManager`) and `@theme.manager`.

## Discovery (`content` → `findComponentsWithWarnings`)

- Calls `$pluginManager->getDefinitions()` — **every** SDC registered on the site
  (all themes and modules), not only the active theme. No route parameter or request
  input selects components; the page always lists all of them.
- For each definition, looks for `<path>/<machineName>.story.twig` (from the
  component's own `path`, checked with `file_exists`, then made relative to
  `DRUPAL_ROOT`). Present → the component is rendered; absent → a "missing
  `.story.twig`" placeholder.
- Sort order: active-theme provider first, then provider, group, title.

## Render (`buildRenderArray` + template)

- Returns `#theme => 'component_preview'`, `#components => [...]`, attaching libraries
  `sdc_component_library/axe_core` and `sdc_component_library/components_preview`.
- Theme hook `component_preview` is declared in `sdc_component_library_theme()`
  (`.module`); its only variable is `components`. Template:
  `templates/component-preview.html.twig`.
- The template renders each component with `{% include component.twig_template only %}`
  — the `.story.twig` file supplies its own dummy data, and `only` passes no outer
  context. A per-component "Show code" block prints an example
  `{% include 'active_theme:machine' with {…} %}` snippet built from each prop's
  `examples[0]` (Twig auto-escaped output).
- On any `\RuntimeException`, `content()` returns a plain `#markup` error message
  instead of the render array.

## Per-component data keys

`title`, `machine_name`, `provider`, `description`, `group`, `props`,
`example_data`, `libraryDependencies`, `type`, `twig_template` (relative path or
`NULL`), `missing_template`.

## Make a component appear

Place a sibling `<machine>.story.twig` in the SDC's folder that includes the
component with sample props, e.g.:

    {# button.story.twig #}
    {% include active_theme() ~ ':button' with { label: 'Click Me' } only %}

Props/example data shown in the "Show code" panel come from the component's own
`*.component.yml` schema (`props.properties.*.examples`).

## Assets / accessibility

- `sdc_component_library/components_preview` = `assets/css/components-preview.css` +
  `assets/js/components-preview.js` + `assets/js/axe-core.js`.
- `sdc_component_library/axe_core` = `assets/js/axe.min.js` (depends on `core/jquery`).
- The page runs an axe-core scan and lists accessibility issues in an in-page panel
  (explicitly noted as non-exhaustive). The JS also provides sidebar search, a single
  active-component view (persisted in `localStorage`), show/hide code, and copy-to-clipboard.
