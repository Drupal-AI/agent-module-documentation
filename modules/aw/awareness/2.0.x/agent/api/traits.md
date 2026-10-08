<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Awareness trait catalogue & consumption

Every trait lives under `Drupal\awareness\<Area>\<Name>AwareTrait` (files in `src/<Area>/`). Each adds a `protected` getter that internally calls a static `\Drupal::service('<id>')` or a `\Drupal::` shortcut and returns the service. No constructor, no properties, no config — just a method. This means a class only needs to `use` the trait; nothing is injected or wired.

## Install & consume

1. `composer require drupal/awareness` and enable it (`drush en awareness`). Core File is pulled in as a dependency.
2. In your class add the `use` and call the getter:

```php
use Drupal\awareness\Entity\EntityTypeManagerAwareTrait;

class MyThing {
  use EntityTypeManagerAwareTrait;
  public function load(string $id) {
    return $this->getEntityTypeManager()->getStorage('node')->load($id);
  }
}
```

Because getters are `protected`, traits are for use *inside* a class, not for calling from outside. They wrap `\Drupal::` static calls, so a class using them is still statically coupled to the container (fine for hooks/prototypes; prefer real constructor DI for services you unit-test).

## Trait / method reference

Method names below are the exact getters (verified in `tests/src/Kernel/AwarenessKernelTest.php`).

- `Cache/CacheFactoryAwareTrait` → `getCacheBin($bin = 'default')` (`\Drupal::cache()`).
- `Cache/MemoryCache/EntityMemoryCacheAwareTrait` → `getEntityMemoryCache()`.
- `Config/ConfigFactoryAwareTrait` → `getConfig($name)` (immutable), `getEditableConfig($name)` (`config.factory`->getEditable).
- `Context/ContextRespositoryAwareTrait` → `getContextRepository()` (note the misspelled namespace `Context\ContextRespository...`).
- `Controller/ControllerResolverAwareTrait` → `getControllerResolver()`.
- `Database/DatabaseAwareTrait` → `getDatabase()` (`\Drupal::database()`).
- `DateTime/DateFormatterAwareTrait` → `getDateFormatter()`; `DateTime/TimeAwareTrait` → `getTime()`.
- `Entity/EntityFieldManagerAwareTrait` → `getEntityFieldManager()`.
- `Entity/EntityFormBuilderAwareTrait` → `getEntityFormBuilder()`.
- `Entity/EntityRepositoryAwareTrait` → `getEntityRepository()`.
- `Entity/EntityTypeBundleInfoAwareTrait` → `getEntityTypeBundleInfo()`.
- `Entity/EntityTypeManagerAwareTrait` → `getEntityTypeManager()`, `getEntityQuery($entity_type, $conjunction = 'AND')`.
- `Event/EventDispatcherAwareTrait` → `getEventDispatcher()`.
- `Extension/ModuleHandlerAwareTrait` → `getModuleHandler()`; `Extension/ThemeManagerAwareTrait` → `getThemeManager()`.
- `File/FileRepositoryAwareTrait` → `getFileRepository()` (`file.repository`; needs core File).
- `File/FileSystemAwareTrait` → `getFileSystem()`; `File/FileUrlGeneratorAwareTrait` → `getFileUrlGenerator()`.
- `Form/FormBuilderAwareTrait` → `getFormBuilder()`.
- `Http/HttpClientAwareTrait` → `getHttpClient()` (Guzzle client); `Http/HttpClientFactoryAwareTrait` → `getHttpClientFactory()` (`ClientFactory`).
- `KeyValue/KeyValueFactoryAwareTrait` → `getKeyValueFactory()`; `KeyValue/KeyValueExpirableFactoryAwareTrait` → `getKeyValyeExpirableFactory()` (method name is misspelled "Valye" — call it exactly).
- `Layout/LayoutPluginManagerAwareTrait` → `getLayoutPluginManager()` (needs `layout_discovery`).
- `Lock/LockAwareTrait` → `getLock()`.
- `Mail/MailPluginManagerAwareTrait` → `getMailPluginManager()`.
- `Mime/FileMimeTypeGuesserAwareTrait` → `getFileMimeTypeGuesser()`.
- `Pager/PagerManagerAwareTrait` → `getPagerManager()`.
- `Password/PasswordGeneratorAwareTrait` → `getPasswordGenerator()`.
- `Queue/QueueFactoryAwareTrait` → `getQueueFactory()`; `Queue/QueueWorkerManagerAwareTrait` → `getQueueWorkerManager()`.
- `Render/RendererAwareTrait` → `getRenderer()`.
- `Request/RequestStackAwareTrait` → `getRequestStack()`.
- `Routing/RedirectDestinationAwareTrait` → `getRedirectDestination()`; `Routing/RouteMatchAwareTrait` → `getRouteMatch()`.
- `Session/CurrentUserAwareTrait` → `getCurrentUser()`.
- `Settings/SettingsAwareTrait` → `getSettings()`.
- `State/StateAwareTrait` → `getState()`.
- `StreamWrapper/StreamWrapperManagerAwareTrait` → `getStreamWrapperManager()`.
- `TempStore/PrivateTempStoreFactoryAwareTrait` → `getPrivateTempStoreFactory()`; `TempStore/SharedTempStoreFactoryTrait` → `getSharedTempStoreFactory()` (note: trait name has no "Aware").
- `Token/TokenAwareTrait` → `getToken()`.
- `Transliteration/TransliterationAwareTrait` → `getTransliteration()`.
- `User/UserDataAwareTrait` → `getUserData()` (needs core User).
- `Utility/EmailValidatorAwareTrait` → `getEmailValidator()`.
- `Uuid/UuidAwareTrait` → `getUuid()`.

Gotchas: two identifiers are misspelled in the source and you must match them verbatim — the `Context\ContextRespository...` namespace and the `getKeyValyeExpirableFactory()` method. `SharedTempStoreFactoryTrait` breaks the `*AwareTrait` naming convention.
