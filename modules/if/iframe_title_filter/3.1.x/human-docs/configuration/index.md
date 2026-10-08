# Configuration

iFrame Title Filter has no settings form of its own. "Configuring" it means enabling
its text filter on the text formats you want, and making sure it runs at the right
point in the filter order. The Media oEmbed titling needs no configuration at all.

## Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on the format your editors use for content with embeds (for
   example *Full HTML* or a custom landing‑page format).
3. Under **Enabled filters**, tick **Add missing titles to iFrames**.
4. Save the format.

The filter itself has no options — ticking it is all that is required. Repeat for
every format where iframes may appear if you want site‑wide coverage.

## Order it correctly

This is the important part. The filter works on the **final** iframe markup, so it
must run **after** anything that generates or cleans up iframe HTML:

1. On the same format‑configuration page, scroll to **Filter processing order**.
2. Drag **Add missing titles to iFrames** to a position **below** (later than):
   - any HTML‑correcting filter, and
   - any filter that produces iframes, such as **Media embed** or **video_filter**.

If you place it too early, it may run before the iframes exist and have nothing to
title.

## What it does

When content is rendered, the filter loads the HTML and looks at every `<iframe>`.
For any iframe that has **no** `title`, it reads the host from the iframe's `src`
URL and sets the title to "Embedded content from *host*" (falling back to the raw
URL when there is no host). Iframes that already have a title are left exactly as
the author wrote them.

## Media oEmbed embeds (automatic)

Separately, and with no configuration, the module titles core **Media** oEmbed
iframes — the ones produced when you embed a YouTube, Vimeo, or similar remote
video. Title‑less oEmbed iframes get the oEmbed resource's own title, or "Embedded
content from *provider*" (for example "Embedded content from YouTube") as a
fallback. A theme suggestion, `media_oembed_iframe__iframe_title_filter`, is
provided if you ever need to override that markup in a custom theme.

## Setting it in configuration files

If you manage configuration in code, you can enable the filter by adding
`filter_iframe_title` to a format's `filters` with `status: true` in its
`filter.format.<id>.yml`. The filter carries no settings of its own.
