# Simple External Links — manual setup guide

**Simple External Links** (`sel`) automatically makes external links on your site
open in a new browser tab, and does it *safely* — adding `target="_blank"` along
with the right `rel` attribute (`noopener` / `noreferrer`) so you do not expose
visitors to tabnabbing. It is the module for the common client request: "make
outbound links open in a new window."

Opening external links in a new tab is a frequent wish, but doing it naively
introduces a security wrinkle. A link with only `target="_blank"` lets the page it
opens reach back into your page through `window.opener`, which is the basis of
tabnabbing — a phishing trick where the original tab is quietly navigated to an
impersonated page. That is also why Lighthouse warns about `_blank` links without
a matching `rel`. Simple External Links handles this for you by adding the
appropriate `rel` attribute. Modern browsers have applied `noopener` implicitly
for `target="_blank"` since around 2021, so the risk is largely mitigated on
current browsers, but the module makes it explicit — useful if you still support
older ones.

The module processes external links in three places: **menu links**, **link
fields** (via its `sel_link` field formatter), and **formatted text** (via its
`filter_sel` text-format filter). So switching it on is not quite the whole job —
you also point the relevant link formatters at `sel_link` and add the Simple
External Links filter to the text formats you use. After that, it marks outbound
links automatically. It depends on the **SpamSpan** module (`spamspan`).

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Simple External Links does not add a global settings page; instead you switch it
on where links appear:

- **Menu links** are handled once the module is enabled.
- **Link fields** — on the relevant display, set the field's formatter to the
  Simple External Links (`sel_link`) formatter so its output is processed.
- **Formatted text** — go to **Configuration → Content authoring → Text formats
  and editors** (`/admin/config/content/formats`), edit each text format you use,
  and enable the Simple External Links filter (`filter_sel`).

Once those are in place, external links in that content open in a new tab with the
safe `rel` attributes applied. Confirm the links you expect are being marked —
"external" is judged relative to your site, so verify it treats your links as you
intend.
