# Register & configure the Fastly purger

Fastly Purger has **no settings of its own**. You configure two things elsewhere:

1. **Fastly credentials / purge method** → the parent Fastly module's forms (`fastly.settings`,
   `/admin/config/services/fastly`). See `../../../4.0.x/agent/configure/settings.md`.
2. **The purger registration** → the Purge module.

## Add the purger (Purge)

UI: *Configuration → Development → Performance → Purge*
(`/admin/config/development/performance/purge`) → **Add purger** → "Fastly".

CLI:

```bash
drush p:purger-add fastly            # add the Fastly purger
drush p:purger-ls                    # list configured purgers
drush p:purger-rm <instance_id>      # remove it
```

Purgers are persisted in the `purge.plugins` config object under `purgers`, a list of
`{ order_index, instance_id, plugin_id }`. The Fastly purger's `plugin_id` is **`fastly`**
(the instance id is generated when added). Example:

```yaml
# purge.plugins
purgers:
  - order_index: 1
    instance_id: id0
    plugin_id: fastly
```

## The purger plugin

`FastlyPurger` (`@PurgePurger id = "fastly"`, types `{"tag","url","everything"}`,
`multi_instance = FALSE`). `routeTypeToMethod()` maps:

| Invalidation type | Method | Fastly API |
|---|---|---|
| `tag` | `invalidateTags` | `purgeKeys()` (tags hashed to Surrogate Keys) |
| `url` | `invalidateUrls` | `purgeUrl()` per URL |
| `everything` | `invalidateAll` | `purgeAll()` |

## Diagnostic check

`fastly_creds` (`CredentialCheck`) appears in Purge's status report
(`/admin/config/development/performance/purge` and `drush p:diagnostics`) and warns when the
Fastly API credentials are missing or invalid; it is bound to the `fastly` purger
(`dependent_purger_plugins = {"fastly"}`).

## Service alter

`FastlypurgerServiceProvider::alter()` removes the `cache_tags_invalidator` tag from
`fastly.cache_tags.invalidator`, so with fastlypurger enabled, cache-tag invalidations are handled
by Purge's queue/processors instead of the parent module's immediate invalidator.
