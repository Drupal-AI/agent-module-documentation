Scroll blocks makes a placed block slide up from the bottom of the viewport (or slide back down) according to how far the visitor has scrolled, configured per block placement.

---

The module adds a small set of options to every block's placement form. When you enable it on a block, the shipped CSS fixes that block to the bottom-center of the viewport and hides it off-screen; JavaScript then watches the scroll position and reveals the block once the visitor has scrolled past a "reveal" pixel distance, hiding it again past a "hide" distance. You can also gate the effect by window width, so it only pops up on (for example) desktop or only on mobile. A close button is injected onto the revealed block; clicking it mutes that block until the page reloads. It is pure configuration plus a JavaScript/CSS library — there are no PHP classes, no new entities, and no admin settings page: everything lives in the block's own third-party settings. Because the behavior only runs when the block is actually rendered on the page, the core block visibility conditions (pages, roles, content type) still decide where the block appears at all. The module works with core blocks placed through block layout, and was funded by Tidsskriftet.no, the Norwegian Medical Association's magazine.

---

- Slide a promotional banner up from the bottom of the screen after the visitor scrolls down.
- Reveal a sticky call-to-action once the reader has passed the hero section (set a reveal scroll distance in pixels).
- Show a floating newsletter-signup block part-way down a long article.
- Show a "download our app" bar only after the visitor has demonstrated engagement by scrolling.
- Hide a floating block again once the visitor scrolls beyond a chosen "hide" distance.
- Restrict a slide-up block to desktop only by setting a minimum window width.
- Restrict a slide-up block to mobile only by setting a maximum window width.
- Show a floating contact / phone bar mid-page on a landing page.
- Give visitors a dismissible close button on the pop-up block that mutes it until reload.
- Add scroll-triggered reveal behavior to a block without writing a custom scroll listener in the theme.
- Configure the reveal and hide thresholds independently per block placement.
- Combine scroll reveal with core block visibility conditions (pages, roles) to target where it appears.
- Reuse the same block in different regions/pages with different scroll thresholds by placing it twice.
- Replace accumulated bespoke "show on scroll" scripts in a custom theme with configuration.
- Present a cookie/consent-style floating notice that arrives after the first scroll.
- Show a limited-time offer bar that only appears within a scroll-distance window.
- Emit custom DOM events (`scroll_blocks_show_block` / `scroll_blocks_hideblock`) other scripts can hook into when a block is shown or hidden.
- Keep scroll-reveal logic in exported block configuration rather than in theme code.
- Style the slide-up panel and its close button by overriding the shipped CSS in your theme.
- Test the floating block at mobile widths to make sure it does not cover page content.
