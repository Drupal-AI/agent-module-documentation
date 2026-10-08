# Theming Slick Paragraphs slides

Slick Paragraphs itself ships **no templates or theme hooks** — it only defines two field
formatters that hand off to the Slick module's rendering. Slide markup therefore comes from
(a) the Slick module's carousel templates and (b) the paragraph's own view mode / fields.

## Where the markup comes from

- The **carousel wrapper** (slide track, arrows, dots, skins) is rendered by the **Slick**
  module and controlled by the chosen **optionset** and **skin**. Theme those via Slick's
  templates and skin CSS.
- Each **slide's content** is the referenced paragraph:
  - **Vanilla** (`slick_paragraphs_vanilla`) renders the paragraph through its **view mode**
    (Default suffices unless you need more control). Style it with the paragraph's own
    field templates, and arrange fields with **Field Group**, **Display Suite**, or
    **Bootstrap Layouts**. Blazy is required.
  - **Media** (`slick_paragraphs_media`) composes a slide from a main image/stage field plus
    overlay fields, using Slick's media/overlay markup.

## Per-slide caption layout

Because a paragraph is a fieldable entity, you can add a **List (text)** field to the Slide
bundle to choose a layout per slide. Supported predefined keys (README):

- Basic: `top`, `right`, `bottom`, `left`, `center`, `center-top`, `below`.
- Overlay/stage: `stage-right` (caption left, stage right), `stage-left` (caption right, stage left).
- Split skin only: `split-right`, `split-left` (image and caption side by side).

Notes:
- Layout options depend on a **skin** being selected; with no skin it is DIY CSS.
- All layouts except **`below`** ("Caption below the slide") are absolutely positioned
  (overlaid on the slide image) and are intended for large displays, not small carousels.
- For **Split**, keep left/right options consistent per slide and pick an optionset whose
  skin is **Split** so the slideshow has a matching context.

## `hook_help`

`slick_paragraphs_help()` renders this module's `README.md` (via `blazy()->markdown()`) on
the module help page (`help.page.slick_paragraphs`). No other theme integration.
