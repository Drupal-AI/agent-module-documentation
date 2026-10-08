# Configuration

Search 404 works as soon as it is enabled — it points your 404 page at its search
handler automatically. Everything on this page is optional tuning. Open the
settings form at **Configuration → Search and metadata → Search 404 settings**
(`/admin/config/search/search404`); you need the *Administer search* permission.

The form is organised into the following areas.

## Which search to use

By default results come from your site's **default core Search page**. If you would
rather use Search API, a View, or another search, switch to a custom path:

- **Do a custom search** — turn this on to redirect 404s to a path of your choosing
  instead of core Search.
- **Custom search path** — the path to send visitors to; it must end with the
  `@keys` token, which is replaced by the parsed keywords (for example a View route
  like `search/@keys`).
- **Use Search by page** / **Use Google CSE** — route 404 searches to those modules
  instead, when they are enabled.

## How keywords are pulled from the URL

These options control how the broken URL is turned into a search query:

- **Ignore words** — stop words to drop from the query (default *and or the*).
- **Ignore extensions** — file extensions stripped from the last keyword before
  searching (default *htm html php*).
- **Combine with OR** — join the keywords with `OR` to widen the search.
- **Custom separator** — a custom string to join keywords with (ignored if OR is
  on).
- **Ignore language prefix** — drop a leading language code from the path on
  multilingual sites.
- **Use search‑engine query** — instead of the path, take the keywords from a
  search‑engine referrer (Google, Bing, Yahoo and others).
- **Regular expression filter** — a PCRE pattern whose matches are excluded from the
  query.
- **Ignore paths** — path patterns (one per line, `*` as a wildcard) that should
  show the normal 404 page with no search. Sensible defaults such as `admin/*` and
  `ajax/*` are already listed.

## Jump straight to a result

Instead of showing a list, Search 404 can send the visitor directly to a page:

- **Jump to first result** — redirect straight to the result when there is exactly
  **one** match.
- **Always go to the first result** — redirect to the first match even when several
  are found.
- **Limit "first result" to paths** — restrict the above to certain path patterns
  (for example `blog/*`).
- **Use a 301 redirect** — issue a permanent 301 redirect for the jump instead of
  the default temporary 302 (better for SEO once you are confident in the
  behaviour).

## Aborting and skipping searches

To protect large sites and avoid searching for asset requests:

- **Abort for all file extensions** — do not search any path that ends in a file
  extension (images, PDFs, scripts); on by default.
- **Abort for specific extensions** — when the "all" option is off, only abort for
  these extensions (default *gif jpg jpeg bmp png*).
- **Skip automatic search** — show the populated search form but do not run the
  search automatically, reducing load on very large sites.
- **Redirect to managed files** — if the requested path maps to a published managed
  file, send the visitor straight to that file.

## Custom text and fallback

Finally, you can control what the results page says:

- **Page title** — the title of the 404 search‑results page (default *Page not
  found*).
- **Page text** — HTML shown above the results.
- **Custom error message** — replaces Drupal's default message; use `@keys` to
  insert the search terms.
- **Disable error message** — suppress the error message on the results page
  entirely.
- **No‑results redirect** — a URL (starting with `/`) to send the visitor to when
  the search returns nothing (for example `/node`).

## Saving and deploying

Click **Save configuration** to apply. Saving also re‑asserts the 404 page setting,
so it always points back at Search 404. All settings live in the
`search404.settings` configuration object, so they export and deploy between
environments with `drush config:export` / `config:import`.
