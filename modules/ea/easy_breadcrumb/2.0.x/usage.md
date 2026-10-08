Easy Breadcrumb replaces Drupal's core breadcrumb block with a configurable, path-based breadcrumb that also appends the current page title, so visitors get a complete "Home › Section › Page" trail with no per-page setup.

---

Core Drupal builds a fairly minimal breadcrumb and leaves off the current page. Easy Breadcrumb registers a high-priority `breadcrumb_builder` service that constructs each crumb from the current URL (path alias) segments plus the real page title, working out of the box with no configuration. A single settings form at **Admin → Configuration → User interface → Easy Breadcrumb** exposes dozens of options: whether to include a Home segment (and its label), whether to include the page-title segment and render it as a link, capitalization/transliteration of segment text, segment separators, truncation and display limits, excluded paths, replaced titles, and fully custom per-path breadcrumbs. It can pull titles from a menu, an alternative title field, or the site name, and can follow redirects when the Redirect module is present. On multilingual sites the language path prefix (`/en`) can be shown or hidden as its own segment. It optionally emits `BreadcrumbList` JSON-LD structured data into the page head for SEO. All settings are stored in the `easy_breadcrumb.settings` config object with schema and config-translation support, so they are exportable and translatable. It requires no modules outside core.

---

- Show the current page title as the last breadcrumb segment automatically.
- Add a "Home" crumb at the start of every breadcrumb trail.
- Rename the front-page crumb (e.g. "Home" → "Start") via `home_segment_title`.
- Build breadcrumbs from the URL/path alias on pages that have no menu trail.
- Render the current-page segment as a clickable link instead of plain text.
- Capitalize each segment (ucwords/ucfirst) for a polished look.
- Keep small words like "of", "and", "de" lowercase while capitalizing others.
- Force specific brand words (e.g. "iOS", "GmbH") to a fixed casing.
- Exclude admin routes from Easy Breadcrumb handling.
- Exclude specific paths (like `search`, `search/node`) from the trail.
- Replace ugly URL-derived titles with friendly synonyms via `replaced_titles`.
- Define fully custom breadcrumbs for specific paths via `custom_paths`.
- Truncate long segment labels to a maximum length with trailing dots.
- Limit how many segments are displayed on deep pages.
- Remove duplicate/repeated identical segments from the trail.
- Use a node's menu link title as the crumb label instead of the raw path.
- Pull the crumb label from an alternative field (e.g. `field_breadcrumb_title`).
- Use the site name as the Home segment label.
- Show the language prefix (`/en`) as its own crumb on multilingual sites.
- Emit `BreadcrumbList` JSON-LD structured data for rich results in search.
- Follow redirects (with the Redirect module) so crumbs point to canonical URLs.
- Build breadcrumbs that reflect taxonomy term hierarchy.
- Output absolute rather than relative segment URLs.
- Hide the breadcrumb entirely when only a single Home item would show.
- Provide translatable Home/segment labels on multilingual sites.
- Deploy identical breadcrumb behavior across environments as exportable config.
- Gate breadcrumb configuration behind the "administer easy breadcrumb" permission.
