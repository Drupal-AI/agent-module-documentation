# Twig Render This — manual setup guide

**Twig Render This** (`twig_render_this`) gives themers a single Twig filter,
`|renderThis`, that renders a Drupal entity, field item, or field item list to a
full render array from directly inside a Twig template. Instead of writing a
preprocess function or a `hook_theme` implementation just to turn an entity
variable into proper Drupal output, you pipe the variable through the filter and
Drupal renders it with all of its formatters, view-mode configuration, and cache
metadata intact.

The filter takes one optional argument — the view mode to render with, defaulting
to `default`. Feed it an entity and it builds the entity view through that entity
type's view builder; feed it a field item or field item list (or any object with a
`view()` method) and it calls that object's own `view()`. Anything it does not
recognise renders the harmless text "Twig Render This: Unsupported content."

This is a small, focused developer/theming tool: it adds no configuration screen,
no permissions, and no dependencies beyond core's Twig. You use it entirely by
writing filter expressions in your theme's templates. Because templates are
authored by trusted theme developers, deciding *what* to render — and making sure
the current user is allowed to see it — is up to you, exactly as with any other
Twig rendering.

This guide is written for a **human** working in a theme. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings form and nothing to configure. Once the module is
enabled, the `|renderThis` filter is immediately available in every Twig template.

## How to use it

Pipe any entity or field object through `|renderThis` in a template. The optional
argument chooses the view mode:

```twig
{# render a referenced node in the teaser view mode #}
{{ node.field_related.entity|renderThis('teaser') }}

{# render a field item list through its formatters #}
{{ content.field_body|renderThis }}

{# render an entity passed in by a preprocess function, full display #}
{{ my_entity|renderThis('full') }}
```

Common uses:

- Render the entity behind an entity‑reference field without adding a preprocess
  hook — for example a related node, a referenced media item, or a taxonomy term.
- Render a paragraph, user, or block content entity in a specific view mode from a
  parent or component template.
- Build reusable component templates that accept an entity variable and render it
  with `|renderThis`.
- Embed a full entity display inside a custom wrapper by rendering it in the
  `full` view mode.

Because the module renders through the entity view builder and each field's
formatters, the output keeps its cache metadata — you are not printing raw text,
you are producing the same markup Drupal would render anywhere else.
