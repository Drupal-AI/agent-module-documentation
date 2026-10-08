BS Slider is a pluggable framework for turning multi-value fields, Views rows and Paragraphs into sliders, carousels and galleries, with the actual slider library supplied by submodules.

---

BS Slider does nothing visible on its own: it defines a `bs_slider` configuration entity (an "optionset"), a `BsSlider` render-plugin type, a plugin manager service and three field formatters (Text, Media, Media Gallery). You create one or more optionsets at Configuration → Media → BS Slider, each bound to a `BsSlider` plugin (Bootstrap Carousel, Bootstrap Gallery Grid, Swiper, Tiny Slider, …) provided by an enabled submodule, then pick that optionset in a field formatter, a Views "BS Slider" style, or a Paragraph behavior. At render time the chosen plugin's `view()`/`preprocess()` wraps the built items in the `bs_slider` theme hook, whose template suggestions (`bs_slider__PLUGIN`, `bs_slider__CONFIG`) let themers override per plugin or per optionset. Enable at least one library submodule (e.g. `bs_slider_bootstrap`) or there are no plugins to choose.

---

- Build a homepage hero carousel from a multi-value media (image) field using the Bootstrap Carousel plugin.
- Create a reusable "optionset" once and apply the same slider configuration to many fields/displays.
- Turn a multi-value text field into a rotating text/quote slider with the BS Slider Text formatter.
- Show referenced media entities (images, remote video, oEmbed) as a carousel with the BS Slider Media formatter.
- Build a thumbnail-plus-fullscreen gallery with the Bootstrap Gallery Grid plugin (grid or column layout, configurable columns and gutter).
- Render a Swiper.js carousel with pagination bullets, navigation arrows, scrollbar and autoplay configured in the UI.
- Add fade, cube, coverflow, flip or cards transition effects to a slider via the Swiper plugin.
- Configure a linked Swiper "thumbs gallery" where a main Swiper is driven by a synchronized thumbnail Swiper.
- Enable fullscreen-on-click for Swiper slides.
- Add a Tiny Slider (tns) carousel configured entirely in YAML for fine-grained control.
- Expose slider markup from a View by choosing the "BS Slider" Views style plugin on the display.
- Let content editors pick a slider per Paragraph via the BS Slider Paragraphs behavior, mapping a multi-value field to slider items.
- Display an `entity_reference_revisions` field (e.g. nested paragraphs) as a slider with the ERR formatter.
- Choose a different rendering view mode for slider items vs. thumbnails independently.
- Provide multiple named optionsets (e.g. "Homepage carousel", "Product gallery") and switch between them per display.
- Duplicate an existing optionset as a starting point for a new one via the Duplicate operation.
- Override slider markup for a specific optionset by adding a `bs_slider__{config_id}.html.twig` template to your theme.
- Cross-fade slides instead of the default slide transition in Bootstrap Carousel.
- Autoplay a carousel at a configurable interval and pause it on hover.
- Provide keyboard-navigable carousels (Bootstrap keyboard events, Swiper keyboard module).
- Lazy-load Swiper slide images to improve initial page load.
- Reuse an already-defined Bootstrap Carousel optionset as the "full view" inside a Bootstrap Gallery Grid.
- Programmatically load optionsets and their plugins through the `bs_slider_configuration.manager` service in custom code.
