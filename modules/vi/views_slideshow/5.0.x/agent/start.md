# views_slideshow — agent start

Adds a **Slideshow** Views style that renders View rows as a jQuery slideshow. It is an
**API/framework**: the style + widgets live here, but the actual animation needs a *slideshow
type* engine — enable the bundled **views_slideshow_cycle** submodule (jQuery Cycle) or another
implementation. Depends only on core `views`. No global config form — everything is set
**per View display** under Format → Slideshow. Package: Views.

- Set up the Slideshow style on a View, pick skin/type, add widgets → [configure/views_slideshow.md](configure/views_slideshow.md)
- Plugin types it defines (type, widget, widget type, skin) + how to add one → [plugins/views_slideshow.md](plugins/views_slideshow.md)
- Templates, theme hooks & libraries → [theming/views_slideshow.md](theming/views_slideshow.md)
