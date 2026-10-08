# Configuration

Content Telemetry starts collecting as soon as it is enabled, so this form is
about **tuning** — how much data to sample and where the insight engine draws
its lines. There are no credentials or connection settings here, because the
module talks to no external service.

## Open the settings form

1. Log in as a user with the **administer content telemetry** permission.
2. Go to **Configuration → System → Content Telemetry**, or navigate directly to
   `/admin/config/system/content-telemetry`.

## Sampling

- **Sampling rate** — the percentage of requests that are instrumented and
  recorded. Sampling keeps the overhead of always‑on telemetry low. In
  **production, leave the default (5%)** so the module measures a representative
  slice without weighing every request down. For **local testing**, set it to
  **100%** so every page you load is captured immediately.
- **Force sample** — a toggle that captures every request regardless of the
  sampling rate. Turn this **on for local debugging** when you want deterministic
  results while reproducing a slow page, and **leave it off in production**.

## Render budget

- **Render budget** — your target ceiling (in milliseconds) for average render
  time. It is the reference the *performance budget* insight rule uses: the rule
  warns when a page's average render time reaches the budget and flags it as
  critical at roughly twice the budget. Set it to whatever "acceptably fast"
  means for your site.

## Insight‑rule thresholds

The insight engine runs six deterministic rules, and their thresholds are
configurable from this form so you can match them to your site's expectations:

- **Performance budget** — driven by the render budget above (warn at the
  budget, critical at ~2×).
- **High DB ratio** — fires when database time makes up more than the configured
  percentage of total render time (a query‑bound page).
- **Low cache hit** — fires when the cache‑hit ratio falls below the configured
  threshold.
- **Regression** — fires when the 24‑hour average render time has risen against
  the 7‑day baseline by more than the configured percentage.
- **Heavy block dominance** — fires when a single block accounts for more than
  ~30% of a page's render time.
- **Global slow block** — fires when one block is slow (average over ~500 ms)
  across three or more routes.

Each insight is scored: a *warn* deducts 15 points and a *poor* deducts 30 from
the 0–100 health score (clamped at 0), which then maps to the labels *Good*
(80–100), *Needs attention* (50–79), and *Critical* (0–49). Tightening a
threshold surfaces more insights and lowers scores sooner; loosening it does the
opposite.

## Save

Click **Save configuration**. New settings apply to subsequent requests and to
the next aggregation/insight pass. Because insights are recomputed from the
aggregate tables, changes to thresholds are reflected as the rollups run — allow
a cron cycle for the dashboards to settle.

## A note on the JSON API and clearing data

Two read‑only JSON endpoints are available to users with **view content
telemetry** —
`GET /api/content-telemetry/insights/{entity_type}/{entity_id}` and
`GET /api/content-telemetry/insights/dashboard` — returning the health score,
label, insight count, and the full insights array (responses are sent
`Cache-Control: no-store, private`). They are handy for monitoring scripts and
CI health checks. To wipe collected telemetry, use the **clear content
telemetry** permission; keep both permissions with trusted roles.
