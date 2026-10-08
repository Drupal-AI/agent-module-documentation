Field Slideshow adds a "Slideshow" field formatter for core Image fields that renders the field's images as a jQuery Cycle2 slideshow, with configurable transitions, timing, an optional pager (thumbnails or counter), prev/next controls, and optional Colorbox lightbox links.

---

The module's core is the `slideshow` field formatter (`src/Plugin/Field/FieldFormatter/FieldSlideshow.php`),
which extends core's `ImageFormatter` and applies to `image` field types. You select it on an entity's
**Manage display** tab; there is no global settings page (`configure` is null) and no permissions. Its
settings form exposes a large **Slideshow settings** group mapped to Cycle2 options (`fx`, `speed`,
`timeout`, `delay`, `loop`, `random`, `reverse`, `pauseOnHover`, `paused`, `allowWrap`, `hideNonActive`,
`loader`, `startingSlide`, `sync`, `swipe`, `autoHeight`) plus a **Pager** group (before/after placement,
pager type, prev/next controls). Settings are emitted to `drupalSettings.field_slideshow[<id>]` and the
`field_slideshow/field_slideshow.cycle2` asset library (which loads `/libraries/jquery.cycle2/…` — a
library you must install yourself) instantiates the slideshow; enabling **swipe** additionally attaches
`cycle2swipe`. The pager is a small plugin type: the module defines a `field_slideshow_pager` plugin
manager with two implementations, **Thumbnails** and **Counter**, and you can add your own. When the
optional Colorbox module is present, an extra image-link option turns each slide into a Colorbox gallery
link with a chosen image style. Output is rendered through the `field_slideshow` theme hook
(`templates/field-slideshow.html.twig`). Note the shipped `config/schema` is slightly out of sync with
the formatter (e.g. it lists `deley`/omits `autoHeight`), but the formatter's `defaultSettings()` is the
source of truth.

---

- Turn a multi-value Image field into an auto-playing slideshow on the display.
- Build a homepage hero/banner rotator from an image field.
- Create a product image gallery that cycles through photos.
- Choose the transition effect (fade, fadeout, scrollHorz, none) per display.
- Control slide timing with `timeout` (time between slides) and `speed` (transition duration).
- Add a start `delay` before the first transition.
- Loop the slideshow a fixed number of times, or continuously (`loop` < 1).
- Randomize slide order with the `random` option.
- Play the slideshow in reverse order.
- Pause auto-play while the visitor hovers the slideshow (`pauseOnHover`).
- Start the slideshow paused and let controls drive it (`paused`).
- Show a thumbnails pager (using the core `thumbnail` image style) under/above the slideshow.
- Show a numeric counter pager instead of thumbnails.
- Place the pager before, after, or both relative to the slideshow.
- Add Prev/Next navigation controls.
- Set which slide is shown first (`startingSlide`).
- Enable touch swipe navigation on mobile (`swipe`, requires the cycle2 swipe plugin).
- Link each slide to a Colorbox lightbox gallery with a chosen image style (when Colorbox is installed).
- Reuse core image styles for the slides via the inherited ImageFormatter settings.
- Provide a lightweight carousel without pulling in a heavy slider framework.
- Add a custom pager type (e.g. dots) by implementing a `field_slideshow_pager` plugin.
- Sync or stagger incoming/outgoing slide animations with the `sync` option.
- Hide inactive slides (`hideNonActive`) for a clean stacked layout.
- Display a per-field slideshow in Views by using the field formatter on the image field.
