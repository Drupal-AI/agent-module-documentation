<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON insight API

`src/Controller/InsightApiController.php` (service dep `content_telemetry.insight_service`). Two
GET endpoints, both requiring **`view content telemetry`** and marked `no_cache: true` in
`content_telemetry.routing.yml`.

## Endpoints

- `GET /api/content-telemetry/insights/{entity_type}/{entity_id}` → `::entity()`
  - `entity_id` constrained to `\d+`. Optional `?route=<route>` query arg is forwarded to
    `InsightService::analyzeEntity($entity_type, (int) $entity_id, $route)`.
  - Response keys: `generated_at`, `entity_type`, `entity_id`, `health_score`, `health_label`,
    `insight_count`, `insights`.
- `GET /api/content-telemetry/insights/dashboard` → `::dashboard()`
  - Uses `InsightService::analyzeDashboard()` (site-wide, node aggregates).
  - Response keys: `generated_at`, `scope` (`"dashboard"`), `health_score`, `health_label`,
    `insight_count`, `insights`.

## Response shape

`buildResponse()` prepends `generated_at` (UTC ISO-8601), returns a `JsonResponse`, and sets headers
`X-Content-Type-Options: nosniff` and `Cache-Control: no-store, private`.

`normalizeInsights()` reduces each insight to a stable public shape — only `severity` (`poor` /
`warn` / `good`), `title`, `message`, `score` (int) — stripping any internal keys.

```json
{
  "generated_at": "2026-01-01T00:00:00+00:00",
  "entity_type": "node",
  "entity_id": 42,
  "health_score": 70,
  "health_label": "Needs attention",
  "insight_count": 2,
  "insights": [
    { "severity": "warn", "title": "Render budget exceeded", "message": "...", "score": 50 }
  ]
}
```

`health_score` / `health_label` come from `InsightService::computeHealthScore()` and
`healthScoreLabel()` (see [../insights/engine.md](../insights/engine.md) for scoring). When no
aggregate data exists the insights array is empty and the score is 100 / "Good".

## Typical use

Poll the dashboard endpoint from a monitoring script or a CI gate that fails a deploy when
`health_score` drops below a threshold, or the entity endpoint to track one page over time.
Responses are never cached, so consumers always get fresh data. Both endpoints require an
authenticated session/token with the view permission — they are not anonymous.
