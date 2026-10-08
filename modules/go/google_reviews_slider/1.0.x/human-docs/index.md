# Google Reviews Slider — manual setup guide

**Google Reviews Slider** (`google_reviews_slider`, whose module machine name is
`google_reviews`) pulls the Google reviews of one or more places and displays them
in a configurable slider block — a tidy way to add social proof and testimonials
to a page.

Reviews are imported into a content type and shown in a custom **Google reviews**
block. Imports run on cron and can also be triggered manually with a *fetch
reviews* button. The block can show a global rating, a chosen number of individual
review messages (with the reviewer's name, star rating, profile picture and how
long ago the review was written), and an optional link inviting visitors to leave
their own review.

It is similar to the *Google Reviews* module, with two differences worth knowing:
reviews are imported as an **unpublished** review content type so you can moderate
what appears, and there are more display options — the slider format works well on
mobile.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your Google Places API key and
   place IDs, then place the reviews block.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → Review Settings**.
- **Block placement:** **Structure → Block Layout** (`/admin/structure/block`),
  where you place the *Google reviews* content block.

## How to use it

Configure the API key, place IDs and display options on the Review Settings form,
let cron (or the fetch button) import the reviews, then place the *Google reviews*
block in the region you want. Remember to clear the cache after changes.
