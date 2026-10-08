<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `changelogify_release` entity, workflow & access

Content entity defined in `src/Entity/ChangelogifyRelease.php` (`#[ContentEntityType]`). Revisionable, translatable, `show_revision_ui = TRUE`, `admin_permission = "manage changelogify releases"`. Owner (`uid`) + revision-log traits. Admin routes under `/admin/content/changelogify/releases/*` (AdminHtmlRouteProvider + RevisionHtmlRouteProvider). Form: `Form\ReleaseForm`; view builder: `ChangelogifyReleaseViewBuilder`; list builder: `ReleaseListBuilder`.

## Notable fields
- `title` (string, required, translatable), `version` (string), `label_type` (list: `date_range`/`custom`/`semantic_version`).
- `slug` (string ≤128, translatable) + `slug_history` (unlimited) — public URL segments; `setSlugHistory()` validates each against `^[a-z][a-z0-9-]{0,127}$`.
- `release_date`, `date_start`, `date_end` (timestamps) — release date + covered change window.
- `sections` (string_long JSON, default `{}`) — items bucketed into `added/changed/fixed/removed/security/other`. `getSections()`/`setSections()` JSON-encode and strictly validate each item `{id (non-empty string), text (non-empty trimmed string), event_ids (array)}`; unknown sections rejected.
- `provenance` (string_long JSON) — privacy-bounded evidence. `setProvenance()` heavily validates version (1|2), allowed top-level keys, per-item allowed keys, ≤200 event snapshots, synthesis coverage internal consistency, and 64-hex synthesis `job_id`.
- `status` (bool published), `editorial_state` (list: `draft`/`review`/`published`/`archived`).
- `scheduled_at`, `scheduled_revision_id` — for `ScheduledPublicationManager`.

## Editorial workflow
`editorial_state` is the authority; `preSave()`/`setEditorialState()`/`setPublished()` keep `status` == (`editorial_state === 'published'`). Every non-new save forces a new revision (`preSave`), auto-writing a revision-log message describing state transitions. `postSave()` dispatches `Event\ReleasePublishedEvent` (idempotency key `changelogify:publication:{uuid}:{lang}:{revisionId}`) only when a default revision becomes published.

Workflow permissions (`changelogify.permissions.yml`): `manage changelogify releases` (CRUD), `submit … for review`, `publish …`, `archive …`, plus `view/revert … revisions`.

## Access (`Access\ChangelogifyReleaseAccessControlHandler`)
- `view all revisions`/`view revision` → `view changelogify release revisions`; `revert` → `revert changelogify release revisions`.
- Holders of `manage changelogify releases` get full access.
- Otherwise `view`/`view label` allowed only if the entity **isPublished()** AND account has `view changelogify releases` — this is what keeps unpublished drafts out of all public output (listing, detail, feeds, API all `accessCheck(TRUE)` + `->access('view')`).
- Create → `manage changelogify releases`. Default = forbidden.

Note: `Routing\RouteSubscriber` also tightens the entity canonical route (`entity.changelogify_release.canonical`) to require `manage changelogify releases`.

## Generation
`ReleaseGenerator` (`ReleaseGeneratorInterface`): `previewRange()`/`previewSinceLast()` build a `ReleasePreview` (change sets + coverage) without saving; `generateReleaseFromRange()` creates a draft release (cap `MAX_EVENTS_PER_RELEASE = 5000`). Driven by `Form\GenerateReleaseForm` (route `changelogify.generate_release`, permission `manage changelogify releases`). `ReleaseItemNormalizer` converts editor text ↔ structured items while preserving item ids and source `event_ids`.
