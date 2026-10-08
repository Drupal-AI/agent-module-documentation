Adds Bootstrap-based slider plugins to BS Slider: a Bootstrap Carousel and a thumbnail Gallery Grid.

---

`bs_slider_bootstrap` is a library submodule of BS Slider. It registers two `BsSlider` plugins —
`bootstrap_carousel` (a full-featured Bootstrap carousel) and `bootstrap_gallery_grid` (a
responsive thumbnail grid/column that opens a Bootstrap Carousel full view). It depends on
`bs_lib` (which provides the Bootstrap carousel JS/CSS via the `bs_lib/carousel` library) and on
the `bs_slider` parent. It ships ready-made optionsets and its own CSS/JS for the gallery layout,
overlay and body-scroll-lock behavior. Once enabled, pick "Bootstrap Carousel" or "Bootstrap
Gallery Grid" when creating a BS Slider optionset, then reference that optionset from a formatter,
Views style or Paragraph behavior.

---

- Build a Bootstrap carousel from a multi-value media/image field.
- Show previous/next controls and slide indicators on a carousel.
- Cross-fade slides instead of the default horizontal slide.
- Autoplay a carousel at a configurable interval with pause-on-hover.
- Enable keyboard navigation for a carousel.
- Wrap the carousel so it loops back to the first slide after the last.
- Build a responsive thumbnail gallery (grid or column layout).
- Choose the number of thumbnail columns per breakpoint (e.g. 2-3-4).
- Set the gutter size between thumbnails (none/small/medium/large).
- Open a full-screen-style Bootstrap Carousel overlay when a thumbnail is clicked (body scroll locked while open).
- Reuse an existing `bootstrap_carousel` optionset as the gallery's full view.
- Start from the shipped default optionsets (default Bootstrap carousel / gallery grid / gallery column / gallery carousel).
- Render slider items and gallery items in different view modes.
- Provide accessible prev/next controls with screen-reader labels.
- Theme the carousel per optionset via `bs_slider__bootstrap_carousel__{config}.html.twig`.
