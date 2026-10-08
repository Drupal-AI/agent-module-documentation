# classy_paragraphs — agent start

Editor-selectable CSS classes for Paragraphs. Site builders define reusable **styles**
(named sets of classes) as `classy_paragraphs_style` **config entities**; editors pick one
via a core **entity-reference field** whose target type is `classy_paragraphs_style`. On
render, the module merges the referenced classes into the entity's `#attributes['class']`
(the `{{ attributes.class }}` Twig variable). Depends on `paragraphs`.

Config UI: **Admin → Structure → Classy paragraphs style** (`/admin/structure/classy_paragraphs_style`),
configure route `entity.classy_paragraphs_style.collection`. Gated by core permission
*administer site configuration* (no permission of its own). No Drush commands, no custom field type.

- Create/manage styles + add the class field to a bundle (drush + config) → [configure/classy_paragraphs.md](configure/classy_paragraphs.md)
- The `classy_paragraphs` EntityReferenceSelection handler (filter/sort options) → [plugins/classy_paragraphs.md](plugins/classy_paragraphs.md)
- Programmatic API: config entity shape, `getClasses()`, the render alter → [api/classy_paragraphs.md](api/classy_paragraphs.md)
