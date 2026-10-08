Slick Views adds a Slick carousel/slideshow display style to Drupal Views, so any View of nodes, media, images, or other entities can be rendered as a responsive, touch-enabled slider.

---

Slick Views bridges the Slick module (a wrapper around the Slick carousel library) and core Views. It registers two Views **style plugins** — "Slick Carousel" and "Slick Grouping" — that appear in the View display's Format selector. Once selected, the style pulls its look and behavior from a Slick **optionset** (defined in the Slick module: number of slides, autoplay, arrows, dots, breakpoints, lazy load, etc.), so the same carousel presets can be reused across many Views. The Grouping variant lets you split View results by a field and render each group as its own carousel or as a nested "carousel of carousels". Fields or rendered entities become slides, and an optional secondary optionset drives a synchronized thumbnail/nav carousel (asNavFor). When the Blazy formatter is used on image fields, Slick Views automatically wires up lazy loading and lightbox galleries. It has no admin settings page of its own — everything is configured per-View in the Views UI — and stores its options in each View's exportable config.

---

- Turn a View of promoted articles into a homepage hero carousel.
- Build an image gallery slider from a media View.
- Display a rotating banner of featured content with autoplay.
- Create a testimonial slider from a View of testimonial nodes.
- Show a product carousel on a Commerce category page.
- Render a logo/partner strip that scrolls continuously.
- Add previous/next arrows and pager dots to a slideshow.
- Make a responsive carousel that shows 4 slides on desktop, 1 on mobile.
- Build a thumbnail navigation carousel synced to a main image slider (asNavFor).
- Group View results by taxonomy term and render each group as its own carousel.
- Create a "carousel of carousels" nested slideshow.
- Lazy-load slide images to improve page performance.
- Open slides in a lightbox gallery via the Blazy formatter.
- Reuse a single Slick optionset preset across many Views.
- Present a news ticker that auto-advances headlines.
- Build a featured video carousel from remote/media video fields.
- Add a swipeable, touch-friendly slider for mobile users.
- Show a "related content" carousel at the bottom of an article.
- Create an event calendar strip that scrolls horizontally.
- Display a staff/team members carousel with photos and roles.
- Export the carousel configuration as part of a View for deployment.
- Limit the number of items per group in a grouped carousel.
- Strip HTML tags from grouped/rendered output used as group headers.
- Provide an infinite-loop, center-mode carousel for portfolios.
