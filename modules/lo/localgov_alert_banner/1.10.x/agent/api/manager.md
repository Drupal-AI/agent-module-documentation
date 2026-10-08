<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The manager API and block rendering

## `AlertBannerManager::getCurrentAlertBanners(array $options): array`

The one function to call — the block, and anything else that needs "what is live right now", goes
through it. Service id `localgov_alert_banner.manager`
(`src/AlertBannerManager.php`, injects `entity_type.manager`, `current_user`, `entity.repository`).

```php
$banners = \Drupal::service('localgov_alert_banner.manager')
  ->getCurrentAlertBanners([
    'type' => ['localgov_alert_banner'],   // bundles; [] (default) = all
    'check_visible' => TRUE,               // default FALSE
  ]);
```

Implementation, in order:

1. Merge with defaults `['type' => [], 'check_visible' => FALSE]`.
2. Query `localgov_alert_banner` storage for `status = 1` (published only — unpublished banners are
   never returned).
3. **Sort by `type_of_alert` DESC — only if `FieldStorageConfig::loadByName('localgov_alert_banner', 'type_of_alert')`
   returns something.** A site that deletes that field still works; banners then order by
   `changed` alone.
4. Sort by `changed` DESC.
5. Apply the `type` (bundle) condition when supplied.
6. `->accessCheck(TRUE)->execute()`.
7. For each loaded banner: `entityRepository->getTranslationFromContext()`, then an explicit
   `$alert_banner->access('view', $this->account)` check.
8. If `check_visible` is TRUE, `array_filter()` on `$alert_banner->isVisible()` (the
   `condition_field` evaluation).

Design note preserved in the source: *"Visibility check happens separately, so we get cache
contexts on all."* Every published banner is loaded before the visibility filter precisely so its
cache contexts are collected — removing that would produce a block whose cache does not vary
correctly when conditions differ per page.

## `AlertBannerBlock`

Plugin id `localgov_alert_banner_block` (`src/Plugin/Block/AlertBannerBlock.php`). `build()` calls
`getCurrentAlertBanners()` with `check_visible => TRUE` and the bundle filter from block settings
(`include_types` checkboxes), renders each banner via the entity view builder, and returns NULL
(block hidden) when none are live. `getCacheContexts()` merges the contexts of every current banner
(with `check_visible => FALSE`); `getCacheTags()` adds `localgov_alert_banner_list`. The constructor
carries a deprecated-signature shim (`DeprecatedServicePropertyTrait`) for the pre-1.8 `$current_user`
/ `$entity_repository` arguments; new code uses the two-arg `create()`
(`entity_type.manager` + `localgov_alert_banner.manager`).

```bash
drush php:eval '
$b = \Drupal::service("plugin.manager.block")->createInstance("localgov_alert_banner_block", []);
$build = $b->build();
print_r($build["#cache"] ?? []);'
```

## The dismiss token and `alert_banner.js`

Each published banner carries a per-entity `token` base field (`sha1(uniqid())`, regenerated in
`AlertBannerEntity::preSave()` whenever the banner is published). It is rendered into the banner
markup as `data-dismiss-alert-token` and used by `js/alert_banner.js` purely client-side: clicking
*Hide* stores the token in the `hide-alert-banner-token` cookie so the banner stays dismissed until
its content changes (a new token). It is a dismissal marker, not an authentication credential. The
token is also mixed into the entity cache tags (`localgov.alert.banner.token:<token>`).

## Storage handler

`AlertBannerEntityStorage` (`src/AlertBannerEntityStorage.php`,
implements `AlertBannerEntityStorageInterface`) adds revision helpers:

| Method | Purpose |
|---|---|
| `revisionIds(AlertBannerEntityInterface $entity)` | All revision ids for a banner |
| `userRevisionIds(AccountInterface $account)` | Revisions authored by a user |
| `countDefaultLanguageRevisions(AlertBannerEntityInterface $entity)` | Revision count in the default language |
| `clearRevisionsLanguage(LanguageInterface $language)` | Remove revision data for a language (used when a language is deleted) |

```php
$storage = \Drupal::entityTypeManager()->getStorage('localgov_alert_banner');
$ids = $storage->revisionIds($banner);
```

## Other integration points

- `AlertBannerEntityAccessControlHandler` — entity access; per-bundle permissions are consulted
  here (see [../permissions/permissions.md](../permissions/permissions.md)).
- `AlertBannerEntityTranslationHandler` — content translation support.
- `AlertBannerEntityHtmlRouteProvider` — adds the entity's `status_form` and `collection` routes on
  top of the admin route provider.
- `AlertBannerEntityListBuilder` / `AlertBannerEntityTypeListBuilder` — admin listings.
- `Plugin/views/field/StatusPageLink` — a Views field linking to a banner's status form.
- `Hook\GinHooks::ginContentFormRoutes()` — declares the banner forms to the Gin admin theme so
  they get the content-form layout.
- `ModuleHooks::modulesInstalled()` → `localgov_alert_banner_configure_scheduled_transitions()` when
  Scheduled Transitions is installed later.

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
