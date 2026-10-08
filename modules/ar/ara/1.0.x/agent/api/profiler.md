<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ARA — how profiling works (architecture)

The profiler is a **decorator over core's `renderer` service** plus three collaborators. No plugin
type, no events, no external calls — everything happens inside the render path.

## Wiring: `AraServiceProvider`

`src/AraServiceProvider.php` (`alter()`): if the container defines `renderer`, it reclasses that
definition to `Drupal\ara\ProfilingRenderer` and adds three method calls —
`setRunSettings(@ara.run_settings)`, `setTracer(@ara.tracer)`, `setLogger(@ara.logger)`. Setter
injection is used because the parent `Renderer` constructor signature is fixed by core. All three
setter targets are nullable; if the container is half-built the decorator falls back to plain
rendering.

## `ProfilingRenderer::doRender()` (the hot path)

`src/ProfilingRenderer.php` extends `Drupal\Core\Render\Renderer`. Each call:

1. **Gate**: if `runSettings === NULL || !isActive()`, or tracer/logger are NULL, return
   `parent::doRender()` immediately (one boolean check when inactive).
2. Call `runSettings->markActive()` (latches "panel should render this request").
3. Pause the parent element's timer, `tracer->incrementCount()` (monotonic id), read current
   count/depth.
4. If `#cache` present: log `cache_start`; for `tags` and `contexts`, record which descendant
   count "originated" each lineitem against every ancestor in the trace (`cache_trace`) — this is
   what powers the click-through-to-origin links in the panel.
5. `classifyElement()` derives `[type, subtype, annotate]` (see below).
6. **Per-element query capture** via core `Database::startLog("ara:<count>")` /
   `Database::getLog(...)`. Keys are tracked in `$startedLogKeys` and only read once (getLog both
   reads and closes); a parent's log is closed before descending and reopened after — so each
   element's `queries` are exactly the SQL run during its own subtree boundary.
7. **Exclusive timing**: `startTimer`/`stopTimer` with `microtime(TRUE)` accumulate per-count
   elapsed seconds, pausing the parent while a child renders, so `time` is self-time (ms).
8. `parent::doRender()` produces the element's HTML.
9. Log the full entry: `count, last_child, trace, depth, type, subtype, time, annotated`, plus
   `cache_end`.
10. If annotating, wrap the output (see annotations) and return.

Timer/log bookkeeping is BigPipe-aware: each streamed placeholder is its own `renderRoot()` pass,
so the renderer only reads DB log keys it actually opened in the current pass (comment in source).

## `Tracer` (`src/Tracer.php`)

Plain in-memory state: a monotonic `count`, current `depth`, and a `trace` stack of ancestor
counts. `incrementCount()`, `descend()`/`ascend()` (push/pop the count and adjust depth),
`getCount()/getDepth()/getTrace()`. This is how ARA reconstructs the render tree and computes
indentation.

## `ProfileRunSettings` (`src/ProfileRunSettings.php`)

Resolves activation and exposes run options. **Driven only by config + permission**, never by
query params.

- `isActive()`: FALSE if `stopped`; FALSE on admin routes (`AdminContext::isAdminRoute()`, memoized);
  FALSE if config `enabled` is falsy (memoized); else
  `currentUser->hasPermission('use ara profiler')`. Activation is **recomputed each call** (not
  fully memoized) so an `AccountSwitcher` mid-request cannot lock in a stale permission state.
- `wasActive()`/`markActive()`: sticky latch so the panel still renders in `page_bottom` even if a
  late account switch flips `isActive()` to FALSE.
- `isShowingAnnotations()`, `getAnnotationThreshold()`: read the other two config keys.
- `stop()`: sets the sticky `stopped` flag; called by the panel builder so the panel does not
  profile its own subtree. `reset()` clears per-request state (tests/container lifecycle).

## `ProfilerLogger` (`src/ProfilerLogger.php`)

Implements `TrustedCallbackInterface`. Collects entries keyed by render count (`log()` deep-merges
fragments: pure lists concatenate, maps merge last-writer-wins). Builds the panel:

- `buildResultsPanel()` (the trusted lazy-builder callback): grabs entries, calls
  `runSettings->stop()`, returns a `#theme => 'ara_results'` render array (`#results` table,
  `#summary`, library `ara/profiler`, `max-age 0`) — or `[]` if nothing captured.
- `buildSummary()`: aggregates render_count, total top-level render time, total queries + query
  time, max depth, and the slowest element.
- `buildResultsTable()`: a `#type => table`, one row per entry (skips `(cache metadata)` rows),
  indented by depth, with severity class, query totals (`formatQueryTime`), and cache tag/context
  detail cells (`buildCacheDetails`, `#type => details` with `item_list` links to `#ara-row-<id>`).

`getEntries()` returns only entries with a non-empty `time`, sorted by count.

## Classification & annotations (`ProfilingRenderer`)

`classifyElement()` maps a render array to a human `type`/`subtype`: `#type`/`#theme`, with special
subtypes for `block` (`#plugin_id`), `field` (`#field_name`), `form` (`#form_id`), `html_tag`
(`#tag`), `node`/`paragraph` (bundle), `view` (`id:display_id`), and placed blocks rendered via
`BlockViewBuilder::lazyBuilder` (surfaced as `block` keyed by the placed-block id). Raw-text tags,
`markup`, `contextual_links_placeholder`, and untyped/lazy/attached/cache-only arrays are not
annotated.

When annotation applies and `display_annotations` is on, a `<div class="ara-annotation
<severity>">` badge (render time + escaped `type: subtype` label) is built and inserted by
`injectAnnotation()` as the **first child of the output's root tag** — never inside void tags
(prepended as a sibling) and never inside raw-text tags like `<script>/<style>` (left untouched, to
avoid corrupting the `drupal-settings-json` / BigPipe payloads). Below-threshold badges are emitted
with a `hidden` attribute (JS toggles them). Severity bands come from `Severity::fromTimeMs()`
(`src/Enum/Severity.php`): low `<10ms`, medium `≥10`, high `≥50`, critical `≥200`.

## Hooks (`src/Hook/AraHooks.php`)

Attribute-based `#[Hook]`, with `#[LegacyHook]` procedural shims in `ara.module` for Drupal 10.

- `page_attachments`: attach `ara/profiler` library when the run was/is active.
- `page_bottom`: attach the results panel as a **`#lazy_builder` placeholder**
  (`ara.logger:buildResultsPanel`, `#create_placeholder => TRUE`, `max-age 0`) so it builds last,
  after all blocks and BigPipe fragments. On non-cacheable requests (e.g. a non-redirecting POST)
  core does not placeholder, so the builder runs inline and captures only the main content tree.
- `theme`: defines `ara_results` and `ara_cache_details` templates.
- `help`: the `help.page.ara` HTML.

## Front-end

Library `ara/profiler` (`ara.libraries.yml`, depends `core/drupal`): `js/ara.js` drives panel
filter/threshold controls, row highlighting and annotation visibility; `css/ara.css` styles the
panel, badges and severity colors. Templates render the summary bar and expandable cache-detail
lists.
