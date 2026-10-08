<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consumers & integrations

Every audience-reading integration goes through `entity_segment.audience_access` (raw = permission-gated, filtered = viewer-safe). Contrib integrations are optional and inert until their module is installed.

## Views (hard dep on core Views)

- `Hook/ViewsHooks::viewsDataAlter()` registers a `segment_audience` pseudo-field on each **target** type's Views base/data table (only for the distinct target types of defined segment types).
- Filter `Plugin/views/filter/SegmentAudience` (`entity_segment_audience`): options `segment` + `mode` (`filtered` default / `raw`). Not exposable (`canExpose()` = FALSE). `query()` fetches audience IDs via `AudienceAccess` and adds `IN (ids)` on the target's ID column; an empty/denied audience becomes `1 = 0` (no rows). `segmentOptions()` offers only segments whose target matches the View's base.

## Tokens

`Hook/TokenHooks` declares a `segment` token type. Metadata tokens: `id`, `label`, `scope`, `target-type`, `owner` (chained user), `url`, `created`, `changed`. Audience tokens make the access split explicit:
- `[segment:member-count]` / `[segment:members]` — **filtered**; bubbles `user` cache context.
- `[segment:raw-member-count]` / `[segment:raw-members]` — **raw**, membership-permission gated (0/empty without it); bubbles `user.permissions`. Member lists bounded to 50 IDs (`MEMBERS_LIMIT`).

## ECA (optional `eca`)

- Condition `Plugin/ECA/Condition/EntityIsInSegment` (`entity_segment_entity_is_in_segment`): config `segment_id` + `mode`; reads the `entity` context, returns FALSE if the entity type ≠ the segment's target, else tests membership via `AudienceAccess`.
- Action `Plugin/Action/ResolveSegment` (`entity_segment_resolve_segment`): resolves an audience (raw/filtered) into a named ECA token.

## Views Bulk Operations (optional `views_bulk_operations`)

Action `Plugin/Action/SetSegmentScope` (`entity_segment_set_segment_scope`, deriver `SetSegmentScopeDeriver` → set global / set personal). `execute()` writes `scope` and saves (new revision); `access()` defers wholly to the segment's `update` access, so bulk edits respect the scope model. `config/optional/views.view.segment_bulk.yml` ships an optional admin View. `Plugin/Action/ResolveSegment` is also VBO/ECA-discoverable.

## Diff (optional `diff`)

`Plugin/diff/Field/ConditionTreeFieldBuilder` renders human-readable, target-aware line diffs of the `conditions` field between segment revisions (schema `entity_segment.views.schema.yml` + `entity_segment.schema.yml`).

## JSON:API (optional core `jsonapi`)

`Controller/SegmentJsonApiController` adds resolved-membership endpoints (routes register only when `jsonapi` is installed via `_module_dependencies: jsonapi`; both `_access: TRUE`, gated in code):
- `GET /jsonapi/segment/{segment}/resolved-members` → `filtered()` — only members the requester may view.
- `GET /jsonapi/segment/{segment}/resolved-members/raw` → `raw()` — `rawAllowed()` else **403** (so a denial is distinguishable from a genuinely empty audience). Payload = JSON:API resource identifier objects (`{type, id:uuid}`) plus a `meta.count`.

## Other services

- `entity_segment.target_type_provider` (`SegmentTargetTypeProvider`) — enumerates queryable content entity types eligible as segment targets.
- `SegmentHtmlRouteProvider`, `SegmentCollectionController` (per-type listing `byType()`), local actions `AddSegment` / `AddSegmentToType`, and CSS/JS libraries (`condition_builder`, `conditions`, `list_filter`) back the admin UI.
