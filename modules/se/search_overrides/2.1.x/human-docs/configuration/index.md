# Configuration

There are two things to set up: the **global settings** (how overrides match and
where you preview them) and the **individual overrides** themselves.

## Global settings

Go to **Configuration → Search → Search overrides → Settings**
(`/admin/config/search/search_override/settings`). This form requires the
**Configure search overrides** permission (a restricted, admin-only permission).
Its options are saved to the `search_overrides.settings` config object:

- **Search Path** (`path`) — the site-relative path of your search results page
  (for example `/search`). This is used **only** to build the preview/testing
  link; it does not restrict which searches overrides apply to.
- **URL Parameter** (`parameter`) — the query parameter that carries the search
  keywords, i.e. the "Filter identifier" of your exposed Fulltext filter (for
  example `query`). Also used only for the preview link.
- **Only match entire search strings** (`match_entire_string`) — when ticked, an
  override applies only when its query equals the user's whole search string.
  When unticked (the default), the override can also match individual terms
  within the search.
- **Content to select from** (`content_match`) — whether you pick content to
  elevate/exclude from **nodes** (`node`) or directly from a **Solr index**
  (`index`).
- **Solr index to select from** (`search_index`) — which Search API index to pull
  content from when *Content to select from* is set to *index*.

You can also set these from the command line:

```bash
ddev drush config:set search_overrides.settings match_entire_string 1 -y
ddev drush config:set search_overrides.settings content_match index -y
```

> **Note:** this version ships no config schema for these settings — they work,
> but there is no strict validation/translation for the keys.

## Creating an override

Go to **Configuration → Search → Search overrides**
(`/admin/config/search/search_override`) and choose **Add**. On the override
form:

- **Query** — the exact search string this override applies to (subject to the
  *match entire string* setting above). There is no fuzzy matching.
- **Elevated content** — the nodes (or index items) to force to the top of the
  results for that query.
- **Excluded content** — the nodes (or index items) to hide from the results for
  that query.

When picking from a Solr index, an autocomplete field lets you search the index
by keyword. Save the override and it takes effect on the next matching search.

You can remove a single elevated or excluded item from an override; if you remove
the last remaining item, the override deletes itself automatically.

## Previewing and debugging

- Use the configured **search path** and **parameter** to jump to a preview of
  the search that an override affects.
- Append **`?ignore_overrides=1`** to any search URL to bypass all overrides and
  see the original, un-tuned Solr ranking. This is handy for comparing before and
  after.

## Permissions

Under **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| **Add search overrides** | Create override entities. |
| **Edit search overrides** | Edit overrides. |
| **Delete search overrides** | Delete overrides. |
| **Administer search overrides** | Full create/edit/delete plus the remove and autocomplete routes. |
| **Configure search overrides** | The global settings form. This is the restricted permission. |

A useful pattern is to grant a marketing or editorial role the add/edit
permissions so they can curate results, without giving them full search
administration.
