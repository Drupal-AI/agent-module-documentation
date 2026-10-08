# Twig Real Content — manual setup guide

**Twig Real Content** (`twig_real_content`) is a small theming helper that adds a
`real_content` Twig **filter** and Twig **test** to tell you whether a rendered variable —
typically a page region — actually contains meaningful content, or is just empty wrapper
markup and whitespace. It solves a classic themer's headache: core's
`{% if page.sidebar %}` is often *true* even when a region renders nothing but empty
`<div>`s, so you end up with a blank wrapper (an `<aside>`, a grid column, a card) around
nothing.

The module registers a single Twig extension exposing the same logic two ways. The
**test** — `... is real_content` — returns true only if something meaningful is left after
the markup is stripped down. The **filter** — `...|real_content` — returns that stripped,
trimmed string (or an empty string). "Meaningful" means: run the value through
`strip_tags()`, keeping an allowlist of self‑meaningful tags (`img`, `iframe`, `video`,
`svg`, `object`, `embed`, `input`, `hr`, and a few others, including
`drupal-render-placeholder`), then trim whitespace. So a region containing only an image or
an embedded video still counts as real content, while one containing only empty wrappers and
spaces does not.

There's one important rule: both callables expect an **already‑rendered** value — a string
or a `MarkupInterface` object. If you pass a raw render array (as `page.sidebar` is inside
`page.html.twig`), you must `|render` it first, or the module throws an exception. The
module has no configuration, routes, permissions, or services beyond that one Twig
extension — its entire surface is those two Twig callables.

This guide is written for a **human** editing Twig templates. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There's nothing to configure — once the module is enabled, use the test and filter in your
theme's Twig templates.

### Only render a wrapper when a region has real content

Render the region first, then test it:

```twig
{% if page.sidebar_first|render is real_content %}
  <aside class="sidebar">{{ page.sidebar_first }}</aside>
{% endif %}
```

This is the fix for "empty" sidebars, footers, and highlighted regions that core's
`{% if page.region %}` wrongly treats as non‑empty.

### Toggle a CSS class based on real content

```twig
<body class="{{ page.sidebar_first|render is real_content ? 'has-sidebar' : 'no-sidebar' }}">
```

### Output only the meaningful remainder

```twig
{{ my_markup|real_content }}
```

### Test any captured block of markup, not just regions

```twig
{% set teaser %}{{ content.field_summary }}{% endset %}
{% if teaser is real_content %}<div class="teaser">{{ teaser }}</div>{% endif %}
```

### What counts as content

- `<div class="region"> \n </div>` → the div is stripped, only whitespace remains → the test
  is **false**.
- `<div><img src="hero.jpg"></div>` → `img` is on the allowlist → the test is **true**.
- `<p>Hello</p>` → the `p` is stripped but the text remains → the test is **true** and the
  filter returns `Hello`.
- A region rendered as a lazy `<drupal-render-placeholder>` counts as **true**.

Remember to `|render` (or capture with `{% set %}`) an un‑rendered render array first —
passing one directly throws `TwigRealContentException`. `NULL` is treated as empty (no
exception).
