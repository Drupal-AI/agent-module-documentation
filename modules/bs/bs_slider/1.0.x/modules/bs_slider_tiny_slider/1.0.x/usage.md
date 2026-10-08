Adds a Tiny Slider (tns) plugin to BS Slider, configured via YAML.

---

`bs_slider_tiny_slider` is a library submodule of BS Slider. It registers the `tiny_slider`
`BsSlider` plugin, backed by the Tiny Slider (tns) v2 library. Unlike the Bootstrap and Swiper
submodules it exposes no per-option UI: you enter the whole tns configuration as YAML in a single
textarea. The YAML is parsed, JSON-encoded into a `data-bs-slider-options` attribute, and passed to
`tns()` by `js/tiny-slider.js`. The Tiny Slider library must be self-hosted under
`/libraries/tiny-slider/`. Enable it, create a "Tiny Slider" optionset with your YAML options, and
reference it from a formatter, Views style or Paragraph.

---

- Build a Tiny Slider carousel from a media/image or text field.
- Configure any tns option (items, slideBy, autoplay, controls, nav, gutter, responsive, …) via YAML.
- Define responsive breakpoints in the YAML configuration.
- Enable autoplay with custom timing through tns options.
- Show/hide navigation dots and prev/next controls.
- Set the number of visible items and gutter spacing.
- Enable loop/rewind behavior supported by tns.
- Use tns lazyload and mouse-drag options.
- Render slider items in a chosen view mode.
- Theme the slider markup per optionset via template suggestions.
- Reuse one YAML optionset across multiple fields/displays.
