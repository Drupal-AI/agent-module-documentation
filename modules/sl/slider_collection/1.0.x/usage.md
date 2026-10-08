<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Slider collection is a **base/wrapper module** for JavaScript slider libraries: it ships abstract base classes and two settings-alter events, while the actual sliders are built as Views displays (rows become slides) or entity-reference field formatters provided by the library submodules `sc_swiper` (Swiper) and `sc_tinyslider` (Tiny Slider 2).

---

Rather than bind a site to one slider library, slider_collection factors out the shared parts — `SliderCollectionSliderBase` shapes the option array a library's init JS receives, and `SliderCollectionViewsStyleBase` extends the Views `StylePluginBase` with a common option form (autoplay, speed, loop, and per-breakpoint item counts for mobile/tablet/desktop) plus cache handling. Concrete libraries arrive as submodules: `sc_swiper` registers a `sc_swiper` Views style and two multi-value entity-reference formatters (`swiper_entity_reference`, `swiper_entity_reference_revisions`), and `sc_tinyslider` registers a `sc_tinyslider` Views style. Because the slider is a Views style, slide selection, filtering, sorting and paging are ordinary Views concerns, and switching libraries is a matter of changing the display's format. The base itself has no routes, permissions, settings page or config schema — it depends only on core `views` (`^10 || ^11`), and enabling it alone renders nothing until a library submodule is enabled and its JS library is downloaded locally into `/libraries`. Two events, `slider_collection.alter_view_settings` and `slider_collection.alter_entity_settings`, let other modules mutate the option object before it is JSON-encoded into the container's `data-*` attribute and parsed by the library — the supported way to set options (like Swiper's `effect`) that have no form field.

---

- Build a slider from a Views display where each row is a slide.
- Use Swiper as the slider library via the `sc_swiper` Views style.
- Use Tiny Slider 2 for a lighter footprint via the `sc_tinyslider` Views style.
- Switch slider library by changing the Views display format.
- Filter, sort and page slides using ordinary Views settings.
- Show a Swiper carousel of referenced entities via the `swiper_entity_reference` formatter.
- Show referenced paragraphs via the `swiper_entity_reference_revisions` formatter.
- Set responsive items-per-view for mobile, tablet and desktop breakpoints.
- Configure autoplay, loop, speed and space-between-slides per display.
- Build a testimonial carousel from content.
- Show recent articles in a slider.
- Build a partner-logo carousel from a media view.
- Standardise slider behaviour and option forms across a site.
- Add a new slider library by writing a submodule that subclasses the two base classes.
- Inject library options with no form field (e.g. Swiper `effect`/`fadeEffect`) via an event subscriber.
- Adjust a specific view's slider settings by checking the view id in a subscriber.
- Adjust entity-formatter slider settings based on the rendered entity.
- Keep sliders cache-friendly with per-view cache tags.
- Enable clickable/bullet/progressbar/fraction pagination on a Swiper view.
- Reuse Views exposed filters to let visitors narrow the slides shown.
