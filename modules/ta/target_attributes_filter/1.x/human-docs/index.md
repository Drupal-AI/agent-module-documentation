# Target Attributes Filter — manual setup guide

**Target Attributes Filter** (`target_attributes_filter`) is a text-format filter
that adds a `target` attribute to hyperlinks in your content — most commonly
`target="_blank"` so links open in a new tab. Opening external links in a new tab
is a common editorial wish, and this module handles it centrally rather than
asking authors to set it on every link.

The key idea is that the target value is an **administrator setting** on the text
format, not something content authors type per link. You pick the value (default
`_blank`), choose which links it applies to (all links, or only external ones),
and whether it replaces an existing target. Because the value is admin-controlled
and fixed, the filter is not an avenue for XSS. It depends only on core's
**Filter** module and is covered by Drupal's security advisory policy.

One security-adjacent note worth knowing: a link with `target="_blank"` can, in
older browsers, let the opened page reach back to your page through
`window.opener` (so-called tabnabbing) unless `rel="noopener"` is set. Modern
browsers apply `noopener` implicitly for `target="_blank"` (since around 2021), so
this is largely a non-issue today — but if you must support older browsers, make
sure `noopener` is added.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enabling and tuning the filter on a
   text format.

## Where it lives in the admin menu

There is no dedicated settings page. The filter is configured on each text format
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — edit a format and enable the *Add target
attribute to links* filter, then review its settings.
