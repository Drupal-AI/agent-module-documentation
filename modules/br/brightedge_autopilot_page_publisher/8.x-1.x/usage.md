Applies BrightEdge Autopilot SEO recommendations to a Drupal site's page titles, meta descriptions, H1 tags, and arbitrary XPath-selected elements, driven from the BrightEdge platform / Chrome extension over REST plus an in-form SERP preview.

---

BrightEdge Autopilot Page Publisher is the Drupal-side bridge for BrightEdge's Autopilot Page Publisher. It exposes three POST REST endpoints under `/beapp/v1/drupal/` that the BrightEdge platform (or its Chrome extension) calls with a Drupal username and password: one updates an entity's metatag title/description and its H1 (node/term title), one reads back the live title, meta description, and H1 list of a page by scraping the rendered HTML, and one stores XPath-based text/image/link overrides for a page. XPath overrides are re-applied on every HTML response by a kernel `RESPONSE` event subscriber that rewrites the outgoing DOM. On content forms, a `hook_form_alter()` adds a "Brightedge" fieldset with SEO title and meta description fields plus a live Google SERP preview, and writes those values back into the entity's metatag field on save. The module requires the Metatag, Node, and Token modules and stores XPath overrides in its own `beapp_seo_references` table.

---

- Let BrightEdge Autopilot push a recommended `<title>` onto a specific node or taxonomy term by URL, without an editor logging in.
- Push a recommended meta description onto a page's metatag field from the BrightEdge platform.
- Replace a node's or term's H1/title text (find-and-replace on the exact current title) from a BrightEdge recommendation.
- Read a live page's current title, meta description, and all H1 tags back into BrightEdge to compare against recommendations.
- Auto-create a `field_meta_tags` metatag field on an entity bundle that lacks one, so meta updates can be stored.
- Override the text of an arbitrary on-page element (h1–h6, p, span, div, li, a, etc.) selected by XPath, without editing the source content.
- Override an image's `src` (and `alt`) on a rendered page via XPath.
- Override a link's `href` (and anchor text) on a rendered page via XPath.
- Apply the same XPath override across query-string variants of a URL by whitelisting specific query parameters.
- Bypass an XPath override for QA by appending `?beapp_xpath_mod=false` to the page URL.
- Give content editors a live Google SERP preview (favicon, site name, slug, title, description) while editing any entity with a metatag field.
- Edit SEO title and meta description directly inside the node/term edit form via the injected "Brightedge" fieldset.
- Validate BrightEdge platform connectivity with the built-in `Brightedge_Autopilot_Test` handshake that returns the authenticated user's roles.
- Restrict who BrightEdge can act as by only granting the `administer nodes` permission to the integration's Drupal user.
- Confirm an XPath override targets the intended element by validating it against the live page's original (pre-override) DOM before saving.
- Keep original vs. new values per XPath so overrides are only applied when the current DOM still matches the recorded original.
- Manage a whitelist of query parameters (via the `whitelisted_params` config) that should be treated as distinct pages for XPath overrides.
- Support any content entity type that exposes a canonical route and a title/name, not just nodes (media, files, and users are explicitly excluded from meta/H1 updates).
- Integrate the BrightEdge Chrome extension so SEO staff can publish title/meta/H1/XPath changes from their browser.
- Run the SEO integration on Drupal 8, 9, 10, or 11.
