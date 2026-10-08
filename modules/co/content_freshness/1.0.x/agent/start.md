<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Freshness Indicator (content_freshness) — agent index

Renders a **color-coded fresh/aging/stale badge** on a **node's rendered display**, computed
from the node's **last-changed time** (`getChangedTime()`) against configurable day thresholds.
The badge is a **display pseudo-field** placed via Manage display; it appears inline on the node
view, one node at a time. Package `Custom`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
`.info.yml` name **"Content Freshness Indicator"**, installed **1.0.4** (version dir `1.0.x`).

This is a **per-node view-time badge**, **not** a dashboard, report, list, or bulk "content needing
review" query — there is no report route and no cross-node query anywhere in the source.

## Dependencies

- `.info.yml` `dependencies:` — **`drupal:node`** (core) only.
- `composer.json` `require` — only `drupal/core: ^10 || ^11 || ^12`. No third-party PHP/JS library,
  no `key`, no external API.

## What it provides (from source)

- **Service** `content_freshness.calculator` → `src/ContentFreshnessCalculator.php`
  (args `config.factory`, `date.formatter`, `datetime.time`).
  - `calculate(NodeInterface): ?array` — returns `NULL` if the node's bundle is not enabled in
    config. Otherwise computes `days_ago = floor((requestTime - changedTime) / 86400)` and buckets:
    `days_ago <= fresh_days` → `fresh` (Fresh), `<= aging_days` → `aging` (Aging), else `stale`
    (Stale). Adds `time_ago` from `DateFormatter::formatTimeDiffSince(..., granularity 1)` and
    the `show_date` flag. Per-bundle `fresh_days`/`aging_days` override the `defaults`.
  - `buildBadge(NodeInterface): array` — render array `#theme => content_freshness_badge`, attaches
    library `content_freshness/badge`, `#cache` tags = node cache tags + `config:content_freshness.settings`,
    context `timezone`, `max-age 3600`. Empty array if bundle not enabled.
- **Hooks** (`content_freshness.module`):
  - `hook_theme` — theme hook `content_freshness_badge` (template `templates/content-freshness-badge.html.twig`).
  - `hook_entity_extra_field_info` — for each enabled bundle, exposes a **display pseudo-field**
    `content_freshness_badge` on `node` (weight -100, visible).
  - `hook_ENTITY_TYPE_view` (`content_freshness_node_view`) — if the display has the
    `content_freshness_badge` component, calls the calculator and injects the badge into `$build`.
- **Route** — exactly one: `content_freshness.settings` → `GET /admin/config/content/content-freshness`,
  `_form: FreshnessSettingsForm`, requirement **`_permission: 'administer content freshness'`**.
  This is the only route; no controller, no AJAX/mark/dismiss endpoint, no state-changing GET.
- **Settings form** `src/Form/FreshnessSettingsForm.php` (`ConfigFormBase`) — global default
  `fresh_days` (default 30), `aging_days` (default 90), `show_date` (default TRUE); per node-bundle
  enable checkbox + optional `fresh_days`/`aging_days` overrides. `validateForm` enforces
  aging > fresh (global and per enabled bundle). Writes `content_freshness.settings`.
- **Permission** (`content_freshness.permissions.yml`) — `administer content freshness` only.
- **Config** — `config/install/content_freshness.settings.yml` (defaults 30/90, show_date true,
  `enabled_bundles: {}`); schema in `config/schema/`. Menu link + `configure:` point at the settings form.
- **Assets** — CSS-only library `badge` (`css/content-freshness-badge.css`); Twig template renders a
  `<div>` with an ARIA label plus label/relative-time spans. No JS.
- **No** `.install`, **no** `.api.php` (no hooks/events for others to implement), **no** Drush,
  **no** submodules, **no** cross-entity query.

## Notable facts / gotchas

- Freshness is based on the node **`changed`** timestamp (last save), not created/authored date;
  re-saving a node resets it to Fresh regardless of body edits.
- The badge only renders where the node is **already being viewed and rendered** for that viewer
  (via `hook_ENTITY_TYPE_view` on the display), so it inherits normal node-view access — it never
  queries or lists other nodes and exposes no metadata about content the viewer isn't already seeing.
- `show_date` is read from the **global defaults** only (per-bundle overrides cover just the two
  day thresholds).
- Badge output is cached 1h (`max-age 3600`) with the node's cache tags + the settings config tag;
  changing thresholds invalidates it.

## Solution docs

- Prose requirements/config summary: [../usage.md](../usage.md)
- Human setup walk-through (install, thresholds, Manage display placement):
  [../human-docs/index.md](../human-docs/index.md)
