Diba Carousel Slider provides one block plugin that builds a Bootstrap carousel directly from an entity type's own fields — pick the entity type, filter and sort the content, map fields to image/title/description/link, and place it in a region. No slide content type, view or extra module is required.

---

Most Drupal slider solutions ask you to assemble a stack — a slide content type, a view for the query, Entityqueue for ordering, and a JS library integration. Diba Carousel collapses all of that into a single configurable block. Each block instance runs its own entity query (any fieldable content-entity type: nodes, users, comments, media, terms) with bundle, publishing-status and single-field filters, an order field with ascending/descending/random direction, and a result limit. It then composes each result into a slide by reading the fields you assign as image, title, description and link, with regular or responsive image styles, multivalue-image strategies (first/last/random/all-split), safe truncation and a "See more" link. When placed in Layout Builder or a paragraph layout it can leave the entity type on "Automatic" and reuse the current context entity. All of this — plus Bootstrap layout options (indicators, controls, autoplay interval, columns per slide) and free-form CSS class fields — is stored in the block's own configuration, validated by the `block.settings.diba_carousel` schema and exported with the rest of a site's config. Internally the work is split across four services (options provider, query builder, slide builder, form builder). Dependencies are core only (`block`, `user`, `node`); the module emits Bootstrap carousel markup and expects the theme to supply Bootstrap's CSS/JS (Bootstrap, Barrio and subthemes are the tested targets). Optional `custom_pub` integration exposes custom publishing options as extra node filters.

---

- Put an image carousel in any page region without building a view.
- Add a homepage banner slider sourced from Article nodes.
- Build a slider on a Bootstrap-based theme (Bootstrap, Barrio).
- Give each slide a title link and a caption description.
- Show a carousel of the 5 most recent promoted nodes.
- Randomise slide order on each page load.
- Restrict a carousel to specific bundles (content types).
- Filter slides by a field value, including a taxonomy term id.
- Drive the filter value from a URL query param (`[query:arg]`) or path segment (`[argument:N]`).
- Filter by a date field using relative keywords such as "today" or "-1 week".
- Split a multivalue image field into one slide per image.
- Apply a regular image style or a responsive image style to slide images.
- Skip content that has no image.
- Truncate long descriptions on a word boundary with a "See more" link.
- Build carousels over users, comments, media or taxonomy terms, not just nodes.
- Reuse the current entity as context inside Layout Builder or a paragraph layout.
- Show multiple items per slide (2/3/4/6/12 columns).
- Disable autoplay by setting the interval to 0.
- Add utility classes to hide the carousel or caption on small screens.
- Use the "Diba left captions" style for a left-aligned caption panel.
- Export a configured carousel with `drush cex` / `drush cim`.
- Place different carousels in different regions with different content.
- Provide a lightweight alternative to Slick/Swiper with no extra JS download.
- Reuse the theme's existing Bootstrap carousel behaviour.
- Filter node content by custom publishing options (with `custom_pub`).
- Support sites on Drupal 10.3 through 12.
