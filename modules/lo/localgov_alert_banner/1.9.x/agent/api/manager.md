<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The manager API and block rendering

## `AlertBannerManager::getCurrentAlertBanners(array $options): array`

The one function to call — the block, and anything else that needs "what is live right now", goes
through it.

```php
$banners = \Drupal::service('localgov_alert_banner.manager')  // service id per localgov_alert_banner.services.yml
  ->getCurrentAlertBanners([
    'type' => ['localgov_alert_banner'],   // bundles; [] (default) = all
    'check_visible' => TRUE,               // default FALSE
  ]);
```

Implementation, in order:

1. Merge with defaults `['type' => [], 'check_visible' => FALSE]`.
2. Query `localgov_alert_banner` storage for `status = 1`.
3. **Sort by `type_of_alert` DESC — only if `FieldStorageConfig::loadByName('localgov_alert_banner', 'type_of_alert')`
   returns something.** A site that deletes that field still works; banners then order by
   `changed` alone.
4. Sort by `changed` DESC.
5. Apply the `type` (bundle) condition when supplied.
6. `->accessCheck(TRUE)->execute()`.
7. For each loaded banner: `entityRepository->getTranslationFromContext()`, then
   `$alert_banner->access('view', $this->account)`.

Design note preserved in the source: *"Visibility check happens separately, so we get cache
contexts on all."* Every published banner is loaded before filtering precisely so its cache
contexts are collected — removing that would produce a block whose cache does not vary correctly
when conditions differ per page.

## `AlertBannerBlock`

Plugin id `localgov_alert_banner_block`. `build()` calls `getCurrentAlertBanners()` with the
bundle filter from block settings, renders the banners, and adds cache invalidation tied to banner
changes. Because the block is context-sensitive, check its cache metadata before adding your own:

```bash
drush php:eval '
$b = \Drupal::service("plugin.manager.block")->createInstance("localgov_alert_banner_block", []);
$build = $b->build();
print_r($build["#cache"] ?? []);'
```

## Storage handler

`AlertBannerEntityStorage` (used as the entity type's storage handler) adds:

| Method | Purpose |
|---|---|
| `revisionIds(AlertBannerEntityInterface $entity)` | All revision ids for a banner |
| `userRevisionIds(AccountInterface $account)` | Revisions authored by a user |
| `countDefaultLanguageRevisions(AlertBannerEntityInterface $entity)` | Revision count in the default language |
| `clearRevisionsLanguage(LanguageInterface $language): int\|null` | Remove revision data for a language (used when a language is deleted) |

```php
$storage = \Drupal::entityTypeManager()->getStorage('localgov_alert_banner');
$ids = $storage->revisionIds($banner);
```

## Other integration points

- `AlertBannerEntityAccessControlHandler` — entity access; per-bundle permissions are consulted
  here.
- `AlertBannerEntityTranslationHandler` — content translation support.
- `AlertBannerEntityHtmlRouteProvider` — the entity's admin routes.
- `AlertBannerEntityListBuilder` / `AlertBannerEntityTypeListBuilder` — admin listings.
- `localgov_alert_banner_gin_content_form_routes()` — declares the banner forms to the Gin admin
  theme so they get the content-form layout.
- `localgov_alert_banner_set_default_permissions()` — applies the default permission set (used on
  install and when new bundles appear).

## Writing your own consumer

```php
// A "is there anything urgent?" check for a custom page or API.
$urgent = array_filter(
  \Drupal::service('localgov_alert_banner.manager')->getCurrentAlertBanners(['check_visible' => TRUE]),
  fn($banner) => $banner->type_of_alert->value === 'major',
);
```

Add the returned entities as cacheable dependencies of whatever you build, or you will serve stale
"no alerts" output during an incident.
