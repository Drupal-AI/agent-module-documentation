# Swiffy Slider — manual setup guide

**Swiffy Slider** (`swiffy_slider`) is a Drupal integration of the
[Swiffy Slider](https://swiffyslider.com/) library — a lightweight slider and
carousel that is a different generation from the old jQuery‑plugin carousels. The
sliding, dragging, and snapping are handled by **native browser CSS scroll‑snap**
rather than a JavaScript animation loop, which makes it fast, tiny, and friendly
to touch pads, pencils, and assistive devices. It can even run in a simple mode
with no JavaScript at all.

The module gives you two ways to build a carousel: a **field formatter** for
entity‑reference and media fields, and a **Views display format**. In both cases
you point the display at Swiffy Slider and paste a single **configuration URL**
that you generate on the swiffyslider.com configuration page — a deliberate design
choice that keeps the Drupal forms simple while still giving you the library's
full range of options. Importantly, the configuration URL is only used to carry
your chosen settings; there are **no third‑party calls** at runtime, and all
customised configuration is handled locally.

The module **ships the required library already**, so it works on enable — though
you can override the bundled version with a Composer library package if you want a
newer release. It has no Drupal module dependencies and no submodules, and
supports Drupal 10 and 11.

A couple of things worth knowing. Because a scroll‑snap slider is really a
scrolling container, keyboard scrolling and screen‑reader traversal work by
default — a better accessibility starting point than a JS‑driven slider — but you
should still check that controls have visible focus and add a pause control if
anything auto‑advances. And the general carousel caveat applies regardless of how
good the implementation is: content past the first slide is rarely seen, so a
carousel suits equally‑optional items (logos, testimonials, gallery images) and is
the wrong place for your primary call to action. There is also a known issue: the
loop‑to‑first behaviour does not work while snap behaviour is active.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (the library ships with it), or override the library version.
2. [Configuration](configuration/index.md) — set up the field formatter or the
   Views format and paste your configuration URL.

## How to use it

There is no global settings page. You use Swiffy Slider by choosing it as the
format on a multi‑value field's display, or as a Views display format, and pasting
a configuration URL. See [Configuration](configuration/index.md).
