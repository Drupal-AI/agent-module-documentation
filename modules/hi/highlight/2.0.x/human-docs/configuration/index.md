# Configuration

Highlight works as soon as it is enabled — this settings form only **tunes** how
and where keywords are highlighted. If you never open it, the module still does
its job with sensible defaults.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the module's settings form, provided as `highlight.settings`, from the
   **Configuration** area under the **Search** group.

## What you can control

The module handles two distinct sources of search keywords, and the settings let
you decide which of them to act on:

- **Highlight keywords from a referring search engine** — when a visitor lands on
  your site from a search‑engine results page, the query they searched for can be
  read from the referrer and highlighted in your page content. Enable this to
  greet arriving searchers with their terms already emphasized.
- **Highlight keywords from local (on‑site) search** — when a visitor uses your
  site's own search, the matched terms are highlighted in the results and on the
  pages they open. This is the option to use if you have turned off a search
  back‑end's server‑side highlighting (such as Apache Solr's) and want the
  emphasis handled in the browser instead.

Adjust the options to match how your site is searched, then **save** the form.
Changes take effect on the next page load; you may want to clear caches if you
don't see them immediately.
