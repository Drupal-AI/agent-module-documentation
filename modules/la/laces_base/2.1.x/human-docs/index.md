# Laces Base — manual setup guide

**Laces Base** (`laces_base`) is a site‑building starter kit for the **Layout
Builder** ecosystem and the companion **Laces** theme. Rather than adding a feature
you switch on, it installs a ready‑made foundation of configuration so you can
start laying out pages with Bootstrap 5 grids straight away instead of hand‑building
all of that config yourself.

What it brings to the site:

- Four **Layout Builder layouts** — one, two, three, and four column — each
  rendering a proper Bootstrap 5 `container` / `row` / `col` structure, with a
  selectable container breakpoint per section (`container`, `container-sm` through
  `container-xxl`, `container-fluid`, and an edge‑to‑edge `container-edge`).
- An **"Article with Layout"** content type (`laces_article_layout`) with Layout
  Builder enabled and a Laces image field.
- A large library of **image styles**, **media view modes**, and **responsive
  image styles** wired up for the core Media Library, plus Bootstrap breakpoints.
- On install, it seeds **Bootstrap Styles** settings tuned for Bootstrap 5 and the
  Laces theme, and it hides the duplicate core Layout Builder layouts so only the
  Laces layouts appear in the layout picker.

It defines no routes, controllers, permissions, or outbound requests — it's purely
site‑building scaffolding meant for administrators. To get the full benefit you
should also install the **Laces theme** and the companion contrib modules the
layouts and styles build on (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer, and pair it with the Laces theme.

There is **no settings form** for this module — it works by installing
configuration. You use it from Drupal's normal site‑building screens, described in
"How to use it" below.

## How to use it

1. Make sure the **Laces theme** is installed and set as your default (or admin)
   theme — several features depend on it to render correctly.
2. Create or edit an **Article with Layout** node and open its **Layout** tab.
3. Add sections using the Laces **one/two/three/four column** layouts. For each
   section, pick the **container breakpoint** that suits the design — from a
   standard centred container up to `container-fluid`, or `container-edge` for a
   flush, edge‑to‑edge band.
4. Place blocks and fields into the columns, and use the bundled image and
   responsive‑image styles for media so images scale correctly across breakpoints.
