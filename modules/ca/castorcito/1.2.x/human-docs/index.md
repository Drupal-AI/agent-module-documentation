# Castorcito — manual setup guide

**Castorcito** (`castorcito`) is a component-based content-assembly system. It
lets you build and reuse visual components through the admin UI — accordions,
banners, cards, carousels, galleries, quotes, slideshows, tabs, and more — and
assemble them into page content without writing code. Under the hood, components
are `castorcito_component` configuration entities rendered with Drupal's
**Single Directory Components (SDC)**, and content is stored in a JSON field, so
Castorcito works with any content entity type: nodes, users, taxonomy terms, and
so on.

The goal is faster site building: instead of hand-coding layout for every page,
editors assemble tested, prebuilt components and tweak them to match branding and
functionality. It ships with several optional submodules — a **base pack** of
ready-to-use components, an **advanced pack** (currently a timeline component),
**webform** integration (embed a webform inside a component via a special
"c-field"), and **sync** for exporting and importing components between sites.
Three contributed themes (Mockup, Lodge, Alice) are built to style the base and
advanced pack components.

This is a content-editing / site-building tool. The components you build are
authored content rendered through Drupal's normal render and access layers — the
module has no access-control role of its own, though it does provide its own
permissions to govern who may manage components. Note that this release
(**1.2.1-beta5**) is a beta, and the project is **not covered by Drupal's
security advisory policy** — worth weighing before using it on a high-stakes
production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

The maintainers recommend the [project website](https://www.drupal.org/project/castorcito)
as the best place to learn the components in depth, with detailed descriptions
and examples.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose which component-pack submodules you need.
2. [Configuration](configuration/index.md) — where components are managed and how
   you assemble them into content.

## Where it lives in the admin menu

Castorcito's components are managed from the **Castorcito component collection**
(the `entity.castorcito_component.collection` route) — the listing of all
components you have defined, where you create, edit, and organize them.
