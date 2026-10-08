BE-Alert fetches emergency alerts from Belgium's official BE-Alert / publicalerts.be CAP feed and renders them in a Drupal block.

---

BE-Alert is a thin integration module for the Belgian federal emergency-notification service (publicalerts.be, operated by FPS BOSA / the National Crisis Center). It provides a single service (`AlertsFetcher`) that calls the publicalerts.be CapGateway feed over HTTPS using a per-environment API key, and a "BE-Alert Live" block plugin that renders each returned alert item (start time and description, linked to the public alert map) via a theme template. Two environments are supported — a sandbox feed (test data, forced to a wide date range) and the production feed — selected per block instance. API keys for each environment are stored in the `be_alert.settings` config object and edited on a settings form gated by `administer site configuration`. The block disables its own cache so alerts are always live. The module targets Belgian public-sector and municipal sites that must surface official emergency broadcasts to visitors.

---

- Display live Belgian federal emergency alerts (BE-Alert) on a municipal or public-sector website.
- Add the "BE-Alert Live" block to a header, sidebar, or emergency-banner region via `/admin/structure/block`.
- Show a real-time storm, flood, fire, or chemical-incident warning banner sourced from publicalerts.be.
- Configure separate sandbox and production API keys at `/admin/config/system/be-alert-settings`.
- Test the integration with placeholder alerts by enabling the block's "Use sandbox?" option before go-live.
- Point a single site at the production BE-Alert CapGateway feed once credentials are approved.
- Surface each alert's start time (`startDate`) formatted as `d/m/Y H:i` next to its description.
- Link every rendered alert to the public alerts CAP map (`https://publicalerts.be/CapGateway/#!/?lang=<lang>`).
- Serve alert text in the visitor's current interface language by passing the language id (with a `-Be` suffix for non-English) to the feed.
- Provide crisis-communication content on tourism, transit, or event sites for Belgian regions.
- Run multiple block placements, one in sandbox and one in production, to compare feeds during acceptance testing.
- Integrate BE-Alert into a Drupal 10 or Drupal 11 site without adding any contrib dependencies.
- Store the BE-Alert API keys in configuration managed by the standard config system (exportable, overridable).
- Give editors a zero-configuration alert block once an administrator has set the keys and placed the block.
- Filter out feed items with no title so only meaningful alerts are shown.
- Automatically hide the block when the feed returns no active alerts (empty render).
- Log feed/HTTP errors to the `be_alert` logger channel for site operators to monitor.
- Localize the alert map link and feed query to the site's active language automatically.
- Build an always-fresh emergency banner that bypasses Drupal's render cache (cache max-age 0).
- Reuse the `AlertsFetcher` service from custom code to retrieve alerts programmatically for other displays.
- Override `be-alert-item.html.twig` in a theme to customize how each alert item is presented.
