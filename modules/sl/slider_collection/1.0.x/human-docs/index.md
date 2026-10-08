# Slider collection — manual setup guide

**Slider collection** (`slider_collection`) is a *base* module for building
sliders and carousels in Drupal. Rather than tying you to one JavaScript slider
library, it provides the shared structure — including a **Views style** — and lets
each actual slider library arrive as a submodule you enable on demand. You choose
the library you want, enable its submodule, and build the slider as a Views
display.

That design is the point. Most slider modules are welded to a single library; here
the library is swappable. Two are included out of the box:

- **Swiper** (`sc_swiper`) — the current standard, full-featured slider library.
- **Tiny Slider** (`sc_tinyslider`) — a small, vanilla-JavaScript option for a
  lighter footprint.

If neither suits, you can add support for another library by writing a submodule
against the module's base classes and events, rather than adopting a whole
separate slider module with its own configuration model.

Because the slider is a **Views style**, everything about *which* items appear —
selecting, filtering, sorting, and paging the slides — is handled with ordinary
Views settings. You can even switch the underlying library later without
rebuilding the view. The base module depends only on core **Views** and runs on
Drupal 10 and 11.

> **Important:** enabling the base module on its own does nothing visible. You must
> also enable at least one library submodule (Swiper or Tiny Slider) for a slider
> to work.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable a library submodule, and make the slider library available.

## How to use it

Once the base module and a library submodule are enabled and the library asset is
in place:

1. Create a **View** (**Structure → Views → Add view**) that lists the content you
   want to show as slides.
2. For the display's **Format**, choose the slider style provided by the submodule
   you enabled (Swiper or Tiny Slider).
3. Use the normal Views fields, filters, sorts, and pager to control which items
   appear and in what order.

The result is a slider built entirely from a Views display — a testimonial
carousel, a "recent articles" slider, a partner-logo strip, and so on — with all
the flexibility of Views behind it.
