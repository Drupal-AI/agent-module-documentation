# The component block — `component` / `component:<name>`

Every `type: block` component becomes a derived block. Base plugin id `component`
(`Drupal\component\Plugin\Block\ComponentBlock`), deriver
`Drupal\component\Plugin\Derivative\ComponentBlockDeriver`. The derived id is `component:<machine_name>`
(e.g. `component:example_tabs` when `component_example` is enabled). Place it via Layout Builder, the
Block layout UI, or any block-consuming API — it behaves like a normal block. Placing/configuring
requires the core **`administer blocks`** permission (there is no module-specific permission).

## Deriver (`ComponentBlockDeriver.php`)

For each `block` component it copies the base definition and sets:
`['info' => <full component data>]`, `admin_label = <component name>`, `cache = <component cache>`,
and, if the yml has `contexts: {entity: <type>}`, `context = ['entity' => new
ContextDefinition('entity:<type>')]`. Only the `entity` context key is handled.

## Render — `ComponentBlock::build()` (`ComponentBlock.php:70`)

```php
$build['#attached']['library'] = ['component/<machine_name>']; // if js/css present
$build['#theme']            = $component['theme'] ?? 'component_html';
$build['#html_template']    = file_get_contents($component['path'] . $component['template']);
$build['#content_attributes'] = $this->buildAttributes();
$build['#cache']           = $component['cache'];
```

- **Template body** — `getTemplate()` reads the component's on-disk template file
  (`path . template`, default `index.htm`) with `file_get_contents` and the theme
  (`component-html.html.twig`) prints it as `{{ html_template|raw }}` inside `<div{{ content_attributes }}>`.
  The template file ships on disk with the component (developer-authored); it is not chosen or
  supplied by a request.
- **Data attributes** — `buildAttributes()` sets `id = "<machine_name>-<uuid>"` (a fresh UUID **per
  render** — the block is not statically cacheable across the id) and `class = <machine_name>`, then
  adds one `data-<key>` attribute per config item from `getComponentConfig()`: the yml
  `static_configuration` merged with the per-block `form_configuration`. Array values are
  `json_encode`d; empty array members are filtered out. This is how the browser-side JS receives its
  parameters (read off the parent element / `data-*`).
- **Cache** — taken verbatim from the yml `cache` key (default `{max-age: 0}`, i.e. uncached).

## Per-block settings form

If the yml declares `form_configuration`, `ComponentBlock::buildConfigurationForm()` renders a
`Component Settings` details element built by `createElementsFromFormConfiguration()`: each entry
becomes a Form API element where every yml property `foo: bar` maps to `#foo => bar` (so `type`,
`title`, `options`, `default_value`, etc. are passed straight through — there is **no allow/deny
list** on which `#property` keys may be set; see the module's own `@todo`). Submitted values are
stored in the block config under `form_configuration` and re-emitted as `data-*` attributes on the
next render.

Example `form_configuration` (from `example_config.component.yml`):

```yaml
form_configuration:
  name:
    type: textfield
    title: 'Name'
    default_value: 'Leonard McCoy'
  greeting:
    type: select
    title: 'Greeting'
    options: { Dr: Dr, Mr: Mr, Ms: Ms }
    default_value: 'Dr'
```

## Unused/dead paths

`getJsContexts()` / `addEntityJsContext()` (`ComponentBlock.php:275-312`) build serialized entity
JS contexts but are never called by `build()` (flagged `@todo Fix methods below`). No entity data is
actually emitted to the page by this version.
