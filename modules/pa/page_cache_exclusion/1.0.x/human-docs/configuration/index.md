# Configuration

All exclusions are set on a single form. With no rules configured, the module
does nothing and page cache behaves exactly as core does.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Performance → Page Cache Exclusion**, or
   navigate directly to
   `/admin/config/development/performance/page_cache_exclusion`.

## The settings, field by field

- **Excluded pages** (`page_list`) — a textarea, one path per line. Any request
  matching a listed path is never written to the page cache. Use `*` as a
  wildcard and `<front>` for the front page. Each non-empty line must begin with
  `/` (the form validates this). Examples:

  ```
  /cart
  /user
  /product/*
  <front>
  ```

- **Exclude on query parameters** (`page_query_parameters_list`) — a textarea,
  one path per line, using the same pattern and `/`-prefix rules. A path here is
  skipped from the cache **only when the request carries any query parameters**.
  This is ideal for keeping tracking-tagged URLs (`?utm_source=…`) or
  search-results pages (which vary by `?query=`) out of the cache while still
  caching the clean URL. Example:

  ```
  /search
  <front>
  ```

- **Cache client error (4xx) responses** (`client_error_caching`) — a checkbox.
  When ticked, client-error responses (403, 404, etc.) are never cached, so a
  page you have just fixed appears immediately instead of serving a cached error.

Click **Save configuration** to store the rules. Path matching is
case-insensitive on the alias and is applied to both the internal system path
and the URL alias, so either form of a URL is caught.

## Things to keep in mind

- The module only skips the cache **write**. Pages already in the cache keep
  serving until they expire, so after adding or changing a rule, run `drush cr`
  (or purge caches) to flush existing entries.
- It affects only the anonymous **Internal Page Cache**. Dynamic Page Cache and
  render caching are unaffected, and authenticated users already bypass page
  cache.
- The settings live in the `page_cache_exclusion.settings` config object, so you
  can also manage them via configuration import for repeatable deployments.
