Adds a Views style plugin that renders view rows as a BS Slider.

---

`bs_slider_views` is an integration submodule of BS Slider. It provides the `bs_slider_views` Views
style plugin ("BS Slider"), letting any View display its rows through a chosen BS Slider optionset —
so the same view can be output as a Bootstrap carousel, Swiper, Tiny Slider or gallery. In the
View's Format settings you select an existing optionset; at render time the style's preprocessor
loads that optionset's plugin and calls its `view()` on the rows. Depends on `bs_slider` and core
`views`, plus at least one library submodule to supply a slider plugin.

---

- Turn any View (nodes, media, taxonomy, custom) into a slider/carousel.
- Render a "latest content" View as a rotating carousel on the homepage.
- Build an image/media gallery from a media View using a gallery optionset.
- Reuse a single BS Slider optionset across multiple Views.
- Combine Views filters/sorts/contextual filters with slider output.
- Use Views fields or rendered-entity rows as slide content.
- Switch a View's slider library by changing which optionset it references.
- Provide a block View that outputs a Swiper carousel.
- Keep Views pager/row plugins while displaying rows in a slider.
- Theme the slider via `views-view-bs-slider.html.twig` and BS Slider template suggestions.
