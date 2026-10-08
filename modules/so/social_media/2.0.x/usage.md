Social media share renders configurable "share this page" (and follow) links for the current page as a Drupal block or as a field, with each network's URL, label, icon and HTML attributes driven by config and Token replacement.

---

The module ships a fixed set of share targets (Facebook share, Facebook Messenger, LinkedIn, Twitter/X, Pinterest, WhatsApp, Email, Print), each configured as an "item" under the single `social_media.settings` config object. Every item has an `enable` flag, a link `text`, an `api_url` built from Token placeholders (typically `[current-page:url]` and `[current-page:title]`), an `api_event` that decides how the URL is attached to the markup (`href` for a normal link, `onclick` for JS actions like `window.print()`), a `weight` for ordering, a `default_img` toggle for the bundled SVG icon, and a multi-line pipe-delimited `attributes` string. Output is produced by the `social_sharing_block` block plugin, which reads the config, runs Token replacement, sorts by weight, and renders through the `social_media_links` theme template. The Email item has an extra "forward this page" mode that swaps the `mailto:` link for an in-site `ForwardEmailForm` (optionally in an AJAX dialog). Three dispatched events (`social_media.add_more_social_media`, `social_media.pre_execute`, `social_media.pre_render`) let other modules add networks or alter the build. Because everything runs through Token, links always point at whatever page the block is rendered on. The module also provides a boolean-style `social_media` field type/widget/formatter, and depends on Token and core Field.

---

- Add a row of social share buttons to every page by placing the "Social Sharing block" in a region
- Let visitors share the current node to Facebook, LinkedIn, Twitter/X, Pinterest or WhatsApp
- Provide an "Email this page to a friend" link that opens an in-site forward form instead of the visitor's mail client
- Add a "Print this page" button that triggers the browser's print dialog via `window.print()`
- Enable or disable individual networks without touching code, from the settings form
- Reorder the share links by setting each network's `weight`
- Rename a share link's visible label (e.g. change "Twitter" to "X")
- Point a share button at a custom sharer endpoint by editing its `api_url`
- Use Token placeholders so each link automatically shares the exact page it appears on
- Attach custom CSS classes or `target`/`rel` attributes to each link via the `attributes` field
- Swap the bundled icon for a custom image per network
- Add a WhatsApp share link that only shows on small screens using an attribute class
- Open share links in a new tab with `target|_blank` and `rel|noopener noreferrer`
- Expose the share buttons as a field on a content type instead of a block
- Show the same share links on views pages, taxonomy term pages and panels, not just nodes
- Enable the Email item's AJAX dialog so the forward form opens in a modal
- Pass application-specific values to the frontend via a network's `drupalSettings` string (e.g. Facebook app id)
- Load an extra JS library for a network (e.g. the Facebook SDK) via its `library` key
- Add a brand-new network (such as Reddit or Telegram) by subscribing to the `social_media.add_more_social_media` event
- Programmatically re-order or relabel networks at render time by subscribing to `social_media.pre_execute` / `social_media.pre_render`
- Restrict the share block to certain content types or pages using core block visibility
- Cache-tag the share output per path so links stay correct as visitors move between pages
- Build a "follow us" bar by pointing each link at a fixed profile URL instead of a share URL
- Migrate share configuration between environments as a single `social_media.settings` config export
