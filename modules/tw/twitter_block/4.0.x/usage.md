<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twitter Block is a lightweight module that provides a single configurable block plugin (`twitter_block`) for embedding a Twitter/X user timeline on a Drupal site.

---

The module adds one core Block plugin, id `twitter_block` (admin label "Twitter block", category "Twitter"), and nothing else — no settings page, no permissions of its own, no services or plugin types. You place one or more instances of the block on the Block layout page, and each instance renders an embedded timeline for a given `@username`. The block's configuration form exposes the options Twitter's embedded-timeline widget supports, grouped into Appearance (theme, link color, border color, chrome), Functionality (related users, tweet limit, disable tracking), Size (width, height) and Accessibility (language, ARIA politeness). At render time `build()` emits a `<a class="twitter-timeline">` link element carrying the settings as `data-*` attributes and attaches Twitter's `widgets.js` (loaded externally from `//platform.twitter.com/widgets.js`), which progressively enhances the link into the live timeline. Creating and positioning the blocks relies entirely on the core Block module's "Administer blocks" permission. It never provides OAuth, tweeting from Drupal, or any server-side Twitter API integration — it is purely a front-end widget embed.

---

- Embed a public Twitter/X user timeline in a sidebar or footer region.
- Show your organisation's latest tweets on the front page.
- Place multiple timeline blocks, each for a different account (e.g. corporate + support handles).
- Display a dark-themed timeline to match a dark site design.
- Match the widget's link color to your site's brand color.
- Set a custom border color around the embedded timeline.
- Render a compact timeline by hiding the header, footer, borders, and scrollbar (chrome options).
- Produce a transparent-background timeline that blends into the page.
- Fix a timeline to a preset number of tweets (1–20) instead of an auto-scrolling feed.
- Constrain the widget to a fixed width (180–520px) to fit a narrow column.
- Constrain the widget to a fixed height (min 200px) for a short region.
- Suggest related accounts to follow after a visitor interacts with a tweet.
- Enable "Do Not Track" so the embed does not tailor content to the visitor.
- Override the widget language with a specific language code for a multilingual site.
- Set ARIA politeness to "assertive" when the timeline is a primary content source, for accessibility.
- Give the block a custom admin title/label for editors managing the layout.
- Restrict the timeline block to specific pages/roles using core block visibility conditions.
- Provide a live social feed without writing any custom code or theme templates.
- Add a marketing campaign account's feed to a landing page block region.
- Export the placed block as configuration and deploy it across environments.
