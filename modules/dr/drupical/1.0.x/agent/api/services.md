<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & the Event object

Both services are `final` and `@internal` — call them, don't subclass. Namespace
`Drupal\drupical`.

## `drupical.fetcher` — `EventsFetcher`

Fetches and parses events from the Drupal.org feed
(`https://www.drupal.org/api-d7/node.json?type=event&sort=field_date_of_event&direction=DESC&page=0`,
passed in as the `%drupical.feed_json_url%` parameter).

- `fetch(bool $force = FALSE): Event[]` — returns all cached upcoming events. Walks the
  paged feed until the first event whose `field_date_of_event.value2` (end) is in the past,
  sorts featured (DrupalCon) first then by soonest start, and caches the raw array in the
  expirable key/value store (`drupical` collection, `events` key) for `max_age` seconds.
  `$force = TRUE` bypasses and rewrites the cache.
- `getTotalCount(): int` — count of cached upcoming events.
- `getEvents(int $offset, int $limit): Event[]` — a paginated slice.
- `getEventTypes(): array` (static) — the feed-key → label map:
  `drupalcon`→DrupalCon, `training`→Training, `drupalinitiativemeeting`→Initiative meeting,
  `drupalfest`→Ceremony/awards, `localmeetup`→Meetup/interest group,
  `external`→External technology event, `drupalcamp`→Camp, `contribution`→Contribution.
- `parseType(array): string` (static) — maps a feed `field_event_type` array to a joined
  label string. An event is `featured` when its types include `drupalcon`.

On feed/HTTP failure `fetch()` logs via the `logger.channel.drupical` channel and rethrows.

## `drupical.renderer` — `EventsRenderer`

Builds the render array the block and controller use.

- `render(int $limit = 5, int $offset = 0): array` — returns a `#theme => 'drupical'`
  render array (featured/standard split, counts, `has_more`, the five outbound link
  parameters, attaches `drupical/drupical`, `#cache max-age 3600`). On fetch exception it
  returns a plain `#markup` error string instead.
- `getTotalCount()`, `getEvents($offset,$limit)`, `getAllEvents()` — delegate to the fetcher.

## `Event` value object

Immutable, constructed by the fetcher. Readonly public props: `id`, `title`, `url`,
`date_start`, `date_end` (both `DATE_ATOM` strings), `location`, `type`, `featured` (bool).
Helpers `getDateStartTimestamp()` / `getDateEndTimestamp()` parse the ATOM strings back to
unix timestamps.

## Example

```php
/** @var \Drupal\drupical\EventsFetcher $fetcher */
$fetcher = \Drupal::service('drupical.fetcher');
foreach ($fetcher->getEvents(0, 3) as $event) {
  printf("%s — %s (%s)\n", $event->title, $event->location, $event->date_start);
}
```
