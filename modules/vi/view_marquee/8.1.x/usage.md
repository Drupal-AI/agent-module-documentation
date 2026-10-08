View Marquee is a Views style plugin that renders a view's rows inside an HTML `<marquee>` element, producing a scrolling ticker of content with configurable direction and speed.

---

The module adds a single Views style plugin (`view_marquee`, id `view_marquee`, theme `views_view_view_marquee`) selectable on any view display under *Format → Marquee*. Its options form exposes: `row_class` (CSS class per row, default `marquee-row`), `direction` (left/up/right/down), `behavior` (scroll/alternate), `speed` (maps to the `scrollamount` attribute), `delay` (maps to `scrolldelay`), and a `mouseover` checkbox that pauses scrolling on hover via inline `onmouseover`/`onmouseout` handlers. `template_preprocess_views_view_view_marquee()` (in `view-marquee.theme.inc`) turns those options into raw attribute strings, and the Twig template `views-view-view-marquee.html.twig` wraps the rendered rows in `<marquee>` and attaches the `view_marquee/marquee-style` CSS library. There is no admin settings page (`configure` is null), no permissions, no config schema, and no submodules; all configuration lives inside each view display's style options. Note that `<marquee>` is a deprecated, non-standard HTML element — browsers still render it but support is not guaranteed long-term.

---

- Display a scrolling news ticker of the latest articles across the top of a page.
- Show a horizontally scrolling list of announcements or alerts in a block.
- Build a right-to-left or left-to-right marquee of promotional items.
- Create a vertically scrolling (up/down) list of recent content.
- Render a scrolling ticker of stock/price or status rows from a view.
- Show scrolling testimonials or quotes.
- Present a continuously looping list of sponsor or partner names.
- Make a scrolling list of upcoming events.
- Build an "alternate" (bounce) marquee that reverses direction at each edge.
- Pause the scroll when a visitor hovers so they can read a row.
- Adjust the scroll speed with the `scrollamount`-backed speed option.
- Add a delay between scroll steps for a slower, jumpier motion.
- Apply a custom CSS class to each row for styling within the marquee.
- Display a scrolling list of tagged/taxonomy-filtered content.
- Turn any existing view (block, page, attachment) into a marquee by switching its Format.
- Show scrolling weather or notice items in a sidebar block.
- Create a retro-styled scrolling banner for a landing page.
- Display a marquee of most-recent comments or forum topics.
- Render a scrolling job-listings or classifieds ticker.
- Provide a lightweight, JS-free scrolling display without adding a carousel library.
