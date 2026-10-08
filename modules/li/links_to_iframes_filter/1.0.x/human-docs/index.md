# Links to Iframes Filter — manual setup guide

**Links to Iframes Filter** (`links_to_iframes_filter`) is a text-format filter
that swaps **specific, admin-configured links** for iframe embed markup when text
is rendered. You define a mapping — "this link becomes this iframe" — and
wherever that link appears in text run through a format with the filter enabled,
it's replaced with the corresponding embed. A typical use is turning a known
video or map URL into its embed player.

The trust model is deliberately narrow, and it's worth understanding. The iframe
markup is **not** taken from arbitrary user-supplied URLs; it comes from a mapping
that an administrator curates, and matching is limited to the exact links you've
configured (it matches an anchor's `href` value exactly). That keeps it far safer
than a filter that would embed any URL a content author pastes.

Two things still deserve care. First, because the iframe markup is
**admin-defined and rendered straight into pages**, restrict the module's
mapping-management permission to trusted users. Second, iframes embed third-party
content, which carries the usual privacy and clickjacking considerations — and
you also control exposure by choosing which roles get a text format that includes
this filter.

The module depends on core's **Filter** module and stores its mappings in its own
database table.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.
2. [Configuration](configuration/index.md) — add link→iframe mappings and enable
   the filter on a text format.

## Where it lives in the admin menu

Mappings are managed at **Configuration → Content authoring → Links to iframes**
(`/admin/config/content/links-to-iframes`), and the filter is switched on per
text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). See [Configuration](configuration/index.md).
