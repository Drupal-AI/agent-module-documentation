# Configuration

## Open the exclude settings

1. Log in as a user with the **Administer sitemap settings** permission.
2. Go to **Configuration → Search and metadata → Simple XML Sitemap → Exclude**, or
   navigate directly to `/admin/config/search/simplesitemap/exclude`.

## Write exclude patterns

Enter one or more patterns, each of which is matched against a URL path. The
patterns use PHP's `preg_match()` regular-expression syntax, so the special
characters have their usual regex meaning. Two worked examples:

- `^\/home$` — excludes exactly `/home`. The `^` anchors the start, the `$` anchors
  the end, and `\/` is an escaped slash, so this matches that one path and nothing
  else.
- `^\/node\/.*` — excludes `/node/` followed by anything, i.e. every `/node/*`
  path.

Any URL whose path matches one of your patterns is kept out of the generated
sitemap.

## Test before you trust it

An exclusion pattern is almost always broader than it first appears — a stray `.*`
or a missing `$` can quietly swallow a whole section of the site. After you add or
change a pattern:

- Prefer **narrow, anchored** patterns (with `^` and `$` where you can) over loose
  ones.
- **Regenerate and inspect the sitemap** afterwards to confirm that the URLs you
  meant to remove are gone — and, just as importantly, that the URLs you meant to
  keep are still there. A pattern that accidentally removes real pages means those
  pages stop being advertised to crawlers, which is easy to miss until traffic
  drops.

## Save

Save the form. The exclusions take effect for the sitemap the next time it is
generated.
