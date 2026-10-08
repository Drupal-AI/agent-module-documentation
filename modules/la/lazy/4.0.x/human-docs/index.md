# Lazy-load — manual setup guide

**Lazy-load** (`lazy`) defers loading images and iframes until they're about to scroll
into view, so pages render faster and use less bandwidth up front. It can do this two
ways: with the browser's built-in `loading="lazy"` attribute (zero JavaScript), or
with the **lazysizes** JavaScript library for finer control and broader behaviour.
Deferring below-the-fold media is one of the easier wins for Core Web Vitals (LCP in
particular).

There are three ways to switch lazy-loading on, and you can use any combination:

- a **text-format filter** that rewrites inline `<img>` and `<iframe>` tags in
  formatted text (e.g. images pasted into a Body field);
- two **image field formatters** — *Image (Lazy-load)* and *Responsive image
  (Lazy-load)* — plus a lazy-loading checkbox added to the standard image formatters;
  and
- a `data-lazy` render attribute for developers to lazy-load any image render element.

A single settings form ties the behaviour together. Its most important switch is
**Prefer native**: turn it on and the module just adds `loading="lazy"` with no
JavaScript; leave it off and it uses lazysizes for every browser. A **skip class**
(default `no-lazy`) lets you exempt individual elements, a visibility condition limits
which paths lazy-loading applies to, and lazy-loading is skipped automatically on admin
pages and AMP pages.

Lazy-load depends only on core's **Filter** and **System** modules. Unless you stick to
native-only mode, it needs the **lazysizes** library placed in `/libraries/lazysizes`.

This guide is written for a **human** getting the module installed and configured.
Because much of the value is in field formatters and the filter, the developer-facing
details (the `lazy` service and the alter hooks) live in the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the lazysizes
   library, and enable the module.

## How to use it

Settings live at **Configuration → Content authoring → Lazy-load**
(`/admin/config/content/lazy`), gated by core's **Administer filters** permission.
First decide native vs. library mode, then switch lazy-loading on wherever you need it.

### Native vs. library mode (the "Prefer native" switch)

- **Prefer native on** — the module adds `loading="lazy"` to elements and loads no
  JavaScript; the browser handles everything. Simplest and lightest.
- **Prefer native off** (default) — the module uses the **lazysizes** library for all
  browsers: it adds a marker class (`lazyload`) and swaps the image's `src` to a
  `data-src` attribute, which lazysizes restores as the element nears the viewport.
  This mode requires the lazysizes library to be installed.

### Turning lazy-loading on — three routes

1. **Text-format filter** (inline images/iframes in rich text). Go to
   **Configuration → Content authoring → Text formats and editors**, edit a format
   (e.g. *Full HTML*), and enable **Lazy-load images and iframes**. Its two
   checkboxes choose whether it applies to images, iframes, or both. Order it after
   filters that generate HTML.

2. **Image field formatters** (image fields in a view mode). On a content type's
   **Manage display**, either pick the **Image (Lazy-load)** or **Responsive image
   (Lazy-load)** formatter, or tick the **Enable lazy-loading** checkbox that Lazy adds
   to the standard *Image*, *Responsive image*, *Colorbox*, and *Media thumbnail*
   formatters.

3. **Render attribute** (custom code/templates). Add
   `'#item_attributes' => ['data-lazy' => TRUE]` to an image render element and the
   module converts it — see the [`agent/`](../agent/start.md) docs.

### Useful settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Prefer native** | Off | Use native `loading="lazy"` instead of lazysizes when possible. |
| **Skip class** | `no-lazy` | Any element (or its parent) carrying this class is *not* lazy-loaded — handy for exempting a specific image. |
| **Placeholder src** | *(empty)* | A lightweight placeholder shown while the real image loads (library mode). |
| **CSS effect** | Off | Apply a fade-in transition as images load. |
| **Library path** | `/libraries/lazysizes` | Where the lazysizes library lives; can be a local path or an external CDN URL. |
| **Disable on admin pages** | On | Keep lazy-loading off administrative pages. |
| **Visibility** | Everywhere except `/rss.xml` | Which paths lazy-loading applies to (a standard path condition you can invert to "only these pages"). |

AMP pages (a `?amp` query string) are always excluded. The lazysizes library exposes a
lot of extra tuning — marker class names, the source attributes it reads, viewport
expand distance, and around 22 optional plugins (bgset, blur-up, respimg, parent-fit,
and more) — all reachable from the same settings form.

Settings are stored as configuration, so they export and deploy with
`drush config:export` / `drush config:import`.
