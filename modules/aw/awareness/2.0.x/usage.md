<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Awareness is a developer library of PHP traits that expose common Drupal core services as protected getter methods, plus a Drush generator to create more.

---

Awareness ships roughly 47 single-purpose traits under the `Drupal\awareness\*` namespace. Each trait adds one (occasionally two) protected getter method to whatever class `use`s it, returning a commonly-used core service through a static `\Drupal::service()` / `\Drupal::<helper>()` call — e.g. `EntityTypeManagerAwareTrait` supplies `getEntityTypeManager()`, `HttpClientAwareTrait` supplies `getHttpClient()`, `DatabaseAwareTrait` supplies `getDatabase()`. It is meant as a convenience layer for code where constructor dependency injection is awkward (procedural hooks, quick prototypes, base classes) rather than a replacement for proper DI. The module also provides a Drush code generator (`drush generate awareness:trait`, alias `aware`) that scaffolds a new awareness trait for any registered service. There are no routes, permissions, config, entities, or UI; the only runtime dependency is core File (for the `file.repository` trait). Depend on it from your module and `use` the traits you need.

---

- Add `drupal/awareness` as a Composer/module dependency of a custom module to get the traits.
- Give a service or plugin class `$this->getEntityTypeManager()` via `EntityTypeManagerAwareTrait`.
- Run an entity query with `getEntityQuery($type)` (also on `EntityTypeManagerAwareTrait`).
- Read config with `getConfig($name)` and write it with `getEditableConfig($name)` via `ConfigFactoryAwareTrait`.
- Get the current user account with `getCurrentUser()` via `CurrentUserAwareTrait`.
- Make an outbound HTTP request with `getHttpClient()` (Guzzle) via `HttpClientAwareTrait`.
- Build a `ClientFactory` with `getHttpClientFactory()` via `HttpClientFactoryAwareTrait`.
- Access the database connection with `getDatabase()` via `DatabaseAwareTrait`.
- Get a cache bin with `getCacheBin($bin = 'default')` via `CacheFactoryAwareTrait`.
- Use the entity memory cache with `getEntityMemoryCache()` via `EntityMemoryCacheAwareTrait`.
- Queue background work with `getQueueFactory()` / `getQueueWorkerManager()` via the Queue traits.
- Send mail through `getMailPluginManager()` via `MailPluginManagerAwareTrait`.
- Format dates and times with `getDateFormatter()` / `getTime()` via the DateTime traits.
- Render arrays with `getRenderer()` via `RendererAwareTrait`.
- Store per-user data with `getUserData()` via `UserDataAwareTrait` (requires user module).
- Persist scratch data with `getPrivateTempStoreFactory()` / `getSharedTempStoreFactory()`.
- Read runtime settings with `getSettings()` via `SettingsAwareTrait`.
- Read/write key/value stores with `getKeyValueFactory()` / expirable factory traits.
- Manage files with `getFileSystem()`, `getFileUrlGenerator()`, `getFileRepository()`.
- Acquire locks with `getLock()` via `LockAwareTrait`, and dispatch events with `getEventDispatcher()`.
- Replace tokens with `getToken()`, transliterate with `getTransliteration()`, validate email with `getEmailValidator()`.
- Generate UUIDs with `getUuid()` and passwords with `getPasswordGenerator()`.
- Access request context with `getRequestStack()`, `getRouteMatch()`, `getRedirectDestination()`.
- Scaffold a new trait for any service: `drush generate awareness:trait` (alias `drush gen aware`).
- Keep procedural hook implementations tidy by `use`-ing a trait in a helper class instead of scattering `\Drupal::` calls.
