# Decor — manual setup guide

**Decor** (`decor`) is a small accessibility helper that marks purely
*decorative* images so that screen readers and other assistive technologies skip
over them. Following WCAG guidance, decorative images should carry an empty `alt`
attribute rather than a description — otherwise assistive tech announces noise
that adds nothing for the reader. Decor takes care of that automatically for any
image you tell it is decorative.

The way you "tell it" is refreshingly simple: add the CSS class `js-decor` to any
container element in your Twig templates — a hero, a card, a teaser, or any
wrapper. Every image inside that container is then treated as decorative. Decor
instantly applies an empty `alt=""`, adds `role="presentation"`, and removes any
`title` attribute, which removes those images from the browser's accessibility
tree. There are no custom fields to create and no extra markup to write beyond
that one class.

Concretely, Decor helps you satisfy **WCAG Technique H67** (using null alt text
and no title attribute on `img` elements that assistive technology should ignore)
in service of Success Criterion 1.1.1: Non-text Content (Level A). It has no
content or access-control role — it is purely an accessibility helper — and it
supports Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
"configure" it entirely by adding the `js-decor` class in your templates, as
described in "How to use it" below.

## Where it lives in the admin menu

Decor adds no admin page and no menu item. Once enabled it works from your theme's
Twig templates.

## How to use it

Add the `js-decor` class to any container element that wraps decorative images.
For example, in a Twig template:

```twig
<div class="hero js-decor">
  <img src="/themes/custom/mytheme/images/swirl.svg" />
  <img src="/themes/custom/mytheme/images/dots.svg" />
</div>
```

Every image inside that `js-decor` container is treated as decorative: Decor sets
`alt=""`, adds `role="presentation"`, and strips any `title` attribute, so screen
readers pass over them. Use it only for images that carry no information — logos,
flourishes, background textures, spacers. Images that convey meaning should keep a
real, descriptive `alt` value and must **not** be placed inside a `js-decor`
container.
