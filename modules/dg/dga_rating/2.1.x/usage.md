DGA Rating adds an accessible 1-5 star rating block with optional feedback and live average/count statistics, built to the Saudi DGA Design System, for both anonymous and authenticated visitors.

---

The module provides a single placeable block, "DGA Rating Widget" (`dga_rating_block`), that renders a closed-state summary (average rating + review count + a "Rate this service" button) and, when opened, a star selector plus a required feedback textarea. Ratings are submitted asynchronously to a JSON endpoint (`/dga-rating/submit`) and written to a dedicated `dga_rating` database table keyed by entity type/id and a language-prefix-normalized URL — the module does not create Drupal entities or fields. A `DgaRatingService` (`dga_rating.service`) centralizes all reads/writes: saving submissions, computing per-entity/per-URL/overall averages, distributions, recent-activity, top-rated and most-reviewed pages, and user-type splits. An admin dashboard at `/admin/content/dga-rating` shows those statistics and a filterable/sortable submissions table with edit, delete and bulk-delete. All front-end strings are bilingual (English + Arabic), stored in the `dga_rating.settings` config object and editable through two admin forms (a Settings form and a Translations form) rather than translation files. Three permissions gate the dashboard (view / manage / administer). Feedback is `Xss::filter()`-sanitized on save and length-capped; anonymous submissions are IP rate-limited via configurable settings.

---

- Place the "DGA Rating Widget" block in a region (Content, Sidebar, Footer) to collect service/page ratings.
- Let anonymous visitors rate a page without logging in (submissions saved with a NULL user id).
- Collect 1-5 star ratings on node pages, tracked by both node entity id and URL.
- Collect ratings on non-node routes (views, custom pages) tracked purely by normalized URL.
- Gather optional written feedback alongside each star rating (required field, length-capped).
- Show a live average rating (e.g. "3.9") and total review count on each page.
- Auto-refresh the widget's statistics after a submission via `/dga-rating/refresh-block`.
- Fetch current stats programmatically for a URL or entity via the `/dga-rating/stats` JSON endpoint.
- Present a DGA Design System-compliant, keyboard-navigable, ARIA-labelled rating experience.
- Serve the widget bilingually (English/Arabic) with per-language text and RTL-aware markup.
- Customize every front-end label (question, instructions, button text, success/error messages) from the admin UI.
- Review all submissions on an admin dashboard with average, distribution and total counts.
- Break down ratings per URL to see which pages/services rate best or worst.
- Identify the top-rated page and the most-reviewed page at a glance.
- Track recent activity (last 7 days / last 30 days) and the percentage of positive (4-5 star) ratings.
- Compare anonymous vs authenticated submission volumes.
- Filter the submissions list by id, URL, rating value, feedback text, user id, or date range.
- Sort submissions by id, rating, created date, URL or user id.
- Edit an individual submission's rating and feedback from the admin edit form.
- Delete a single submission or bulk-delete many selected submissions at once.
- Rate-limit anonymous submissions per IP within a configurable time window to curb spam.
- Cap feedback length via a configurable maximum to bound stored text.
- Theme the widget by overriding the `dga-rating-widget.html.twig` template in a custom theme.
- Reach the admin area quickly through a dedicated toolbar/admin menu item with an icon.
