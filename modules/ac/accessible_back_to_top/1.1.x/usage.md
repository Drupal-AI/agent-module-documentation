Accessible Back To Top adds a keyboard- and screen-reader-friendly "back to top" button to your site as a placeable block.

---

The module ships a single Drupal block plugin ("Back to top block") whose static markup, CSS, and vanilla JavaScript together render a floating circular button in the lower-right of the viewport. The button stays hidden until the visitor scrolls past roughly 800px, then appears; a click or an Enter/Space keypress smooth-scrolls the window back to the top. The markup is focusable (`tabindex="0"`, `role="button"`) so keyboard users can reach it, and on keyboard activation focus is moved to the page's `.skip-link`. There is no settings form and no configuration to manage — you simply enable the module, place the block in a theme region, and optionally override the `.back-to-top` CSS to restyle it. It has no dependencies beyond Drupal core and works on Drupal 8 through 11.

---

- Give long-form landing pages and articles a quick way to return to the top without manual scrolling.
- Improve keyboard accessibility by offering a focusable, Enter/Space-activatable scroll-to-top control.
- Add a "back to top" affordance on documentation or knowledge-base pages that grow very tall.
- Place the button globally by adding the block to a persistent region (e.g. footer or content) in every theme.
- Restrict the button to specific pages using the block's standard visibility conditions (paths, content types, roles).
- Provide a mobile-friendly scroll-to-top control that only appears after the user has scrolled a meaningful distance.
- Move keyboard focus to the site's skip link after scrolling up, keeping screen-reader users oriented.
- Restyle the button's size, color, or position by targeting the `.back-to-top` class in your theme's CSS.
- Swap the arrow icon by overriding the background image on `.back-to-top .icon` in theme CSS.
- Reposition the button (e.g. lower-left for RTL layouts) by overriding the `bottom`/`left` CSS on `.back-to-top`.
- Offer a lightweight, dependency-free alternative to JavaScript-library-based scroll widgets.
- Add scroll-to-top behavior to a decoupled admin theme or custom theme without writing your own JS.
- Include a consistent scroll-to-top button across a multisite install by enabling the module per site.
- Enhance blog or news sites where readers frequently scroll through long feeds.
- Give e-commerce category pages with long product grids a fast path back to filters at the top.
- Improve UX on infinite-scroll or paginated Views listings by pairing them with a back-to-top button.
- Provide an accessible scroll control that degrades gracefully (the button is simply hidden when JS is off or scroll is short).
- Use smooth-scroll behavior for a polished return-to-top animation without custom code.
- Add the button to print-heavy or report pages where users scroll far down and need to jump back.
- Ship a small, auditable front-end enhancement (one block, one CSS file, one JS file) with minimal maintenance overhead.
