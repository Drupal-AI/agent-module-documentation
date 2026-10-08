# Colorizer Classes — manual setup guide

**Colorizer Classes** (`colorizer_classes`) is a small theming helper that turns a
colour value stored in Drupal into a CSS class name in your markup. It provides a
single Twig filter, `colorizer`, so a template can take something like
`#FFFFFF` and print `color-white` instead — a class your theme's CSS can then
style. It was built to pair with modules such as
[Color Field](https://www.drupal.org/project/color_field), which let an editor
pick a colour visually in the admin interface while your front end outputs a tidy,
predictable CSS class rather than an inline colour.

This is a developer/theming tool, not a content or access feature. It has no
runtime effect until you actually use the filter in a template. It ships one small
settings page where you define the mappings from stored values to class names. It
works on Drupal 9, 10, and 11 and has no other module or library dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Colorizer Classes adds one settings page at **Configuration › Media › Colorizer
Classes Settings** (`/admin/config/media/colorizer_classes`), which requires the
*Administer site configuration* permission. It holds a single **Color Classes
Mapping** textarea where you list the mappings, one per line, in `KEY|VALUE`
form — the stored value on the left, the CSS class to output on the right, for
example:

```
#000000|color-black
#FFFFFF|color-white
```

(Those two lines are the shipped default.) Matching is case-insensitive, and any
spaces or line breaks in the value you pass to the filter are ignored. If a value
has no matching line, the filter returns it unchanged. The actual styling still
happens in your theme's Twig templates using the filter below.

## How to use it

Once the module is enabled, the `colorizer` Twig filter is available in any
template. Pass it a colour value and it returns a CSS class name:

```twig
<div class="{{ '#FFFFFF'|colorizer }}"> {# → class="color-white" #}
  …
</div>
```

A common pattern is to feed it a value coming from a colour field an editor set on
the content, so the rendered markup carries a matching class (for example
`color-white`, `color-black`) that your theme's stylesheet targets. You supply the
CSS rules for those class names in your theme.
