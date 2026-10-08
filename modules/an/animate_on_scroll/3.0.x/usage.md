Animate On Scroll is a thin integration of the third-party AOS ("Animate On Scroll") JavaScript library: it loads AOS on every page and initializes it, so you animate elements simply by adding `data-aos` HTML attributes in your markup, blocks, fields or templates.

---

The module has no configuration UI, permissions, services, or plugins. `hook_page_attachments` attaches the `animate_on_scroll/animate_on_scroll_lib` asset library to every page; that library pulls `/libraries/aos/dist/aos.js` and `/libraries/aos/dist/aos.css` (plus core jQuery, drupal and drupalSettings) and the module's own `js/script.js`, whose single Drupal behavior calls `AOS.init()`. The AOS library itself is **not** bundled — you must download it from the AOS GitHub project and extract it into `/libraries/aos` in the Drupal root; `hook_requirements`/`hook_install` warn on the status report if `libraries/aos/dist/aos.css` is missing. Once the library is present, any element that has a `data-aos="<animation>"` attribute (optionally with `data-aos-duration`, `data-aos-delay`, `data-aos-offset`, `data-aos-easing`, `data-aos-once`, etc.) animates as it scrolls into and out of view. Because there is no settings form, all tuning is done through those per-element data attributes or by re-initializing AOS with your own JS. This is a presentational/front-end enhancement with no server-side logic or stored data.

---

- Fade content in as it scrolls into view (`data-aos="fade-up"`, `fade-left`, etc.).
- Zoom elements in on scroll (`data-aos="zoom-in"`, `zoom-out`).
- Slide elements in from a direction (`data-aos="slide-up"`, `slide-right`).
- Flip elements on scroll (`data-aos="flip-left"`, `flip-up`).
- Stagger animations of sibling cards/list items with per-element `data-aos-delay`.
- Control animation length per element with `data-aos-duration`.
- Change the easing curve with `data-aos-easing` (e.g. `ease-in-sine`).
- Trigger the animation earlier/later with `data-aos-offset` (pixels before the element enters).
- Animate an element only once with `data-aos-once="true"`.
- Add scroll reveal effects to Layout Builder blocks by putting `data-aos` on the block wrapper.
- Animate view rows or fields by adding the attribute in a Twig template or field template.
- Add entrance animations to hero sections, banners and calls-to-action.
- Reveal images progressively as a long landing page is scrolled.
- Apply consistent scroll animations site-wide without writing custom JS.
- Enhance marketing/campaign pages with lightweight motion.
- Animate testimonial or feature grids as the user scrolls.
- Use AOS anchor placement (`data-aos-anchor`, `data-aos-anchor-placement`) to sync animations to another element.
- Provide motion cues that draw attention to key content while scrolling.
- Re-animate elements on scroll-up as well as scroll-down (AOS default behavior).
- Prototype scroll-driven UI quickly by just adding attributes in the CKEditor source or block markup.
