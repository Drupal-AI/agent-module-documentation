# Configuration

Fast Autocomplete has two layers: a small **general settings** form and one or more
**Fast Autocomplete configurations**, each of which attaches typeahead to a set of
inputs. Both live under Search and metadata and require the **administer fac
settings** permission.

## General settings

Go to **Configuration → Search and metadata → Fast Autocomplete → Settings**
(`/admin/config/search/fac/settings`). There are two options:

- **Hash key rotation interval** — how often (in seconds, default one week /
  `604800`) the role‑based cache hash rotates. This only matters when a configuration
  runs searches as the current user rather than anonymously. You can also override it
  in `settings.php`.
- **Load highlighting script from CDN** — whether mark.js (used for keyword
  highlighting) loads from a CDN (on by default) or from a local copy at
  `/libraries/mark.js/jquery.mark.min.js`. Switch it off if your site can't use the
  CDN.

## Create a Fast Autocomplete configuration

Go to **Configuration → Search and metadata → Fast Autocomplete**
(`/admin/config/search/fac`) and click **Add**. You can create several independent
configurations, each attached to different inputs. The form's fields:

### Identity and target

- **Label** and **machine name** — a name for this configuration (the machine name is
  fixed once created).
- **Input selectors** *(required)* — one or more jQuery/CSS selectors identifying the
  text inputs to enhance, comma‑separated (for example `input.form-search`).
- **Result location** — a jQuery selector for the element the suggestions are appended
  to. Leave it empty to append to the input's own form.

### Search backend

- **Search plugin** — choose how suggestions are found:
  - **Basic title search** — a simple `LIKE` match on published node titles. Its
    sub‑settings let you restrict to certain **content types** and filter by
    **language**.
  - **Search API search** — query a Search API index instead. Its sub‑settings let you
    pick the **index**, which **full‑text fields** to search, a **sort field** and
    **direction**, and the same language filter. (Requires the Search API module and a
    configured index.)
  - Any custom backend a developer has added via the `fac_search` plugin type.

### Appearance and behaviour

- **Number of results** — how many suggestions to show (default 5).
- **View mode per entity type** — the view mode used to render each suggestion, per
  entity type, so results can look like teasers rather than plain text.
- **Minimum / maximum key length** — the query only fires when the typed text is
  within this range (defaults 1 and 10). This prevents wasteful one‑character or
  very long queries.
- **All‑results link** and its **threshold** — show a "view all results" link once the
  number of suggestions passes a threshold (0 = always show it).
- **Breakpoint** — the minimum viewport width (in pixels) at which autocomplete is
  enabled, so you can keep it off on small screens (0 = always on).
- **Empty result** — raw HTML shown when the input is focused but empty — handy for
  "quick links" or popular searches. This is admin‑entered markup, so treat it as
  trusted: don't populate it from untrusted sources.
- **Highlighting** — highlight the typed keywords inside the suggestions using
  mark.js.

### Access and caching

- **Perform search as anonymous user only** — **on by default**, and the safe choice.
  Because suggestions are cached in public JSON files, running the query as the
  anonymous user guarantees restricted content can't leak into that public cache. Turn
  it off only if you specifically need per‑user results; the cache path then includes
  a rotating role‑based hash so users only receive cache built for their own roles.
- **Clean up files** and **files expiry time** — let cron delete cached JSON files
  older than a relative time you specify (for example `-1 day`), keeping the cache
  fresh and the directory tidy.

Click **Save**. The autocomplete becomes active on any page containing a matching
input.

## Clearing the cache

You can purge a configuration's cached JSON from the **Operations** dropdown on the
configurations list, or from the command line for all or specific configurations:

```bash
ddev drush fac:cache-clear
ddev drush fac:cache-clear --fac_config_ids=default,test
```

Clear the cache after changing content or a configuration so stale suggestions are
regenerated.
