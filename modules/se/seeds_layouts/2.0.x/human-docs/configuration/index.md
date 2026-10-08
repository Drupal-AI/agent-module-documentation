# Configuration

Seeds Layouts works as soon as it is enabled — its layouts appear in Layout
Builder with no setup required. There is nothing you *must* configure to start
using it. Most of what you will actually adjust happens per section inside Layout
Builder rather than on a single global settings screen.

## Per-section options in Layout Builder

When you add a section using one of the Seeds layouts and open its configuration
form, you get more than the bare columns:

- **Custom options as classes** — Seeds Layouts can present extra options on the
  section, rendered either as a checkbox or as a select list. Whatever the editor
  chooses is added as one or more CSS classes on the section wrapper. This is how
  the module stays framework-agnostic: the classes are yours to style, so a
  layout can carry Bootstrap, Tailwind, or bespoke theme classes depending on the
  site.
- **Section background** — you can upload a background image for the section
  directly within Layout Builder, without leaving the layout-editing flow. This
  is the feature that hooks into the Media Library's assets (see Installation).

Because these options emit CSS classes, remember that a utility framework which
purges unused classes needs to know about them — that is what the
`seeds_layouts_classes_extractor` submodule is for.

## Where the module's settings live

The module exposes its own configuration under **Configuration** (config route
`seeds_layouts.config`). This is where site-wide behaviour of the layouts is
governed; the day-to-day choices, though, are made per section as described above.

## A note before you rely on a layout

Once content is built with a layout, that content keeps referring to it. If you
later remove or rename a layout, the sections that used it can fail to render.
Decide on your set of layouts (and their machine names) before building many pages
on top of them, the same way you would treat paragraph types.
