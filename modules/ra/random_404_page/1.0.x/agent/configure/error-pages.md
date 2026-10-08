<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring random error pages

## Where
Basic site settings: `/admin/config/system/site-information` (permission: *administer site configuration*). The module hides core's single **Default 404** and **403** path fields and adds two textareas: **404 pages** and **403 pages**.

## How to set
- Enter one internal path per line (e.g. `/node/12`, `/404-a`, `/oops`).
- Paths are validated on save with `Drupal::pathValidator()->isValid()`; an invalid path or one you cannot access is rejected with an error.
- Submit handler stores them as arrays in `random_404_page.settings`:
  - `404_pages`: list of paths
  - `403_pages`: list of paths

## Runtime behaviour
- On a 404, `ErrorPageEventSubscriber::on404()` reads `404_pages` and serves `array_rand()` of them via `makeSubrequestToCustomPath()` (status 404 preserved). `on403()` does the same for `403_pages` (status 403).
- Leaving a list empty falls back to core's normal error handling.
- The subscriber runs at core priority + 1 so it takes precedence over core's single-page subscriber.

## Notes for agents
- To set programmatically: `\Drupal::configFactory()->getEditable('random_404_page.settings')->set('404_pages', ['/a','/b'])->save();`
- No cron, queue, or external calls involved.
