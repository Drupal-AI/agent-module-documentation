# Blazy — manual setup guide

**Blazy** (`blazy`) provides media **lazy loading** for Drupal. It defers
off‑screen images, iframes, video, and oEmbed media until they are about to
scroll into view, and it multi‑serves responsive images — cutting the weight of
the initial page load and improving Core Web Vitals (LCP and CLS) on
image‑heavy pages. It is also a foundational library that dozens of other contrib
modules (Slick, Splide, GridStack, Mason, and more) build their galleries and
sliders on top of.

At its core Blazy wraps native and IntersectionObserver‑based lazy‑loading, so
browsers only fetch media once it approaches the visible area. On top of that it
ships several **field formatters** (image, media, oEmbed, SVG, text, title, entity
reference) that render fields lazily with optional aspect‑ratio boxes, blur‑up /
placeholder (LQIP) effects, CSS grids, and lightboxes. A **Blazy text filter**
lets editors lazy‑load and lightbox images they embed in body/CKEditor content,
and Views style and field plugins bring the same grid and media handling to
listings. Developers can render media lazily from code through the `blazy.manager`
and `blazy.formatter` services and customize markup via a rich set of alter hooks.

The base module works once enabled, but the interesting part is **choosing Blazy's
formatters and filter where you want lazy loading** — so there is a little setup
per field or text format. It depends on core's **Filter** and **Media** modules
and targets Drupal 9.4 and newer. The **base module has no admin settings page of
its own**; two optional submodules extend it: **Blazy UI** (`blazy_ui`) adds a
global settings form (at `admin/config/media/blazy`), and **Blazy Layout**
(`blazy_layout`) adds a dynamic‑region Layout Builder layout.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the services, formatters, filter,
hooks, and the BlazySkin plugin — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

## Where it lives in the admin menu

The **base Blazy module has no configuration page** (`configure` is null). Blazy
surfaces in the places where you display or embed media:

- **Manage display** (**Structure → Content types → [type] → Manage display**) —
  where you pick a **Blazy** formatter for an image, media, or oEmbed field.
- **Text formats** (**Configuration → Content authoring → Text formats and
  editors**, `/admin/config/content/formats`) — where you enable the **Blazy**
  filter for a format so embedded images lazy‑load.
- **Blazy UI settings** (only if you enable the `blazy_ui` submodule) — global
  defaults at **Configuration → Media → Blazy UI** (`/admin/config/media/blazy`).

## How to use it

- **Lazy‑load an image or media field** — go to the entity's **Manage display**,
  and for the field's **Format** choose one of Blazy's formatters (Blazy image,
  Blazy media, and so on). In the format settings you can turn on aspect‑ratio
  boxes to reserve space and avoid layout shift, a blur‑up/LQIP placeholder,
  grids for multi‑value fields, and a lightbox.
- **Lazy‑load images inside body content** — enable the **Blazy** filter on the
  text format your editors use (Configuration → Content authoring → Text formats
  and editors). Images pasted into CKEditor will then lazy‑load and can be
  lightboxed without custom JavaScript.
- **Build lazy‑loaded listings** — in a View, use Blazy's Views style or field
  to render media thumbnails and grids lazily.
- **Render media lazily from code** — inject the `blazy.manager` or
  `blazy.formatter` service and let it build the markup, or use the alter hooks
  (`hook_blazy_settings_alter`, `hook_blazy_alter`, and friends) to customize it.
- **Add global defaults or Layout Builder regions** — enable **Blazy UI** for a
  site‑wide settings form, or **Blazy Layout** for a dynamic‑region Layout
  Builder layout (see [Installation](installation/index.md)).
