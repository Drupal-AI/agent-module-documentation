<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route, builder service & SDC preview

## Install / enable

`drush en artisan_styleguide -y`. Composer requires the **Artisan theme** (`drupal/artisan ^1.1`)
and core `serialization`. No config to import, no schema, no forms. After enabling, browse to
`/artisan-styleguide` as a user with **`administer themes`**.

## Route (`artisan_styleguide.routing.yml`)

- `artisan_styleguide.preview` → path `/artisan-styleguide`, title *"Artisan Styleguide Preview"*.
- `_controller: \Drupal\artisan_styleguide\Controller\ArtisanStyleguideController` — an
  **invokable** controller (`__invoke()`), extends `ControllerBase`, injects
  `artisan_styleguide.builder` via `create()`. `__invoke()` just returns
  `$this->styleguideBuilder->build()`.
- `requirements: _permission: 'administer themes'` — core permission; the module defines **no**
  permissions of its own. Same route is the module's `configure:` link in info.yml.

## Service `artisan_styleguide.builder`

Class `Drupal\artisan_styleguide\ArtisanStyleguideBuilder implements ArtisanStyleguideBuilderInterface`
(`artisan_styleguide.services.yml`), args `@renderer` (`RendererInterface`) and
`@plugin.manager.sdc` (`ComponentPluginManager`). Overridable — register a service that decorates
or replaces it (implement `ArtisanStyleguideBuilderInterface`) to filter/group/reorder components.

Interface methods: `build()`, `getIntroNotes()`, `componentDefinitionPreview($plugin_id, $definition)`,
`componentDefinitionPreviewProcessProps(...)`, `componentDefinitionPreviewProcessSlots(...)`.

### `build()`

1. `foreach ($this->pluginManagerSdc->getDefinitions() as $plugin_id => $definition)` — every SDC
   registered on the site (from any module/theme), not just this module's.
2. Builds `#theme => 'artisan_styleguide'` with `#cache max-age 0`, `#intro_notes` (from
   `getIntroNotes()`) and `#components` (one entry per component).

### `componentDefinitionPreview($plugin_id, $definition)`

- Seeds `$component = ['#type' => 'component', '#component' => $plugin_id, '#props' => [], '#slots' => []]`.
- `componentDefinitionPreviewProcessProps()`: for each `$definition['props']['properties']`, if the
  prop has no `examples` → adds a clarification and skips; else takes `reset($prop_def['examples'])`.
  If the prop `type` is a class name that `class_exists()` (e.g. `Drupal\Core\Template\Attribute`),
  it instantiates `new $class(reset($examples))`; otherwise uses the scalar example directly.
- `componentDefinitionPreviewProcessSlots()`: for each `$definition['slots']`, no `examples` → skip
  with a clarification; else takes the first example. A **string** example becomes
  `['#type' => 'inline_template', '#template' => $example]`; an array example is used as-is.
- Renders via `$this->renderer->renderPlain($to_render)`. On `\Exception` it sets `status = FALSE`
  and records the exception message plus a "no attached CSS/JS in preview" note.
- Status is also forced FALSE when props+slots were all empty, or when the stripped output is empty
  (ignoring `<img>`). On success it appends *"It should look great!"*.
- Returns `#theme => 'artisan_styleguide__component'` with `#status`, `#plugin_id`, `#name`,
  `#rendered`, `#component`, `#clarifications`, and `#weight = -9999` for the bundled
  `artisan_styleguide:artisan-styleguide-sdc-model` (pins the reference component to the top).

### `getIntroNotes()`

Four translatable notes about Artisan theming conventions: using CSS custom properties like
`--theme-palette-primary`, the `var(--x, var(--fallback, value))` pattern, and defining props vs.
slots correctly.

## Theme hooks & templates (`artisan_styleguide.module`)

- `artisan_styleguide` (vars `intro_notes`, `components`) →
  `templates/artisan-styleguide.html.twig` (heading, notes list, prints `{{ components }}`).
- `artisan_styleguide__component` (vars `plugin_id`, `name`, `status`, `rendered`, `component`,
  `clarifications`) → `templates/artisan-styleguide--component.html.twig` (green "OK" / red "KO"
  heading, the preview, and a clarifications list). Bootstrap 5.3 utility classes throughout.

## Bundled reference component

`components/artisan-styleguide-sdc-model/` — `*.component.yml` declares one example of every prop
type (`string`, `uri`, `regex`, `boolean`, `integer`, `number`, `object`, array of strings, array
of objects, enum of strings/numbers, font icon, and two `Drupal\Core\Template\Attribute` props)
and three slots (renderable Twig string, HTML string, renderable array). Its `.twig` shows how each
is rendered; `.html.twig` is an `embed` example mapping node/field values into props/slots. Use it
as the canonical example when authoring your own SDCs — every previewed component is validated the
same way.

## Operating notes

- All preview input is **developer-authored on-disk component metadata**; the page takes no request
  parameters, so output reflects your component definitions only.
- Previews are uncached (`max-age 0`); on a site with many components each request re-renders all of
  them. It is an admin-only dev tool, so this is a performance note, not an access concern.
