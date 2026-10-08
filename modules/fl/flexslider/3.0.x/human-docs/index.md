# FlexSlider — manual setup guide

**FlexSlider** (`flexslider`) integrates the **FlexSlider 2** jQuery
slider/carousel library with Drupal. It turns a multi‑value image field, or a set
of Views results, into a responsive, touch‑enabled slideshow or carousel — all
driven by reusable **optionset** configuration.

The central idea is the **optionset**. An optionset is a configuration entity
(`flexslider.optionset.{id}`) that captures every FlexSlider library setting in
one place: the animation type (slide or fade) and speed, the sliding direction,
slideshow auto‑advance behavior, navigation controls (arrows, paging dots, or
thumbnails), carousel item width and margin, keyboard/touch/mousewheel options,
and an advanced CSS namespace. A `default` optionset ships with the module, and
you can create as many more as you like — a fading hero banner, a
thumbnail‑navigation gallery, a multi‑item carousel — and reuse each one across
the site. Because optionsets are config entities, they export and deploy between
environments with `drush config:export`.

Two things then render content through a chosen optionset. The **FlexSlider image
field formatter** (from the *FlexSlider Fields* submodule) applies to
**multi‑value image fields** — set the field's display format to FlexSlider, pick
an optionset, an image style, and caption settings. The **FlexSlider Views
style** (from the *FlexSlider Views Style* submodule) lets you display Views
results as a slider, choosing an optionset, an optional caption field, and a
container element ID. Developers can also attach a slider to any render array in
code with `flexslider_add($id, $optionset)`. All slider administration is gated
by the single **Administer flexslider** permission.

One important note: the FlexSlider 2 JavaScript library is an **external
dependency** that you must download and place in your site's `libraries/`
directory — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   install the FlexSlider 2 JavaScript library, and enable the display
   submodules.

There is no separate configuration page in this guide — creating optionsets and
applying the formatter/Views style is covered in "How to use it" below.

## Where it lives in the admin menu

Optionsets are managed at **Configuration → Media → FlexSlider**
(`/admin/config/media/flexslider`). A module‑wide **advanced settings** form sits
at `/admin/config/media/flexslider/advanced`. Both are gated by the **Administer
flexslider** permission.

## How to use it

### 1. Create or edit an optionset

Go to **Configuration → Media → FlexSlider**. You'll see the `default` optionset
and can **Add** more. Each optionset's form exposes the library settings,
including:

- **Animation** — `fade` or `slide`; **Animation speed** in milliseconds.
- **Direction** — horizontal or vertical sliding.
- **Slideshow** — whether slides auto‑advance, and the **slideshow speed** (delay
  between slides); plus loop and randomize options.
- **Item width / item margin** — set both to non‑zero to turn the slider into a
  **carousel** that shows several items at once.
- **Navigation** — previous/next arrows (`directionNav`), paging dots
  (`controlNav`, or `thumbnails` for thumbnail navigation), keyboard, touch, and
  mousewheel controls, and pause/play behavior.
- **Namespace** — an advanced CSS class prefix for per‑optionset styling.

### 2. Apply it to an image field

Enable the **FlexSlider Fields** submodule. On the entity's **Manage display**,
set a **multi‑value image field's** format to **FlexSlider**, then pick your
optionset, an image style, and caption settings. (A **Responsive FlexSlider**
formatter is also available when core's Responsive Image module is enabled.)

### 3. Or apply it to a View

Enable the **FlexSlider Views Style** submodule. In a view, set **Format →
FlexSlider**, then choose an **option set**, an optional **caption field**, and a
unique **element ID**. Include an image field in the display — but don't set that
field's own formatter to FlexSlider (that would nest sliders).
