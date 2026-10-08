Artisan Styleguide renders a living style guide at `/artisan-styleguide` that auto-previews every Single Directory Component (SDC) on the site using each component's own example props and slots.

---

Artisan Styleguide is a theme-development aid that ships with (and is intended for) the Artisan theme. When enabled it exposes a single admin page, `/artisan-styleguide`, gated by the core `administer themes` permission. The controller delegates to the `artisan_styleguide.builder` service, which asks the core SDC plugin manager (`plugin.manager.sdc`) for every registered component definition and builds a render array for each. For each component it reads the `examples` declared under the component's `props` and `slots` in its `*.component.yml`, wires those example values into a `#type => component` render array, renders it with `renderPlain()`, and reports an OK/KO status plus human-readable "clarification" notes when a component cannot be previewed (missing examples, empty output, or a render exception). The page also prints intro notes on how Artisan expects CSS custom properties and prop/slot definitions to be structured. The module bundles one reference component, `artisan_styleguide:artisan-styleguide-sdc-model`, whose YAML and Twig files exhaustively demonstrate every supported prop type and slot kind and act as copy-paste documentation for authoring your own SDCs. The builder is a normal, overridable Drupal service, so a project can swap in its own implementation of `ArtisanStyleguideBuilderInterface`. The module has no config forms, no permissions of its own, no config schema, and no Drush commands.

---

- Preview every SDC registered on the site on one page during theme development.
- Verify a newly authored component renders before wiring it into templates.
- Catch components that fail to render (KO status) and read the exact render exception message inline.
- Detect components missing `examples` for their props or slots (a clarification note flags each one).
- Detect components that produce empty output so you can fix the definition or examples.
- Learn the correct `*.component.yml` structure by studying the bundled `artisan-styleguide-sdc-model` component.
- See how each SDC prop type (string, uri, regex, boolean, integer, number, object, array of strings, array of objects, enum of strings, enum of numbers, font icon) should be declared and rendered.
- See how a `Drupal\Core\Template\Attribute` prop is declared and passed to a component.
- See the difference between a "prop" (simple scalar value) and a "slot" (renderable block) with working examples.
- Copy slot patterns: a renderable Twig string, an HTML string, and a renderable array (image / image_style / responsive_image / markup).
- Onboard new front-end developers to a project's component library visually.
- Sanity-check that a component library still renders after a Drupal or theme upgrade.
- Confirm Bootstrap 5.3 utility classes and theme CSS variables resolve correctly in component output.
- Use the reference component's `artisan-styleguide-sdc-model.twig` as a starting scaffold for a new component.
- Use the reference `.html.twig` example to see how to `embed` a component and map field values into props/slots.
- Provide designers and reviewers a single URL to review all components in one pass.
- Confirm accessibility/markup expectations (the model component documents BEM naming and AA guidance inline).
- Override `artisan_styleguide.builder` with a custom `ArtisanStyleguideBuilderInterface` to filter, group, or reorder previewed components.
- Reach the style guide quickly from the module's "Configure" link on the Extend/modules page (it points at the preview route).
- Confirm a component's slot accepts both scalar Twig strings and full render arrays as intended.
- Validate that props with `enum` constraints only render the allowed values.
- Keep the reference component first in the listing (the builder weights `artisan-styleguide-sdc-model` to the top) as a permanent example.
