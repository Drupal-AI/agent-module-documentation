# Slick Paragraphs — manual setup guide

**Slick Paragraphs** (`slick_paragraphs`) adds field formatters that render a
multi‑value **Paragraphs** field as a **Slick carousel/slideshow** — each
paragraph item becomes a slide. It's the glue between the
[Slick](https://www.drupal.org/project/slick) and
[Paragraphs](https://www.drupal.org/project/paragraphs) modules, and it has **no
configuration UI of its own**: everything is set up on a field's *Manage display*.

It provides two formatters, both for Paragraphs (`entity_reference_revisions`)
fields:

- **Slick Paragraphs Vanilla** (`slick_paragraphs_vanilla`) renders each
  referenced paragraph "as is" through its configured view mode, so every slide
  can have a different mix of fields. Combine it with Field Group, Display Suite,
  or Bootstrap Layouts for per‑slide layouts. It works on both top‑level and child
  Paragraphs fields and requires the **Blazy** library/module (installed with
  Slick).
- **Slick Paragraphs Media** (`slick_paragraphs_media`) produces richer, advanced
  slides — a main image or background "stage" plus overlays such as media, image,
  or nested references. It's meant for a **second‑level (child) Paragraphs field**
  only, which keeps nested‑paragraph setups sane.

Both formatters let you pick a Slick **optionset** (skin, arrows, dots, autoplay,
responsive breakpoints) and map which paragraph fields supply the slide stage and
overlay content. Optionsets aren't created here — they live in the Slick module at
**Configuration → Media → Slick**.

One limitation worth knowing up front: these formatters only work in **Field UI →
Manage display**, not in the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Slick/Paragraphs dependencies.

There is **no configuration page** for this module — it has no settings form. The
setup happens on your Paragraphs field's display, described in "How to use it"
below.

## Where it lives in the admin menu

Slick Paragraphs adds no admin page. You use it entirely from **Structure →
Content types (or Paragraph types) → *(bundle)* → Manage display**. Slick
optionsets are managed separately at **Configuration → Media → Slick**
(`/admin/config/media/slick`).

## How to use it

The typical structure is a "Slideshow" paragraph that holds a multi‑value "Slides"
field, where each slide is its own paragraph:

```
Node (or any fieldable entity)
 └─ Paragraphs field → Slideshow bundle
     └─ "Slides" child Paragraphs field  ← format this with Slick Paragraphs
         └─ Slide bundle (image, title, caption, link, layout…)
```

1. Create a **Slide** paragraph bundle with the fields each slide needs
   (image/media, title, caption, link, and optionally a caption‑placement list).
2. Create a **Slideshow** paragraph bundle with a multi‑value (Unlimited)
   Paragraph field named **Slides** that references only the Slide bundle.
3. On the Slideshow bundle's **Manage display**, set the **Slides** field's format
   to **Slick Paragraphs Vanilla** or **Slick Paragraphs Media**. Configure its
   options — choose a Slick **optionset**, and (for the Media formatter) map which
   paragraph field is the slide stage and which is the overlay.
4. Add a Paragraphs field on your host entity (a node, for example) that allows
   the **Slideshow** bundle, and start adding slides.

> **Tip:** If you don't yet have a Slick optionset, create one first at
> **Configuration → Media → Slick** — that's where the skin, arrows, dots,
> autoplay, and responsive settings live.
