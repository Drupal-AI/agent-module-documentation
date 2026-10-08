# Filter External Link Icon — manual setup guide

**Filter External Link Icon** (`filter_external_link_icon`) is a small text-format
filter that marks links pointing off your site with a little "external link"
indicator. When the filter is on, any anchor tag whose target is external gets a
`<span>` appended to it — by default a ↗ arrow — so readers can tell at a glance
that a link will take them somewhere else. It depends only on core's Filter
module.

The span's content is configurable. You can leave the default arrow, replace it
with your own text or symbol, or empty it entirely and instead attach a CSS
background image to the span so the icon comes from your theme. Nothing renders
until you turn the filter on for a specific text format, so it only ever affects
the formats you choose.

There is no site-wide settings page — this module is configured entirely as a
filter inside each text format you want it on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You switch it on per text
format, described in "How to use it" below.

## How to use it

Once the module is enabled, turn the filter on for whichever text formats should
flag external links:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want (for example *Basic HTML* or
   *Full HTML*).
3. Under **Enabled filters**, tick **Mark External Links**.
4. (Optional) In that filter's settings, change the content of the span that gets
   appended to external links — enter your own text or symbol, or clear it if you
   plan to style the span with a CSS background image instead.
5. Click **Save configuration**.

From then on, content saved with that format will show the external-link
indicator after every off-site link.
