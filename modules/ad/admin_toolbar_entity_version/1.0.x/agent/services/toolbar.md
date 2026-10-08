<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Toolbar tab, version inspector and template

## Install & enable

```bash
composer require drupal/admin_toolbar_entity_version
drush en admin_toolbar_entity_version -y
drush cr
```

Only hard dependency is core **`toolbar`**. If **`content_moderation`** is enabled the tab shows workflow
state labels; the inspector injects it as an optional service (`@?content_moderation.moderation_information`)
so it also works without it. Nothing to configure — no settings, no permissions of its own. The tab is only
rendered for users with core's **`access toolbar`** permission (Toolbar's own requirement).

## The Toolbar tab (`hook_toolbar` in `.module`)

`admin_toolbar_entity_version_toolbar()` returns item `admin_toolbar_entity_version`:

- `tab.entity_version` = a **`#lazy_builder`** → `AdminToolbarEntityVersionBuilder::build` (empty args),
  `#create_placeholder => TRUE` (BigPipe/placeholdered so it is computed per-request, not cached with the page).
- `#weight => 1010`, `#wrapper_attributes.class = ['admin-toolbar-entity-version-tab']`.
- `#attached.library = ['admin_toolbar_entity_version/toolbar.item']` → `css/admin-toolbar-entity-version.css`
  (defined in `admin_toolbar_entity_version.libraries.yml`).

## The lazy builder — `src/AdminToolbarEntityVersionBuilder.php`

`final class AdminToolbarEntityVersionBuilder implements ContainerInjectionInterface, TrustedCallbackInterface`.
Constructed via `create()` with `current_route_match`, `entity_type.manager`,
`admin_toolbar_entity_version.inspector`. `trustedCallbacks()` returns `['build']` (required for the lazy
builder).

`build()`:

1. `getEntity()` — returns `NULL` unless the current route name matches
   `/^entity\.(.*)\.(canonical|latest_version|revision)$/`. For a `revision` route it loads the
   `{type}_revision` parameter (or `loadRevision()`); otherwise the `{type}` route parameter. Only a
   `RevisionableInterface` is returned (else `NULL` → empty tab).
2. `version_history_url` = `entity->toUrl('version-history')` **only if** the link template exists **and**
   `->access()` passes; otherwise `NULL`.
3. Returns:
   ```php
   [
     '#theme' => 'admin_toolbar_entity_version',
     '#current_version' => $inspector->getCurrentVersion($entity),   // default|latest|revision
     '#versions' => $inspector->getVersions($entity),
     '#version_history_url' => $version_history_url,
   ]
   ```

## The inspector — `src/EntityVersionInspector.php`

Service `admin_toolbar_entity_version.inspector` (`@entity.repository`,
`@?content_moderation.moderation_information`, `@date.formatter`). Constants `VERSION_DEFAULT='default'`,
`VERSION_LATEST='latest'`, `VERSION_REVISION='revision'`.

- `getCurrentVersion($entity)` → `default` if `isDefaultRevision()`, else `latest` if `isLatestRevision()`,
  else `revision`.
- `getVersions($entity)` builds an ordered array:
  - `default` — the canonical revision (`entityRepository->getCanonical()`), label *"Canonical"*, rel
    `canonical`.
  - `latest` — added only when the latest revision (`entityRepository->getActive()`) differs from canonical;
    label *"Latest revision"*, rel `latest-version`.
  - `revision` — added only when the viewed entity is neither default nor latest; label *"Old revision"*,
    rel `revision`.
  - Each entry (`buildVersion()`): `label`, `url` (`toUrl($rel)` if link template exists else `NULL`),
    `published` (`isPublished()` for `EntityPublishedInterface`, else TRUE), `status`, `created`
    (`RevisionLogInterface::getRevisionCreationTime()` or NULL), `created_time_ago`
    (`dateFormatter->formatTimeDiffSince()`).
- `getVersionStatus()` — moderation-state label when the entity is moderated
  (`moderationInformation->isModeratedEntity()` → workflow `getState($state_id)->label()`); else
  Published/Unpublished for `EntityPublishedInterface`; else Published/Latest/Revision fallbacks.

## The template — `templates/admin-toolbar-entity-version.html.twig`

A `<details>` drawer, BEM block `admin-toolbar-entity-version`:

- `<summary>` shows the current version's `status` (or literal *"Revision"* for a revision view); gets the
  `--unpublished` modifier class when `versions[current_version].published` is false (styled yellow in CSS).
- Lists each version with its label, a *Current* marker or a *View* link (`version.url`), and a property
  list of `status` and `created` (`<time>` with `format('c')` / `format_date('short')` and the
  "@time ago" string).
- Renders the `version_history_url` *"View version history"* link when present.
- All dynamic values (`status`, `label`, `url`, timestamps) go through Twig autoescaping; URLs are core
  `Url` objects.

## Hiding the redundant core tab — `hook_menu_local_tasks_alter()`

`admin_toolbar_entity_version_menu_local_tasks_alter(&$data, $route_name)` targets
`entity.node.canonical` / `entity.node.latest_version`. If the core
`content_moderation.workflows:node.latest_version_tab` local task is present it is `unset()` — **except**
when the user lacks `access toolbar`, the route is an admin route
(`router.admin_context->isAdminRoute()`), or the active theme is the site admin theme. Net effect: on
front-end renders where the Toolbar tab already conveys latest-version status, the duplicate core tab is
removed; admin renders keep it.

## Operating notes

- The tab only appears on entity canonical/latest-version/revision routes for a revisionable entity, and
  only for Toolbar users. On any other route the lazy builder returns `[]` (empty tab).
- The `version-history` link is access-checked before it is shown; the per-version *View* links target core
  entity routes whose own access still applies when followed.
- Because the tab is a placeholdered lazy builder, it reflects the entity for the current request rather
  than a cached page fragment.
