<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, PerzHelper API & hooks

## Services (`acquia_perz.services.yml`)

- `acquia_perz.entity_helper` (`EntityHelper`) — entity eligibility (`isValidEntity`,
  `isEligibleForExport`) and render/build helpers.
- `acquia_perz.client_factory` (`ClientFactory`) — builds the CIS HTTP client from the Acquia
  Connector subscription; `pushEntity()`, `getEntities()`, `deleteContentFromCis()`,
  `deleteAllContentsFromCis()`.
- `acquia_perz.service.context.page_context` (`Service\Context\PageContext`) and
  `acquia_perz.service.context.path_context` (`PathContext`) — build the personalization page/path
  metadata attached to responses; `PathContext::shouldAttach()` enforces `visibility.path_patterns`.
- `acquia_perz.service.helper.path_matcher` (`Service\Helper\PathMatcher`).
- `acquia_perz.entity_settings` / `acquia_perz.cis_settings` — factory aliases for the two config
  objects.
- Event subscribers: `PerzProductSettings`, `AcquiaSubscriptionData\AcquiaPerzData` (feed Perz data
  into the Acquia Connector subscription/product settings).

## `PerzHelper` (static utility, `src/PerzHelper.php`)

- `getSiteId()` — from `acquia_perz.settings:api.site_id`, falling back to `acquia_lift` credentials.
- `getSiteHash()` / `createSiteHash()` — 6-char hash in state key `acquia_perz.site_hash`.
- `getAccountId()` — from the Acquia subscription data (`acquia_connector.subscription`).
- `getRegions()` / `getRegionEndpoint($region)` — region label map and CIS endpoint URL.
- `getViewModeMinimalHtml($entity, $view_mode, $langcode)` — renders an entity (special-casing
  `block_content`) for export.
- `runDecisionWebhook($entity)` — fired by the main module's entity insert/update/delete hooks;
  **no-op when `acquia_perz_push` is enabled** (the submodule handles export instead) or when the
  entity is not valid / no decision endpoint is set.
- `attachLibrariesForPerz()` / `saveLibrariesForPerz()` / `clearLibrariesFromState()` — manage the
  per-element JS libraries kept in state key `acquia_perz.libraries`.
- `shouldOverrideLiftSettings()` / `migrateSiteId()` — acquia_lift interop.

## Hooks the module implements (not hooks it invites)

`acquia_perz.module` implements `hook_entity_insert/update/delete`,
`hook_entity_translation_delete` (→ `runDecisionWebhook`),
`hook_form_entity_view_display_edit_form_alter` (the personalization opt-in section), and
`hook_page_attachments_alter` (attaches the `acquia_perz/acquia_perz` library + context when
`advanced.dynamic_js_support` is on and the path passes the visibility filter).

The module defines **no plugin types, no Drush commands, and no hooks of its own** — content export
Drush lives in `acquia_perz_push`.
