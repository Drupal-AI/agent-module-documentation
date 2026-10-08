# CKEditor 5 Custom Paste — manual setup guide

**CKEditor 5 Custom Paste** (`ckeditor5_custom_paste`) gives you site-controlled
say over what happens to content when an editor **pastes** it into CKEditor 5.
Pasting from Word, Google Docs, or another web page is where most editorial markup
problems begin: the clipboard carries inline font families, point sizes, colours,
`mso-` attributes, deeply nested spans, and hard-coded widths that the source
cares about and your site does not. CKEditor 5 already filters paste against the
enabled schema, but that still lets through plenty a site would rather not keep.
This module adds an extra layer of filtering so paste behaviour becomes a
configuration decision per text format.

Its distinctive feature is control over which HTML tags are **excluded** from the
paste styling transformations — useful when you want to protect certain structures
(like table layouts) from being stripped or reformatted while still cleaning up
everything else. After enabling, you turn the plugin on for a text format and
define the tags to exclude, tailoring paste handling to your site's needs.

Two things are worth keeping straight, because they are easy to conflate:

- **This is editorial hygiene, not a security control.** The real security
  boundary is the text format's **filter chain**, which is applied when content is
  rendered, no matter how the markup got into the field. A paste filter runs in the
  browser and can be bypassed entirely with the Source editing button or an API
  write. **Never let a paste rule substitute for a correctly configured
  `filter_html`.**
- **Filtering is lossy by design.** An editor who pastes a carefully formatted
  table and gets plain rows will just paste it again. Your rules need to keep what
  the site's own styles can express and discard the rest — which takes a pass with
  real content, not a guess.

The module depends only on core's CKEditor 5 module and runs on Drupal 9.3, 10,
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the plugin on a text format
   and define the tags to exclude from paste transformations.

## Where it lives in the admin menu

Custom Paste has no standalone settings page. You configure it per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — see [Configuration](configuration/index.md).
