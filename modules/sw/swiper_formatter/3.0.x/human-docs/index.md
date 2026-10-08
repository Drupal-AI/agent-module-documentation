# Swiper formatter — manual setup guide

**Swiper formatter** (`swiper_formatter`) brings the popular
[Swiper](https://swiperjs.com/) touch-slider library into Drupal in a
Drupal-native way. Rather than hard-coding slider options into a theme, you build
reusable **Swiper templates** (each a configuration entity holding one complete
set of slider options) and then apply a template through a field formatter or a
Views style to turn field values or Views rows into a slider.

The heart of the module is the Swiper template. A template stores everything
Swiper can do — direction, effect, loop, speed, slides-per-view, spacing, and
nested option groups for grid, keyboard, autoplay, navigation, pagination,
scrollbar, zoom, lazy loading, and responsive breakpoints. A `default` template
ships with the module and seeds every new template you create, so a new template
starts with the full option set already filled in. You can create as many named
templates as you like (for example "Hero", "Thumbnails", "Gallery") and reuse them
across many fields and views.

To actually render slides you choose one of eight field formatters or the Views
style. The formatters cover images (`swiper_formatter_image`), entity references
(`swiper_formatter_entity`), Paragraphs (`swiper_formatter_paragraphs`), and text
fields (`swiper_formatter_text`) — plus a `*_dialog` variant of each that opens
every slide in a modal/lightbox. The Views style renders View results as a slider.
Each formatter or style picks a template and renders through the module's shared
service, which attaches the Swiper JavaScript, applies token-based captions and
links, and themes the slides.

The Swiper library itself can be loaded from one of four sources selected per
template: a self-hosted `package` build, a `remote` CDN (unpkg), or a `local` /
`local_minified` copy under `/libraries/swiper` — useful for satisfying a
Content-Security-Policy or working offline. The module depends on **Token**,
defines one permission (`administer swiper_formatter`), and ships a
`swiper_formatter_ckeditor` submodule that is currently a placeholder for a future
CKEditor 5 button.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

Swiper templates are managed at **Configuration → Content authoring → Swiper
formatter** (`/admin/config/content/swiper-formatter`). Managing templates
requires the **Administer Swiper formatter** permission. The formatters and Views
style are chosen in the usual places — a field's **Manage display** page and a
View's **Format** settings.

## How to use it

1. **Create a template.** Go to **Configuration → Content authoring → Swiper
   formatter** and add a template. Give it a label and adjust the slider options
   (direction, loop, autoplay, pagination, navigation, breakpoints, library
   source, and so on). The options map one-to-one to Swiper's JavaScript API, so
   the [Swiper API docs](https://swiperjs.com/swiper-api) describe each one. You
   can also duplicate an existing template as a starting point.

   > **Don't delete the `default` template** — creating any new template loads it
   > to seed the full option set.

2. **Apply a formatter or the Views style.**
   - *On a field:* go to the entity's **Manage display**, and for a supported
     field set the format to the matching Swiper formatter — for example **Swiper
     images** for a multi-value image field, **Swiper entity** for an entity
     reference field, **Swiper paragraphs** for a Paragraphs field, or **Swiper
     text** for text deltas. Pick a `*_dialog` variant if you want each slide to
     open in a modal. In the formatter settings, choose the Swiper template to
     use.
   - *In a View:* set the View's **Format** to **Swiper formatter** and choose a
     template.

3. **Mark responsive breakpoints (optional).** A template can be flagged as a
   "breakpoint" template so it is only used *inside* another template's responsive
   breakpoints — for example showing one slide on mobile and three on desktop.

Developers can adjust a specific slider instance's options in code with
`hook_swiper_formatter_settings_alter()` — see the [`agent/`](../agent/start.md)
docs for the hook and the service API.

## A note on permissions

The module defines one grantable permission, **Administer Swiper formatter**
(`administer swiper_formatter`), which controls creating, editing, deleting, and
duplicating templates. Front-end modal (dialog) viewing only needs core's **Access
content** permission. (You may see the formatter code reference a different string,
`administer swiper` — that permission is not defined by this module, so treat
`administer swiper_formatter` as the real one to grant.)
