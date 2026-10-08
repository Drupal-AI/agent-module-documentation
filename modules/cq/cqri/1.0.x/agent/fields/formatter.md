<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Container queries responsive image" formatter

## Install & enable

```bash
composer require drupal/cqri
drush en cqri -y
```

Depends only on Core **`responsive_image`** (which pulls in `breakpoint` and `image`). No sub-modules, no permissions, no Drush commands, no settings form.

The rendered output needs the **`container-picture-element`** JavaScript library at
`/libraries/container-picture-element/dist/container-picture.global.js`. Composer installs it via
`npm-asset/container-picture-element` `^0.1.0` when Asset Packagist (or an equivalent repository) is
configured — see the project README for the `composer.json` recipe. Without the library the correct
markup is produced but no container-size source switching happens in the browser.

## Build a responsive image style on the `cqri` breakpoint group

The module registers the breakpoint group **`cqri`** (`cqri.breakpoints.yml`) with a single
breakpoint `cqri.cqri` (empty `mediaQuery`, multiplier `1x`). Create a responsive image style whose
`breakpoint_group` is `cqri`, using **`sizes`** image-style mappings (the formatter and preprocess
code only handle `image_mapping_type == 'sizes'`).

A ready-to-use example ships at `config/install/responsive_image.styles.container_query.yml` and is
imported on install as the style id **`container_query`**:

```yaml
id: container_query
label: 'Container query'
breakpoint_group: cqri
image_style_mappings:
  - image_mapping_type: sizes
    image_mapping:
      sizes: '(min-width: 500px), (min-width: 250px), (min-width: 100px)'
      sizes_image_styles: [large, medium, thumbnail]
    breakpoint_id: cqri.cqri
    multiplier: 1x
fallback_image_style: '_empty image_'
```

The `sizes` conditions here become **container** queries (they are matched against the wrapping
element's inline size), not viewport media queries.

## Enable the formatter on an image field

The formatter (plugin id **`container_queries_responsive_image`**, label *"Container queries
responsive image"*) applies to **`image`** fields only (`ContainerQueriesResponsiveImageFormatter`,
`#[FieldFormatter(field_types: ['image'])]`).

UI path: *Structure → (bundle) → Manage display* → set the image field's format to **Container
queries responsive image** → gear icon → choose a responsive image style. The settings form
(`settingsForm()`) filters the style dropdown to only styles that `hasImageStyleMappings()` **and**
have `breakpoint_group == 'cqri'`, so plain Responsive Image styles are hidden.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_img.type container_queries_responsive_image -y
drush cset core.entity_view_display.node.article.default \
  content.field_img.settings.responsive_image_style container_query -y
drush cr
```

Config schema `field.formatter.settings.container_queries_responsive_image`
(`config/schema/cqri.schema.yml`) simply inherits Core's
`field.formatter.settings.responsive_image`, so the stored settings (`responsive_image_style`,
`image_link`) are identical to the Core formatter.

## Rendering pipeline (what actually happens)

1. **`ContainerQueriesResponsiveImageFormatter::viewElements()`** calls the parent
   `ResponsiveImageFormatter`, then rewrites each element's `#theme` from `responsive_image_formatter`
   to **`cqri_formatter`**.
2. **`cqri_formatter`** theme → `template_preprocess_cqri_formatter()` (`cqri.module`) delegates to
   `HookHandler\PreprocessCqriFormatter::preprocess()`, resolved through `class_resolver`. It runs
   Core's `template_preprocess_responsive_image_formatter()`, then renames `responsive_image` to
   `cqri_item`, sets its `#theme` to **`cqri_item`**, and attaches library `cqri/cqri`.
3. **`cqri_item`** theme → `template_preprocess_cqri_item()` delegates to
   `HookHandler\PreprocessCqriItem` (a `ContainerInjectionInterface` service using
   `entity_type.manager`, `breakpoint.manager`, `image.factory`). It runs Core's
   `template_preprocess_responsive_image()`, **unsets `srcset` and `sizes`**, sets
   `output_image_tag = FALSE`, loads the responsive image style, and builds `<source>` attributes via
   `buildSourceAttributes()`.
4. `buildSourceAttributes()` mirrors Core's `_responsive_image_build_source_attributes()` but, for
   each `sizes` entry, sets a **`container`** attribute (the trimmed `sizes` condition) on the source
   instead of a viewport `media`/`sizes` attribute, plus `srcset` (width-descriptor derivatives) and a
   single `type` when all derivatives share one MIME type. The fallback image style provides the
   controlling `<img>` with width/height for aspect-ratio reservation.

## Emitted markup & the JS library

- `templates/cqri-formatter.html.twig`: when there is no link, wraps output in
  `<div class="cqri-container" style="container-type: inline-size">…</div>` (this establishes the CSS
  query container); when the field is linked, wraps in `<a href="{{ url }}">`.
- `templates/cqri-item.html.twig`: emits a **`<container-picture>`** custom element containing
  `<source … container="(min-width: …)"/>` tags and the fallback `<img>`.
- Library `cqri/cqri` loads `container-picture.global.js` as `type="module"` from
  `/libraries/container-picture-element/…`; the custom element reads the `container` attributes and
  selects the matching source based on the container's inline size.

## Gotchas

- Only **`sizes`**-type mappings are handled; a style using per-multiplier `image` mappings won't
  produce `<source>` tags here.
- The style dropdown is empty until at least one responsive image style exists on the `cqri`
  breakpoint group — the code has a `@todo` noting it does not show an error when none is found.
- `fallback_image_style: '_empty image_'` in the shipped style means no real fallback derivative; set
  a real fallback style if you want a graceful no-JS / unsupported-browser image.
- This is a `1.0.0-alpha2` release and the underlying `container-picture-element` library is itself in
  early development (`^0.1.0`).
