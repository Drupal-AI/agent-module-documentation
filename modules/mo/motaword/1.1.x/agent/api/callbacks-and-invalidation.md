<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard callback, cache invalidation & config lifecycle

## CallbackSubscriber (`src/EventSubscriber/CallbackSubscriber.php`)

Service `motaword.callback_subscriber`, subscribes to `KernelEvents::REQUEST` at priority **100** (before RouterListener). Handles the MotaWord dashboard's refresh ping:

```
GET /?mw-active-callback={updated|project-updated|widget-updated}
```

`onRequest()` returns unless the query param is one of the three allow-listed `VALID_ACTIONS`. It then uses the site's **own** effective token (`MetadataStore::getToken()`) to trigger `MetadataRefresher::refresh($token)` — i.e. the site re-fetches its own project/widget metadata from Serve. It does **not** accept or import any content from the request. A `state`-backed cool-off (`COOL_OFF_SECONDS = 30`, key `motaword.last_callback_refresh`) throttles the refresh; every call still returns a static `JsonResponse(['status' => 'success'], 200)`. With no token configured it logs a warning and still returns success. This mirrors the WordPress plugin's anonymous callback contract.

## InvalidationManager (`src/InvalidationManager.php`, service `motaword.invalidation_manager`)

Decides which Serve cache entries to purge when Drupal state changes. Constructor: `config.factory`, `serveClient`, `request_stack`, `logger.channel.motaword`, `metadata_store`. Fails open (logs, never throws) and de-duplicates within a page lifecycle.

- `invalidateEntity(EntityInterface $entity)` — no-op without a token or for non-content entities. `block_content` → `invalidateDomain()`. Otherwise purges the entity's canonical URL variants `[url, url/, url/*]` via `invalidateUrls()`.
- `invalidateDomain(?string $reason)` — once per lifecycle; purges `[home, home/, home/*]` and calls `ServeClient::refreshDomain()` to re-crawl into the project's `targetLanguages`. Skipped in CLI (no request context).
- `invalidateUrls(array $urls, ?string $reason)` — `ServeClient::purgePages()`, tracking already-purged URLs to avoid spamming Serve.

Wired from `motaword.module` entity hooks: `hook_entity_insert`, `hook_entity_update`, `hook_entity_delete` → `invalidateEntity()`.

## ConfigSaveSubscriber (`src/EventSubscriber/ConfigSaveSubscriber.php`)

Service `motaword.config_save_subscriber`, subscribes to `ConfigEvents::SAVE` and `ConfigEvents::DELETE`. On a triggering config name it calls `InvalidationManager::invalidateDomain()`. Triggers: exact names `system.site`, `system.theme`, `system.theme.global`, `system.menu`, `system.performance`; prefixes `system.menu.`, `block.block.`, `core.block_visibility_groups.`. It explicitly ignores `motaword.settings` (would create a purge feedback loop when the settings form is saved).

## ConfigImportGuardSubscriber (`src/EventSubscriber/ConfigImportGuardSubscriber.php`)

Service `motaword.config_import_guard_subscriber`, subscribes to `ConfigEvents::STORAGE_TRANSFORM_IMPORT` at priority **-100** (after config_split / config_ignore). Uses the same storage-transformation API as Config Ignore. It protects a configured site from a deploy that would reset it:

- If this site has an effective token AND the incoming `motaword.settings` is unconfigured (empty token + install-default toggles, or missing entirely) → replace it with the site's active settings.
- Else if the site has a saved token but the incoming settings carry an empty token → keep the saved token and import the rest.
- An export that carries a token is imported as-is. An import that uninstalls the module is left alone.

`isUnconfigured()` compares the incoming settings against `config/install` defaults (ignoring `_core`, `langcode`, legacy `active_project_info`/`active_widget_info`, and empty host keys). Logs at most one notice per hour (`motaword.import_guard_last_notice`). Opt out with `$settings['motaword_config_import_guard'] = FALSE;`. Not covered: `drush cim --partial` and the single-item import form (they skip transformations).

## Cron & install (`motaword.module`, `motaword.install`)

- `hook_cron` → `MetadataRefresher::ensureLoaded(BACKGROUND_TIMEOUT)` loads missing metadata off the visitor path.
- `hook_uninstall` deletes the module's State keys.
- `motaword_update_10001` migrates project/widget metadata from the old `active_project_info`/`active_widget_info` config keys into the State API (run `drush updb` when upgrading from 1.0.x).
