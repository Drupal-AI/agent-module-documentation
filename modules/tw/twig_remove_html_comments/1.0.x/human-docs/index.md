# Twig - Remove HTML comments — manual setup guide

**Twig - Remove HTML comments** (`twig_remove_html_comments`) is a tiny theming
helper that adds two Twig filters for stripping HTML comments
(`<!-- ... -->`) out of rendered markup inside your templates. It's for the times
when content or upstream markup carries comments you don't want visitors to
receive — editor/debug notes, WYSIWYG or pasted-in comment cruft, framework
comments in third-party embeds, or internal annotations kept in the source but not
meant for display.

The whole module is a single Twig extension. It registers two filters:
`remove_html_comments`, which gives you the cleaned markup ready to print, and
`remove_html_comments_as_string`, which gives you the cleaned value as a plain
string you can reuse in another expression. There's a small side effect worth
knowing up front: the filter also strips **all newlines** from the value (not just
the whitespace around comments), so the output ends up collapsed onto one line —
handy for inline output, but keep it in mind where whitespace matters.

There is nothing to configure: enabling the module registers the filters globally,
and you use them in your Twig templates (`configure: null`). This guide is written
for a **human** working in the theme layer; if you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead. The module depends on Drupal core only, has no submodules, and adds
no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere. It has no admin page, settings form or menu entry. Its value is the two
Twig filters, available in any template once the module is enabled.

## How to use it

Use the filters in a Twig template. Because the filters work on already-rendered
markup, pipe a field or value through `|render` first so the filter receives a
string:

```twig
{# Print cleaned output as markup. #}
{{ content.field_my_field|render|remove_html_comments }}

{# Or capture the cleaned value as a string to reuse. #}
{% set clean = content.field_my_field|render|remove_html_comments_as_string %}
{{ clean|raw }}
```

Both filters remove HTML comments, including multi-line ones, and — as noted above
— also collapse newlines out of the result. A `NULL` input safely yields an empty
value. Developers can also call the underlying service directly from PHP if
needed; see the [`agent/`](../agent/start.md) docs for the exact behaviour and the
service method names.
