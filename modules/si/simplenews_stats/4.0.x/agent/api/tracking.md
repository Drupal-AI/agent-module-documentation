# Tracking routes, tag scheme, and services

Tracking is fully automatic: enabling the module and mailing a Simplenews issue is
enough. There is no per-site configuration. This doc explains the runtime surface.

## Public routes (`simplenews_stats.routing.yml`)

Both are gated by `_permission: 'access content'` and `options: {no_cache: TRUE}`
(a cached response would count a single hit forever), because the recipient reading
the email is not an authenticated site visitor.

| Route | Path | Controller | Purpose |
|---|---|---|---|
| `simplenews_stats.hit_view` | `/simplenews-image` | `SimplenewsStatsController::hitView` | Serves the 1x1 pixel `assets/image/simple.png` |
| `simplenews_stats.hit_click` | `/simplenews-c/{tag}` | `SimplenewsStatsController::hitClick` | Logs a click, then redirects to the target link |

The pixel URL carries the tag in a `?sstc=` query parameter, not in the path; the
open event is logged by the event subscriber (below), not by `hitView()` itself.

## The tag scheme

A tag encodes the recipient and the issue as `u{subscriber_id}nl{node_id}` (built in
`SimplenewsStatsMail::getTag()` / `SimplenewsStatsMailSymfony::getTag()`).
`SimplenewsStatsEngine::getTagEntities($tag)` parses it: it requires the pattern
`/^u[0-9]*nl[0-9]*/`, splits on `u`/`nl` into exactly two ids, then loads the
`simplenews_subscriber` and the `node`. Returns `['subscriber' => ..., 'entity' => ...]`
or `FALSE` if the pattern fails or either entity does not load.

## Open logging: `simplenews_stats.event_subscriber`

`SimplenewsStatsEventSubscriber::simplenewsLog()` subscribes to
`KernelEvents::REQUEST` (priority 30). It reads `?sstc=` off the request; if present
it calls `SimplenewsStatsEngine::addStatTags($sstc)`. When the matched route is
`simplenews_stats.hit_view` the recorded action is `view`, otherwise `click`
(`SimplenewsStatsEngine::logHit()` decides on the route name).

## Click logging + redirect: `hitClick($tag)`

1. `getTagEntities($tag)` — if `FALSE`, redirect to `/`.
2. Read `link` from the query string.
3. `SimplenewsStatsAllowedLinks::isLinkExist($entity, $link)` — checks the
   `simplenews_stats_allowedlinks` table for a row matching this entity_type +
   entity_id + exact `link`. Those rows are populated during mail rewriting, so the
   redirect target must be a link that actually appeared in that issue.
4. If it matches: `addStatTags($tag, $link)` (logs the click) then
   `TrustedRedirectResponse(Url::fromUri($link)->toString())`.
5. If it does not match: `RedirectResponse($entity->toUrl())` (the issue node).

## Services and key methods

| Service id | Class | Notable methods |
|---|---|---|
| `simplenews_stats.engine` | `SimplenewsStatsEngine` | `getTagEntities($tag)`, `addStatTags($tag, $path = NULL)`, `logHitSent($subscriber, $entity)` |
| `simplenews_stats.allowedlinks` | `SimplenewsStatsAllowedLinks` | `add($entity, $link)`, `isLinkExist($entity, $link)`, `load($conditions)`, `insert/update/delete` |
| `simplenews_stats.tools` | `SimplenewsStatsTools` | `getEntityLabel($entity, $with_entity_type = FALSE)` — builds the `Type \| Label (type\|id)` string the autocompletes/filters parse |
| `simplenews_stats.mail` | `SimplenewsStatsMail` | `prepareMail(&$message)` — legacy mail path |
| `simplenews_stats.symfony_mail` | `SimplenewsStatsMailSymfony` | `prepareMail(Email $email)` — Symfony Mailer path |

`SimplenewsStatsEngine::addStatTags()` at runtime records a `simplenews_stats_item`
row (uid, snid, email, action title, entity ref, `route_path`, created) via
`logHit()`, and increments the matching `simplenews_stats` per-issue counter through
`globalStatUpdate()` (`increaseView()` / `increaseClick()`). `logHitSent()` is called
once per recipient at send time to increment `total_emails`.

### Example: read an issue's totals in PHP

```php
$node = \Drupal::routeMatch()->getParameter('node');
$stats = \Drupal::entityTypeManager()
  ->getStorage('simplenews_stats')
  ->getFromRelatedEntity($node); // FALSE if nothing recorded yet
if ($stats) {
  $views  = $stats->getViews();
  $clicks = $stats->getClicks();
  $sent   = $stats->getTotalMails();
}
```
