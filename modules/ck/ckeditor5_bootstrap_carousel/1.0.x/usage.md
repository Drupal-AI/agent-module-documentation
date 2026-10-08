Insert and edit a Bootstrap 5 carousel (slideshow) directly inside the CKEditor 5 WYSIWYG editor.

---

CKEditor 5 Bootstrap Carousel adds a "Carousel" toolbar button to CKEditor 5 that lets editors build a responsive, mobile-friendly Bootstrap 5 carousel inline, with per-item toolbars for adding, deleting, labelling, activating, and styling slides. On save the markup is a plain `<div class="carousel">` structure carrying `data-carousel-id` and `data-carousel-item-label` attributes plus placeholder `<bootstrap-carousel-controls>` and `<bootstrap-carousel-indicators>` custom elements. A companion text-format filter, "Carousel enabler" (`filter_bootstrap_carousel`), runs at render time to inject the Bootstrap `data-bs-*` attributes and to generate the indicator and previous/next control buttons. The module depends only on Drupal core's `ckeditor5`; it loads no Bootstrap library itself, so the site's front-end theme must already provide Bootstrap 5's CSS and JavaScript for the carousel to function.

---

- Add a rotating image/text slideshow to body content without paragraphs or entity references.
- Give non-technical editors a WYSIWYG way to build and reorder carousel slides.
- Insert a carousel via the CKEditor 5 toolbar "Carousel" button.
- Add or remove individual carousel items from the item toolbar.
- Mark which slide is initially active (open the first item, or set any item active).
- Choose a carousel transition style: "Regular" (slide) or "Fade" (`carousel-fade`).
- Label individual slides so accessible `aria-label`s are generated on the indicator buttons.
- Auto-generate Bootstrap indicator dots for each slide at render time.
- Auto-generate accessible previous/next control buttons with visually-hidden text.
- Build a hero/banner slider on a landing page from within the editor.
- Create a product or portfolio image gallery as a carousel.
- Produce testimonial or quote sliders in rich-text fields.
- Reuse a single text format's carousel across many content types (any field using that format).
- Style carousels to match a theme by overriding Bootstrap 5 CSS variables — no markup changes.
- Enable the "Carousel enabler" filter on a text format so saved carousels animate on the front end.
- Extend the item toolbar with a custom CKEditor 5 plugin via the `bootstrapCarousel.toolbarItems` config.
- Keep carousel markup portable: it renders as standard Bootstrap 5 HTML any Bootstrap theme understands.
- Author carousels in CKEditor 5 on Drupal 10.6+ or 11.3+ sites.
- Migrate away from custom carousel field widgets toward inline editor-managed sliders.
- Preview carousel structure in the editor with dedicated editor CSS styling.
- Copy and paste carousel structures within the editor (clipboard-pipeline integration).
