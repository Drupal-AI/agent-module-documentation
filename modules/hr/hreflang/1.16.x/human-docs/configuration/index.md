# Configuration

Hreflang works with no configuration at all — the defaults produce correct tags on
a multilingual site. This page covers the three optional settings on its form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Hreflang tags**, or navigate
   directly to `/admin/config/search/hreflang`.

The form edits the `hreflang.settings` configuration object, which has a schema and
so exports and deploys cleanly with `drush config:export`. Whenever you save a
change here, the module automatically clears the page cache so the new tags take
effect right away.

## The three settings

### Add an x-default hreflang tag

*(checkbox, on by default)*

When ticked, the module adds an extra `<link rel="alternate" hreflang="x-default">`
tag in addition to the per‑language tags. The `x-default` value tells search engines
which URL to serve to visitors whose language or region does not match any of your
enabled languages — a sensible catch‑all. By default this tag points at your site's
**default language**. Leave it on unless you have a specific reason not to emit an
x-default tag.

### Point x-default at the fallback (selected) language

*(checkbox, on by default)*

This only matters when the previous option is on. When ticked, the `x-default` tag
points at your configured **fallback language** — the "Selected language" set under
Drupal's language detection and selection settings — instead of the raw site
default, when a fallback is configured. This is useful when the language you would
rather serve to unmatched visitors is not the same as the site's technical default
language. If no fallback is configured, the tag falls back to the site default
anyway.

### Defer to Content Translation on entity pages

*(checkbox, off by default)*

When ticked — and when core's **Content Translation** module is enabled — Hreflang
stops adding its own per‑language tags on content‑entity pages (nodes, terms, etc.)
and lets Content Translation handle them instead. Hreflang still adds the
`x-default` tag on those pages if you have it enabled. This is a caching
optimisation: it avoids creating a separate cached copy of a page for every
combination of query‑string arguments. The trade‑off is that Content Translation
does not add query‑string arguments to its tags, so on pages that rely on query
strings the tag set will be less complete. Leave this off unless page‑cache
efficiency on entity pages is a concern for you.

## Save

Click **Save configuration**. The change takes effect immediately — reload any page
and inspect its source to see the updated hreflang tags.
