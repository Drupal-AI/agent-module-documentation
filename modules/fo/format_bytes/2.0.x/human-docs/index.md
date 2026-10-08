# Format Bytes — manual setup guide

**Format Bytes** (`format_bytes`) is a tiny theming helper for Drupal
developers. It registers a single Twig filter, `format_bytes`, that turns a raw
byte count into a friendly, human‑readable size string — for example `1048576`
becomes "1 MB" and `1073741824` becomes "1 GB". You use it inside any Twig
template by piping a numeric value through it.

Under the hood the filter is a thin wrapper around Drupal core's own
`ByteSizeMarkup::create()` (the same code core uses to render file sizes), so the
output is translatable and locale‑aware, uses binary steps of 1024, and covers
bytes through petabytes. Round values render without decimals; non‑round values
get two decimals (`1234567890` → "1.15 GB"). Because it is purely presentational
and stateless, it changes nothing about how data is stored — it only formats a
number at render time. It saves theme developers from writing a preprocess hook
or a custom Twig extension just to display a filesize nicely.

The module has no admin UI, no settings page, no permissions, and no dependencies
beyond Drupal core. It works the moment you enable it: the `format_bytes` filter
is immediately available in every template.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Format Bytes adds no admin pages, blocks, or settings. Its entire
surface is the Twig filter, which you use in template files in your theme or
module.

## How to use it

Once the module is enabled, pipe any numeric byte value through the filter in a
Twig template:

```twig
{# A managed file's stored filesize #}
{{ node.field_attachment.entity.field_file.entity.filesize.value | format_bytes }}

{# Any numeric variable #}
{{ total_bytes | format_bytes }}

{# A literal, to see it in action #}
{{ 1073741824 | format_bytes }}   {# renders "1 GB" #}
```

That's the whole module. If you need anything beyond formatting a number for
display, Format Bytes is not involved.
