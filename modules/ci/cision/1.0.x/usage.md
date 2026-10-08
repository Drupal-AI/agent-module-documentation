Cision integrates Drupal with the Cision (TrendKite) Communications Cloud API and displays the media mentions of a saved Cision search in a configurable block.

---

The module ships a single API service (`cision.api`) that logs in to the Cision Next Generation Communications Cloud API at `api.trendkite.com` using a username and password held as Key entities (`cision_username`, `cision_password`), caches a short-lived auth token in state, and exposes methods for retrieving Total Mentions, the account's Searches, and Stats (AVE, readership, total mentions, social shares) for a given search id and date range. On top of that service it provides one Block plugin, "Cision Total Mentions", which pulls the mentions for a chosen search and time window, discovers a thumbnail for each mention URL through the `embed/embed` library, and themes the results as a card list (`cision_item_list` Twig template) with optional duplicate removal, a max-results cap, an image style, and a placeholder image. A settings form at `/admin/config/services/cision` stores the fallback placeholder media id. There are no entities, no drush commands, and no custom permissions — the only route is gated by `administer site configuration`.

---

- Display a "wall" of recent press/media coverage of your brand from a Cision saved search on a landing page.
- Show media mentions for a specific product or campaign by picking the matching Cision search id in the block.
- Limit a coverage block to a rolling window (e.g. `last year` to `now`) using strtotime-parseable start/end dates.
- Cap the number of mentions shown with the block's Max Results setting.
- De-duplicate syndicated articles that share a title across multiple outlets via the Remove Duplicates option.
- Apply a Drupal image style to mention thumbnails for consistent sizing.
- Provide a fallback placeholder image (a Media entity) for mentions that have no discoverable thumbnail.
- Store Cision API credentials securely as Key entities rather than in plain module config.
- Reuse the `cision.api` service in custom code to call `getTotalMentions()` for a search id and date range.
- Call `getSearches()` / `getSearchesOptions()` to list the account's saved searches (e.g. to build a select list).
- Retrieve aggregate metrics with `getStats()` — advertising value equivalency (AVE), readership, total mentions, or social shares.
- Build custom dashboards or reports from Cision stats in a controller or block using the injected service.
- Cache Cision responses automatically for one hour to reduce API calls and stay within rate limits.
- Place the mentions block in any region via Block layout, or add it as a component in Layout Builder.
- Render coverage in a decoupled/JSON context by wrapping the `cision.api` service methods in a custom endpoint.
- Show localized mention titles using the `lang` attribute derived from each mention's page metadata.
- Feed a marketing/communications team's PR results directly into the editorial site without manual copy-paste.
- Combine with imagecache_external to serve remote mention thumbnails through Drupal's image pipeline.
- Schedule or trigger a cache clear to force-refresh the mentions shown after a major news event.
