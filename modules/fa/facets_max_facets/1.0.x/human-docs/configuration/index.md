# Configuration

Configuring Facets Max Facets has two parts: set the global limit and message on
the module's settings form, then turn the cap on for each facet you want it to
affect. The cap does nothing until you opt individual facets in.

## 1. Set the maximum and the message

1. Log in as an administrator.
2. Go to **Configuration → Search and metadata → Facets → Max facets**, or
   navigate directly to `/admin/config/search/facets/max-facets`.
3. On the form:
   - **Maximum number of facets** — the largest number of facets a visitor may
     have active at once. Once this is reached, no further facet options are
     offered.
   - **Message** — the text shown to a visitor who has reached the maximum,
     letting them know they cannot add more filters.
4. Save the form.

Choose a maximum that is comfortably above what a real visitor would ever use, so
the limit only bites on abusive, bot‑like patterns.

## 2. Opt each facet into the cap

The global setting only affects facets you explicitly enrol:

1. Go to **Configuration → Search and metadata → Facets** and edit a facet you
   want the cap to apply to.
2. Tick **"Respect global max facets"**.
3. Save the facet.
4. Repeat for every facet you want the limit to cover.

## Recommended: pair with Facet Bot Blocker

For stronger protection, also install
[Facet Bot Blocker](https://www.drupal.org/project/facet_bot_blocker) and set it to
trigger at your maximum **+ 1**. That way a bot that tries to push additional
facets through URL parameters gets the expected "not allowed" response, while
humans — capped by this module — never see an unexpected error page.

## Verify

On a page with capped facets, apply filters up to the maximum and confirm that no
further facet options are offered and that your message appears once the limit is
reached.
