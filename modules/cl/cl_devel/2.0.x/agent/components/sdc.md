<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped SDC components, theme hook & library

The module ships two of its own Single Directory Components (in `components/`) used to render the
detail page, plus one classic theme hook used by the audit cards.

## `cl_devel:component-details`

- Files: `components/component-details/component-details.component.yml` / `.twig` / `.css`.
- `status: stable`. `libraryOverrides.dependencies: [core/drupal]`.
- Props: `attributes` (`Drupal\Core\Template\Attribute`), `name`, `machineName` (pattern
  `^[a-z]([a-zA-Z0-9_-]*[a-zA-Z0-9])*$`), `id` (pattern `…:…`), `description`, `status` (enum
  `experimental|stable|deprecated|obsolete`), `thumbnailHref`, `props` (object), `slots` (object).
- Slot `documentation` — the component's README as HTML.
- The `.twig` renders an ID/machine-name/status table, includes `cl_devel:image-with-fallback`,
  a README block, a slots list, and a per-prop schema table (`props.properties`, each value
  `json_encode`d).
- Rendered by `ComponentDetails::details()` (see [../routes/audit.md](../routes/audit.md)).

## `cl_devel:image-with-fallback`

- Files: `components/image-with-fallback/image-with-fallback.component.yml` / `.twig` / `.css` and
  `img/fallback-image.svg`.
- `status: stable`. Props: `imageSrc` (string), `emptyWidth` (number), `emptyHeight` (number).
- Renders the image at `imageSrc`, or an empty div sized `emptyWidth`×`emptyHeight` with the SVG
  fallback background when no source is given. Reusable standalone in your own templates.

## Theme hook `cl_label_with_link`

- Declared in `cl_devel.module` via `hook_theme()`; variables `label`, `href`.
- Template `templates/cl-label-with-link.html.twig` renders an `<h4>` with the label and a `🔗`
  anchor, and attaches library `cl_devel/cl_registry`.
- Used by `ComponentAudit::buildComponentCard()` for each card title.

## Library `cl_devel/cl_registry`

- Defined in `cl_devel.libraries.yml`; single component CSS `src/assets/css/cl-registry.css`.
- Attached by the audit render array and by the `cl_label_with_link` template.
