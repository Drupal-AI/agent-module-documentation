<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Render Auditor is a local-development render-tree profiler that decorates Drupal's core renderer to time every rendered element, capture its database queries and bubbled cache metadata, and surface it all in a floating results panel (with optional inline timing badges).

---

Advanced Render Auditor (ara) swaps the core `renderer` service for a profiling decorator (`ProfilingRenderer`) that instruments every `doRender()` call while a run is active. For each rendered element it records exclusive render time, the SQL queries executed during that element, and the `#cache` keys/tags/contexts it declares — then builds a deferred results panel at the bottom of the page showing a summary bar (total render time, query count/time, max depth, slowest element), one color-coded row per element indented by tree depth, per-row query totals, and expandable cache tag/context details that link back to the element each inherited tag came from. Optionally it prepends a small severity-colored badge (render time + type/name) to each element on the page, including placed blocks and BigPipe-streamed content. Profiling only runs when the `ara.settings.enabled` flag is on AND the current user has the restricted `use ara profiler` permission; it is skipped on admin routes and short-circuits with a single boolean check when inactive. It is strictly a local-development tool — a `hook_requirements()` warning flags it on the Status Report whenever it is left enabled. Requires only core `system`; supports Drupal 10 and 11.

---

- Profile the render tree of a page to see exactly what elements were rendered and in what order.
- Measure the exclusive (self) render time of every render element on a page.
- Identify the single slowest rendered element via the summary bar's "slowest" metric.
- See how many database queries each render element triggered, and their total time.
- Track total page render time, total query count, and total query time at a glance.
- Inspect the bubbled cache tags each element declares in its `#cache` metadata.
- Inspect the bubbled cache contexts each element declares.
- Trace an inherited cache tag/context up to the descendant element that originated it (click-through link).
- Spot slow blocks by their placed-block id (rendered via BigPipe lazy builders).
- Spot slow fields by field name, views by view id:display, forms by form id, nodes/paragraphs by bundle.
- Overlay inline timing badges directly on page elements to see cost in context.
- Hide fast annotations below a configurable millisecond threshold to focus on hotspots.
- Use severity color bands (low/medium/high/critical) to triage render cost visually.
- Debug why a page is slow to render without an external profiler like XHProf.
- Debug cache metadata bubbling and unexpected cache-context explosions.
- Verify that a render-caching change actually reduced query counts on a given element.
- Restrict profiler visibility to specific roles via the `use ara profiler` permission.
- Keep the profiler off in shared/production environments (Status Report warning reminds you).
- Profile the render tree of BigPipe-streamed and lazy-built content on cacheable GET requests.
- Toggle profiling site-wide from `/admin/config/development/ara` without code changes.
- Add developer render insight to a Drupal 10 or Drupal 11 local site with no contrib dependencies.
