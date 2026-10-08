<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visibility: conditions, Views filter, Twig, tokens, cache

All read through `@mautic_audiences.resolver`. An empty configuration means "no constraint" (evaluates TRUE / leaves the query untouched); negation on conditions is handled by the core condition base.

## Block / Layout Builder conditions (`src/Plugin/Condition/`)
- `mautic_segment` — `MauticSegment`, label "Mautic segment". Textarea of aliases (one per line) + `mode` (`any`/`all`).
- `mautic_tag` — `MauticTag`, label "Mautic tag". Same shape, over tag values (e.g. `coupon:SUMMER-20`).

Plain `ConditionInterface` plugins with no required context, so they appear on classic block placement, in Layout Builder section/inline-block visibility, and anywhere else that honors condition plugins. `evaluate()` checks the resolver's audience; `getCacheContexts()` bubbles one narrow `mautic_audience.segment:<alias>` / `mautic_audience.tag:<value>` per configured name; `getCacheTags()` adds `mautic_audience:contact:<id>`.

## Global Views filter
`VisitorAudienceMatch` (`src/Plugin/views/filter/`, id `mautic_audiences_visitor_match`, registered by `MauticAudiencesViewsHooks::viewsData()` under group "Mautic Audiences"). Not exposable (`canExpose()` = FALSE); options `segments`, `tags`, `mode`. In `query()`, when the visitor does not match it appends `1 = 0` to the SQL query so the whole view returns zero rows (SQL backends only). Bubbles the same narrow contexts as the conditions.

## Twig functions (`src/Twig/AudiencesExtension.php`, service `mautic_audiences.twig_extension`)
- `is_in_segment(names, mode='any')` → bool.
- `has_tag(names, mode='any')` → bool.
- `current_audiences()` → the `AudiencesValue` (bubbles the broad `mautic_audience` context).

`names` accepts a string, a list, or a `FieldItemListInterface` (pass an audience field directly). Each call bubbles its cache metadata into the active render context via the renderer, so a scalar-returning template branch still fragments the render cache correctly. An empty field/string/list = "no constraint" → TRUE; a non-empty field whose items yield no usable names → FALSE (fail-safe against gating on the wrong field).

## Tokens (`src/Hook/MauticAudiencesTokensHooks.php`)
- Boolean, any name, no allowlist: `[mautic-audience:in-segment-<alias>]` and `[mautic-audience:has-tag-<value>]` → `"1"` or `""`. Dynamic-suffix tokens for known names are registered from `SegmentList`.
- Joined string, allowlist-filtered: `[current-user:mautic-segments]` / `[current-user:mautic-tags]` → comma-joined names, filtered by `exposed_segments` / `exposed_tag_prefixes` (empty by default → empty string). Suitable for metatag patterns.

Token replacements bubble the matching cache contexts/tags into `BubbleableMetadata`.

## Cache contexts (`src/Cache/Context/`, services `cache_context.mautic_audience[.segment|.tag]`)
- `mautic_audience` — broad; value is `AudiencesValue::hash()`. Registered as a high-cardinality auto-placeholder context by `MauticAudiencesServiceProvider` (merged into `renderer.config:auto_placeholder_conditions.contexts`).
- `mautic_audience.segment:<alias>` / `mautic_audience.tag:<value>` — narrow calculated contexts returning `"1"`/`""` (two variants per name).

Each context declares an anonymous audience-varying response private to its visitor via `PrivateToVisitorTrait` + the `DenyAudienceVaryingResponse` page-cache response policy (`src/PageCache/`), keeping such responses out of the Internal Page Cache while the Dynamic Page Cache holds one variant per audience answer. All contexts add `mautic_audience:contact:<id>` as a cache tag for webhook-driven invalidation.
