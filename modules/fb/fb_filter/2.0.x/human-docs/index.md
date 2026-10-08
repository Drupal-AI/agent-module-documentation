# Facebook Filter — manual setup guide

**Facebook Filter** (`fb_filter`) is a text‑format filter that converts Facebook
`#hashtags` in your content into links when text is rendered. Each matching
hashtag becomes a link to its Facebook hashtag page
(`https://www.facebook.com/hashtag/<tag>`) with the CSS class
`facebook-hashtag`, so you can style the links in your theme.

Because it is a text‑format filter, you do not configure it on a dedicated
settings page. Instead you add it to one or more of your site's text formats, and
it then links matching hashtags whenever text in that format is displayed. Its
effect is purely on output — the stored content is unchanged.

The filter has a single option: whether the hashtag links open in a new browser
tab. It has no access‑control role of its own and does not load any third‑party
script.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page** — you enable the filter on a text
format, as described below.

## How to use it — add the filter to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format you want to affect (for example *Basic HTML* or *Full
   HTML*) and click **Configure**.
3. Under **Enabled filters**, tick the **Facebook filter** filter.
4. If the format has several filters, check the **Filter processing order** tab so
   Facebook filter runs at a sensible point relative to the others — in particular
   **after** *Limit allowed HTML tags*, so the links it adds are kept.
5. Optionally, expand the **Facebook filter** settings and choose whether the
   hashtag links should open in a new tab.
6. Click **Save configuration**.

From then on, content written in that text format has its Facebook hashtags turned
into links automatically when it is displayed.
