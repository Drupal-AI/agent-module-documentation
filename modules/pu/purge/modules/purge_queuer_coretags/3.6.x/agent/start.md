# purge_queuer_coretags — agent start

Submodule of **purge**. The standard queuer: captures every cache tag Drupal invalidates and
queues a matching tag invalidation. Depends on `purge`.

- Queuer plugin `CoreTagsQueuer` (`Plugin/Purge/Queuer/CoreTagsQueuer`); the listener is
  `CacheTagsQueuer`.
- Config `purge_queuer_coretags.settings` with a `blacklist` sequence — tag prefixes NOT to
  queue. Set via the module's `ConfigurationForm` (reached from the Purge UI queuer config) or
  by editing the config object directly:
  ```yaml
  # purge_queuer_coretags.settings.yml
  blacklist:
    - 'config:'
    - 'http_response'
  ```

No permissions or plugin types of its own. Enable with a processor + purger (see `purge` core
docs) for tag-based external cache invalidation.
