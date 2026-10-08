# Configuration

Slick Layouts is used in two places: a small **slider settings** form, and the
**Layout Builder** interface where you actually build the carousel.

## Building a carousel in Layout Builder

This is the core workflow:

1. Open Layout Builder for the entity or view mode you want to edit (for example
   a content type's **Manage display** → **Manage layout**, or an individual
   node's layout).
2. Choose to **add a section** and pick the **Slider Section** layout provided by
   this module.
3. **Place blocks** into that section. Each block you add becomes one **slide**
   in the carousel. Add as many as you want slides.
4. Save the layout. On the rendered page the section displays as a rotating
   Slick carousel, sliding through the blocks you placed.

Because the slides are ordinary blocks, they can contain anything a block can —
text, images, fields, custom block content — and each keeps its own access
rules.

## Slider settings

The module also provides a slider settings form (route
`slider_layouts.slider_settings`) where you adjust how the carousel behaves —
the Slick options that control the rotating slider. Open that form to tune the
slider to your needs, then save; the settings apply to the slider sections you
build.

## Save

Remember to **save** both the Layout Builder layout and the slider settings form
after making changes — the carousel reflects your changes once the layout is
saved and the page is reloaded.
