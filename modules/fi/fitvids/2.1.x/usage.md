<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FitVids integrates the FitVids.js jQuery plugin to make embedded videos (YouTube, Vimeo, and other iframes) scale fluidly to their container width while keeping their aspect ratio.

---

The module attaches the FitVids.js library on every page (`hook_page_attachments`) and passes it three settings via `drupalSettings.fitvids`, all stored in the `fitvids.settings` config object: `selectors` (the CSS selectors of the containers whose videos should be made fluid, default `.node`), `custom_vendors` (extra iframe `src` prefixes to treat as videos, on top of the built-in providers — default `https://youtu.be`), and `ignore_selectors` (selectors whose videos should be left alone). Each newline-separated setting is converted to a JS selector string at attach time — e.g. a custom vendor `https://vimeo.com` becomes `iframe[src^="https://vimeo.com"]`. FitVids.js then wraps matching video iframes/objects in a fluid-width container so they resize responsively without fixed pixel dimensions. You configure it at *Configuration → Media → FitVids* (`/admin/config/media/fitvids`, route `fitvids.admin`, gated by the `administer fitvids` permission). The FitVids.js library file is expected at `/libraries/fitvids/jquery.fitvids.js`. It has no field formatter or block — it operates globally on the rendered page's matching containers.

---

- Make embedded YouTube videos scale responsively on mobile and desktop.
- Keep a 16:9 (or other) aspect ratio for videos as the viewport changes width.
- Apply fluid sizing to Vimeo embeds by adding vimeo as a custom vendor.
- Target only node content (`.node`) so videos in the body become responsive.
- Target a specific region/wrapper by changing the `selectors` setting.
- Add several container selectors (one per line) to cover multiple content areas.
- Register an additional video provider domain via `custom_vendors`.
- Support self-hosted or third-party iframe players by adding their src prefix.
- Exclude a particular widget's videos from resizing with `ignore_selectors`.
- Prevent a slider/carousel's videos from being wrapped by ignoring its selector.
- Fix videos that overflow their container on small screens.
- Provide responsive video without writing custom CSS aspect-ratio hacks.
- Make WYSIWYG-embedded videos in article bodies fluid site-wide.
- Restrict who can change the video settings via the `administer fitvids` permission.
- Deploy consistent responsive-video behavior via exported `fitvids.settings` config.
- Roll responsive video out to an existing content-heavy site without editing each embed.
- Handle videos inside teasers by pointing selectors at the teaser wrapper.
- Combine with oEmbed/Media embeds so their iframes become fluid.
- Keep videos responsive inside a two-column or grid layout.
- Ensure email-newsletter-style landing pages keep videos in ratio.
- Tune the ignore list so decorative background iframes are untouched.
