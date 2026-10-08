# Configuration

SearchStax has two layers of configuration: **site-wide settings** (analytics,
SearchStudio, flood protection) on the module's own forms, and **per-server
credentials** on the Search API Solr connector. All the admin forms are gated by
the core **Administer site configuration** permission — the module defines no
permissions of its own.

## The settings forms

There are three admin screens, all under **Configuration → Search and metadata →
SearchStax**:

- **Settings** (`/admin/config/search/searchstax`) — the main form.
- **Advanced settings** (`/admin/config/search/searchstax/advanced-settings`).
- **Version compatibility check**
  (`/admin/config/search/searchstax/version-check`) — logs into the SearchStax
  account API and reports whether the SearchStax Solr app matches your Drupal
  major version. This needs live credentials and network access.

The site-wide values are stored in the `searchstax.settings` config object. The
main options:

- **Analytics endpoint URL** (`analytics_url`, default
  `https://app.searchstax.com`) — the SearchStudio analytics base URL.
- **Analytics key** (`analytics_key`) — your global SearchStax analytics key. On
  multi-search sites you can also set per-search keys.
- **Searches via SearchStudio** (`searches_via_searchstudio`, default off) —
  re-route live search queries through SearchStudio instead of querying Solr
  directly.
- **Discard parameters** (`discard_parameters`, default
  `highlight, keys, spellcheck`) — Drupal query parameters to ignore when
  SearchStudio re-routing is on.
- **JS version** (`js_version`, default `3`) — which SearchStudio tracking
  JavaScript version to load.
- **EU Cookie Compliance** (`eu_cookie_compliance.enabled`, default on; plus a
  consent `category`) — gate tracking behind cookie consent.
- **Untracked roles** (`untracked_roles`) — roles excluded from analytics
  tracking (for example administrators and editors).
- **Flood protection** (`flood_protection.*`, default off) — rate-limit search
  and index-update requests per IP. Tunable limits and time windows:
  `search_limit` (default 15) / `search_window` (10 s), and `update_limit`
  (default 50) / `update_window` (60 s).

### Reading and writing settings with Drush

```bash
drush config:get searchstax.settings flood_protection.enabled

drush config:set searchstax.settings flood_protection.enabled true -y
drush config:set searchstax.settings flood_protection.search_limit 5 -y
drush config:set searchstax.settings searches_via_searchstudio true -y
```

For nested/sequence values (like `untracked_roles` or `analytics_key`), use
`php:eval`:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("searchstax.settings")
  ->set("untracked_roles", ["administrator"])
  ->set("analytics_key", "AK-123")->save();'
```

## The Solr connector (indexing)

To index content, create a Search API **server** (**Configuration → Search and
metadata → Search API → Add server**) with the **Solr** backend, then choose the
**"SearchStax Cloud with Token Auth"** connector. It authenticates to the hosted
cluster with a short-lived token rather than basic auth. Per-server credentials
live on the Search API server config itself (not in `searchstax.settings`), and
can point at a Key entity. Then create an index on that server and add your
content. Sites without Search API Solr get tracking/analytics only, with no
indexing connector.

## Storing credentials as Key entities

If the **Key** module is installed, the module ships two Key templates that are
created automatically — one for the Solr connector credentials and one for the
analytics credentials. Point the analytics `key_id` (in `searchstax.settings`) or
the connector's key at a Key entity to keep secrets out of your exported config.
Manage keys at **Configuration → System → Keys**.
