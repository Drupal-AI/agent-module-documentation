<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Macy.js provides a Views style plugin that arranges results into a responsive Masonry-style multi-column grid via the Macy.js JavaScript library.
---
The module registers a `macyjs` Views style plugin (`MacyJs`, theme `views_view_macyjs` based on `views_view_unformatted`) that renders rows and initialises Macy.js on the client. A preprocess hook assigns each view a random container id (`Crypt::randomBytesBase64`) and passes the configured options to JS via `drupalSettings.macyjs[<id>]`. Options exposed on the style form include column count, X/Y margins, `trueOrder`, `waitForImages`, `useOwnImageLoader`, `mobileFirst`, and a `breakAt` textarea defining responsive breakpoints (parsed server-side with a regex into per-width column/margin objects). The Macy.js library itself (v2.5.1, MIT) is declared as a **remote/CDN library** (`https://cdn.jsdelivr.net/npm/macy@2`), with `js/macyjs.js` bridging Drupal settings to Macy.

Setup: enable the module (Views is required), create or edit a View, and choose **Macy.js** as the display's Format, then configure columns and breakpoints in the style settings. Because the library loads from jsDelivr's CDN, sites with a strict CSP or offline requirements should self-host the asset. Security posture: the module adds **no routes, permissions or config entities** — it is purely a Views display plugin; all settings are numeric/boolean options entered by users who already have Views admin access, and margins/columns are cast to `(int)` before reaching JS. No server-side data fetching or mutating endpoints.
---
- Enable the module (requires `views`).
- Add the **Macy.js** format to a View display.
- Set the number of columns for the grid.
- Configure horizontal (X) and vertical (Y) margins between items.
- Define responsive breakpoints via the `breakAt` field (e.g. `1200: 4, 640: 2`).
- Toggle `mobileFirst` breakpoint interpretation.
- Enable `waitForImages` so layout settles after images load.
- Use Macy's own image loader (`useOwnImageLoader`).
- Preserve source order with `trueOrder`.
- Build a responsive image/portfolio gallery from a View.
- Lay out cards or teasers in a Pinterest-style masonry grid.
- Self-host the Macy.js library instead of the CDN for CSP/offline needs.
- Reuse the plugin across multiple Views, each with its own random container id.
- Lay out user-submitted images or media entities in a grid.
- Vary column count per breakpoint for phone/tablet/desktop.
- Style the grid items with the row plugin's row classes.
- Present a product or team listing as an even masonry grid.
