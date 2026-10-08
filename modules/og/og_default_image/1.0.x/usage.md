<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OG Default Image sets a fallback `og:image` for Metatag, so a page shared on social media without its own image gets the site's default rather than nothing.

---

When a link is posted to LinkedIn, Facebook, Slack or WhatsApp, the platform reads `og:image` and renders a card. With no image the card is a bare line of text that attracts a fraction of the attention, and the pages most likely to lack one are exactly the pages most likely to be shared quickly — a news item, a landing page, an announcement written in a hurry. Metatag handles the tags themselves but takes the image from a field, so a node with an empty image field produces no tag. This module fills that gap in two steps: you upload one site-wide image at `/admin/config/search/metatag/og-default-image` (a `managed_file` widget accepting gif/png/jpg/jpeg up to ~5.6 MB, stored in `public://og_default_images/`), and it exposes the token `[og_default_image:og_default_image]`, which resolves to that file's absolute URL, to paste into the Open Graph image field of Metatag's global defaults. The configuration page is gated by Metatag's own `administer metatags` permission — the right choice, since it keeps one permission governing all metatag configuration rather than inventing a second. The token is the whole mechanism: uploading the image alone changes nothing until the token is wired into a Metatag `og:image` field; and if no image has been uploaded, the token deliberately returns the literal string `Please upload an image` rather than an empty value. Version **1.0.1**, depending on `metatag`, core `^9 || ^10 || ^11`. Note the name collision worth avoiding: `og` in Drupal usually means **Organic Groups**, and here it means **Open Graph** — this module has nothing to do with Organic Groups. Two practical points: the platforms have **dimension expectations** — around 1200×630, with a minimum below which the card renders small or not at all — so the default should be sized for that rather than being whatever was to hand; and social platforms **cache aggressively**, so a page scraped once with no image keeps its bare card until the platform is asked to re-scrape, meaning the fallback fixes future shares rather than past ones.

---

- Give every page a share image.
- Add a fallback og:image.
- Improve link previews on LinkedIn.
- Show a branded card on Facebook.
- Avoid bare text previews in Slack.
- Set a site-wide default share image.
- Improve WhatsApp link previews.
- Cover pages without their own image.
- Improve social click-through rates.
- Ensure consistent share branding.
- Add an image for landing pages.
- Support a campaign's shareability.
- Provide a default for news items.
- Improve preview quality on Teams.
- Set a default for taxonomy pages.
- Avoid empty og:image tags.
- Standardise social appearance.
- Support a marketing requirement.
