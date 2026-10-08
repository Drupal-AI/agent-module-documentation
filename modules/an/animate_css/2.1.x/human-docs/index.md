# Animate CSS — manual setup guide

**Animate CSS** (`animate_css`) brings the popular third-party
[animate.css](https://animate.style/) library into Drupal. Once enabled it
attaches the animate.css stylesheet to every page, so the whole catalogue of
ready-made, cross-browser CSS animations — bounces, fades, zooms, shakes,
attention-seekers — becomes available anywhere on your site just by adding a
couple of class names to your markup.

The module is deliberately tiny: it is a thin "asset library" wrapper. It has no
settings form, no permissions, and nothing to configure. It simply makes sure the
animation classes are loaded site-wide so your themes, blocks, fields, JavaScript,
and even CKEditor content can use them. It never adds animation classes for you —
*you* decide which elements animate and which effect they get.

One thing to be aware of: the actual animate.css stylesheet is a separate library
file that ships with the module's Composer package (`drupal-shimmy/animate.css`).
Install the module the recommended way (with Composer) and that file lands in the
right place automatically. If it is ever missing, Drupal's status report warns you
with an error, so you always know whether the library is present.

This guide is written for a **human** setting the module up through the admin UI
and editing templates. If you want terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its animate.css
   library with Composer, then enable it.

## Where it lives in the admin menu

Animate CSS has **no admin page of its own** — no settings form and no configure
link. The only place it shows up in the admin is the **status report**
(*Reports → Status report*, `/admin/reports/status`), where it confirms whether
the animate.css library file is installed. Everything else happens in your markup.

## How to use it

Once the module is enabled, add the base class `animate__animated` plus an effect
class to any element:

```html
<h1 class="animate__animated animate__fadeInUp">Hello</h1>
```

- **Base class** (always required): `animate__animated`.
- **Effect class** (pick one): for example `animate__bounce`, `animate__fadeIn`,
  `animate__fadeInUp`, `animate__zoomIn`, `animate__flipInX`, `animate__shakeX`,
  `animate__pulse`, or `animate__tada`.
- **Utility classes** (optional): tune timing with `animate__delay-1s` …
  `animate__delay-5s`, speed with `animate__slow` / `animate__slower` /
  `animate__fast` / `animate__faster`, or loop forever with `animate__infinite`.

You can add these classes wherever you like — in a Twig template, on a block's CSS
classes, inside CKEditor content, or from JavaScript:

```js
element.classList.add('animate__animated', 'animate__bounce');
```

A few practical ideas: give a hero heading an entrance animation, bounce a
call-to-action button on load, emphasise a form validation error with
`animate__headShake`, or animate cards in a Views listing.

> **Version note:** this is animate.css **v4**, which uses the double-underscore
> `animate__` prefix. The older unprefixed names (like `animated bounce` from v3
> and earlier) will **not** work with the library this module ships.
