# Convert URL Filter — manual setup guide

**Convert URL Filter** (`convert_url_filter`) adds a **text‑format filter** that
rewrites internal absolute URLs into relative ones when content is displayed. A
link entered as `https://example.com/page` is output as `/page`. The current
site's host is always treated as internal, and you can configure additional domain
names that should also count as internal, so links to those domains are relativised
too.

This is handy for domain migrations, keeping content consistent across multiple
environments (dev, stage, production), and avoiding hard‑coded domains baked into
your content. Because it is a display‑time filter, the **stored value is never
changed** — only the rendered output is rewritten — and it has no effect on access
or permissions. It depends only on core's **Filter** module.

There is no separate admin settings page: like every text‑format filter, you enable
and configure it inside a text format at **Configuration → Content authoring → Text
formats and editors**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page**. You enable and tune the filter
within a text format, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no page of its own. You configure it on your text formats at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors** and click
   **Configure** on the text format you want to affect (for example *Full HTML* or
   *Basic HTML*).
3. In the **Enabled filters** list, tick **Convert internal absolute URLs to
   relative**.
4. Scroll to **Filter settings** for that filter. Review the available options —
   including any **additional domain names** you want treated as internal (the
   current host is always internal automatically) — and set them as needed.
5. Click **Save configuration**. From now on, content rendered through that format
   will have its internal absolute URLs output as relative links, while the stored
   content stays unchanged.
