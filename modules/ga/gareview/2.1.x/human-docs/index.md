# Google Site Review — manual setup guide

**Google Site Review** (`gareview`) displays live Google (Business) reviews on
your Drupal site. It pulls a business's Google reviews — the star ratings and
customer comments — and shows them on the site, which makes it handy for
restaurants, retail stores, hotels, real‑estate firms, and any other business
that wants to surface social proof on its marketing pages.

The reviews it shows are third‑party content that comes from Google, so what
appears on your site depends on that external service. The module is purely a
display feature: it has no access‑control role, and the review content is not
authored in Drupal.

According to the project's own documentation this module has **no
configuration** — you enable it and place its output where you want the reviews
to appear. If your setup connects to Google's reviews data through an API key or
Place ID, treat any such credential as a secret: store it in an environment
variable rather than committing it to configuration or version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — the project states it has
no settings form.

## How to use it

Once the module is enabled, use its provided output (typically a block) to place
the Google reviews where you want them on the site — for example in a sidebar or
footer region on your marketing pages. Because the ratings and comments are
fetched from Google, the content stays current with what the business shows on
its Google listing.
