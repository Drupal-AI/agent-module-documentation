Instafeed Block provides a configurable Drupal block that displays an Instagram feed client-side using the external instafeed.js library.

---

Instafeed Block ships a single block plugin ("Instafeed Block") that can be placed in any region. The block emits an empty container and attaches the instafeed.js library plus the site's Instagram access token and per-block options (post limit, media-type filter, post template, grid layout, custom classes) as drupalSettings; the visitor's browser then calls the Instagram Graph API and renders the returned posts. The Instagram access token is entered on a global settings form and stored in Drupal's State API, and an optional cron routine refreshes the long-lived token roughly once a month on the designated production host. The 2.x branch requires Drupal ^10.1 || ^11 || ^12 and relocates the module's hook implementations into an autowired OOP hook class while keeping block behaviour, token storage, and cron refresh identical to 1.x. The instafeed.js library must be downloaded manually to /libraries/instafeed.js/dist/instafeed.min.js.

---

- Display a Business or Creator Instagram account's latest posts in a sidebar, footer, or content region of a Drupal site.
- Add a "Follow us on Instagram" feed to a marketing landing page without embedding third-party iframes.
- Show a brand's Instagram gallery on the homepage using the built-in 1–4 posts-per-row grid layouts.
- Limit the feed to a set number of recent posts (1–50) to keep a compact widget.
- Filter the feed to only images, only videos, only albums, or any combination of those media types.
- Provide a custom single-line HTML template so each post links to Instagram and shows the caption.
- Render posts as plain linked images using the default template with zero configuration.
- Restyle the feed entirely with your theme by disabling the module's bundled CSS.
- Apply custom CSS classes to the feed container to hook into an existing design system.
- Place a curated Instagram feed on an events or news page to add social proof.
- Keep the Instagram access token in one place (settings form) and reuse it across multiple placements.
- Automatically refresh the ~60-day long-lived Instagram token on cron so the feed keeps working unattended.
- Restrict token refresh to a single production environment via the production_url setting to avoid invalidating the live token from staging.
- Verify the required instafeed.js library is installed from the Drupal status report before going live.
- Show a photographer's or agency's portfolio pulled live from their Instagram account.
- Embed a store's product-photo feed on a Commerce site to drive engagement.
- Add an Instagram feed block to a specific content type's page via block visibility conditions.
- Template video posts separately (using the media-type filter) so only playable media use a video-aware template.
- Give editors a self-contained block they can place through the Block Layout UI without touching code.
- Uninstall cleanly, with the module removing its stored token and timestamp State keys automatically.
