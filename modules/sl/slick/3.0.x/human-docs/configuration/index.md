# Configuration

Configuring Slick happens in three places: you build a reusable **optionset**
(the carousel's behavior), you apply a **field formatter** to display a field as
that carousel, and — occasionally — you adjust the **sitewide settings**. The
first two are what you'll do for every carousel; the third you'll rarely touch.

The optionset and sitewide screens described here come from the **Slick UI**
submodule, so make sure it is enabled (see
[Installation](../installation/index.md)).

## Build an optionset

An **optionset** is a named, reusable bundle of Slick options that you configure
once and apply to many displays. Manage them at **Configuration → Media → Slick**
(`/admin/config/media/slick`) — you'll need the **Administer Slick** permission.
From here you can add, edit, duplicate, or delete optionsets. The module ships a
`default` optionset to get you started, and duplicating an existing set is often
the fastest way to make a new one.

Each optionset bundles Slick's own options together with a skin and responsive
breakpoints. The main settings you'll set include:

- **Slides to show** — how many slides are visible at once (for example 4 across
  on desktop).
- **Autoplay** — whether the carousel advances on its own.
- **Arrows** — show previous/next navigation arrows.
- **Dots** — show the pager dots beneath the carousel.
- **Center mode** — highlight the focused slide in the middle of the stage.
- **Vertical** — stack slides vertically (handy for a sidebar ticker).
- **asNavFor** — link a main carousel to a thumbnail carousel for gallery‑style
  navigation.
- **Skin** — pick a prebuilt CSS style (such as classic, fullscreen, split, or
  grid) without writing any CSS.
- **Responsive breakpoints** — define how the carousel behaves at different screen
  widths, so it might show 4 slides on desktop and 1 on mobile.

There is also an **Optimized** toggle: turn it on to strip default values from the
stored configuration, which keeps exported config files smaller.

Because optionsets are configuration entities, they export cleanly with your
site's configuration and deploy between environments like any other config.

## Apply a carousel to a field

An optionset only defines behavior — to actually show a carousel you apply a Slick
**field formatter** on a field's **Manage display** tab. Go to the entity's
*Manage display* screen (for example a content type's), find the field you want to
turn into a carousel, and choose the matching formatter:

- **`slick_image`** — for image fields.
- **`slick_media`** — for Media reference fields.
- **`slick_file`** — for file or entity‑reference bases.
- **`slick_text`** — for text or entity fields.

Each formatter lets you pick which **optionset** to use, and many also let you
choose a separate **thumbnail optionset** to drive an asNavFor thumbnail
navigation. Save the display and the field renders as your configured carousel.

For carousels inside body text, enable the **`slick_filter`** text‑format filter on
a text format (under *Configuration → Content authoring → Text formats and
editors*) to embed inline carousels.

## Sitewide settings

The global settings live at `/admin/config/media/slick/ui`. Most sites never need
them, but two things are set here:

- **Sitewide initializer** — when set above 0, Slick auto‑attaches its initializer
  across the site so hand‑written carousel markup on non‑admin pages is picked up
  automatically. Left at 0, it stays off and carousels are attached only where a
  formatter or filter renders them.
- **Active JS library** — choose whether the module uses the original **Slick**
  library or the **Accessible Slick** fork for keyboard‑navigable, accessible
  sliders.

## Save

Save each optionset from its edit form, and save the **Manage display** screen
after choosing a formatter. Changes take effect on the next page load — reload a
page that renders the field to see the carousel behave with your new settings.
