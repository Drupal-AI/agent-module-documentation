<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracking endpoints & queue pipeline

Class `Drupal\content_reporting\Controller\TrackingController` (extends `ControllerBase`; DI:
`database`, `current_user`, `entity_type.manager`, `session`, `datetime.time`, `queue`).

## Endpoints
| Route | Path | Method | Requirement | Method called |
|-------|------|--------|-------------|---------------|
| `content_reporting.track_node` | `/track-content` | POST | `_permission: 'access content'` | `trackContent()` |
| `content_reporting.track_interaction` | `/track-content/interaction` | POST | `_permission: 'access content'` | `trackInteraction()` |

Both are called from `js/track.js`, which first fetches `/session/token` and sends it as an
`X-CSRF-Token` header. `trackContent()` reads JSON `{nid, gdpr_consent?}`; it loads the node
(`intval($data['nid'])`), takes the node's own title, and enqueues a view. `trackInteraction()`
reads JSON `{nid, interaction_type, element?, duration?}` and enqueues an interaction.

## Anonymous visitor id
`generateAnonymousUserIdSession()` stores a per-session pseudo-uid (`10000 + mt_rand(0,9999)`) so
anonymous events can be grouped; authenticated events use the real uid.

## Queue pipeline
Events are not written inline. `trackContent()` → `queue('content_reporting_track_queue')` with
`{nid, uid, title, views:1, report_date, gdpr_consent}`; `trackInteraction()` →
`queue('content_reporting_interactions_queue')` with `{nid, uid, interaction_type, element,
duration, timestamp}`. Two `@QueueWorker` plugins (`src/Plugin/QueueWorker/`) drain them on cron
(`cron = {"time" = 60}`) or via `drush queue-run <queue>`:

- `ContentReportingTrackWorker::processItem()` casts fields and `INSERT`s into
  `content_reporting_reports` (nid/uid/views/interactions/gdpr_consent cast to int, title/report_date
  to string).
- `ContentReportingInteractionWorker::processItem()` `INSERT`s the interaction (nid, uid,
  interaction_type, `element`, duration, timestamp) into `content_reporting_interactions` verbatim.

Both workers wrap the drain in a `BatchBuilder` (`run()` claims up to 10 items, sets a
`*_finished` callback via `batch_set`).

## Notes for an integrator
- Views are logged per event; the dashboard sums them (`SUM(r.views)`) per node.
- `interaction_type` is free text from the client; the dashboard only looks for `click` and
  `time_spent`.
- The interaction `element` string is client-supplied (the JS derives it from the clicked element's
  id/text/aria-label, but the endpoint accepts any value).
