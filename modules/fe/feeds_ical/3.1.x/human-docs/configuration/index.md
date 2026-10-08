# Configuration

Feeds Ical has no settings page of its own. You configure it entirely on a **Feeds
feed type** at **Structure → Feed types** (`/admin/structure/feeds`), by choosing the
Ical Parser and mapping the calendar fields onto your content.

## Set up a feed type

1. Go to **Structure → Feed types** and create a new feed type (or edit one).
2. **Fetcher** — choose where the data comes from. This is a separate Feeds plugin,
   not part of Feeds Ical:
   - *Download from URL* for a public iCalendar feed URL.
   - *Upload file* for an uploaded `.ics` file.
   - a directory/inline fetcher for pasted iCal text.
   Feeds Ical never fetches anything itself — it only parses the bytes the fetcher
   returns.
3. **Parser** — choose **Ical Parser**.
4. **Processor** — choose the entity to create/update (for example *Node* with your
   Event content type), as with any Feeds import.

## Parser settings

The Ical Parser has two settings:

- **Filter Days Before** — a number (minimum 0). Events older than this many days
  are ignored, which is handy for importing only recent events (for example, the
  last 30 days). Leave it at **0** to import all events regardless of age.
- **Skip Recurrence** — a checkbox. When ticked, the parser skips parsing recurrence
  (RRULE) rules, which can improve performance. Note that even without skipping, this
  version does not expand recurring events into separate items — it stores the raw
  RRULE string, which you can map for later handling.

Behind the scenes the parser uses a fixed set of library options (UTC default
timezone, and so on); these are not configurable.

## Map the calendar fields

On the feed type's **Mappings** tab, map the iCal **sources** the parser provides
onto your target entity's fields. The available sources include:

| Source | What it holds |
|--------|---------------|
| **Start / End (timestamp)** (`dtstart` / `dtend`) | Event start and end as UNIX timestamps — map to date fields. |
| **Start / End with timezone** (`dtstartTimezone` / `dtendTimezone`) | Start/end in `2019-07-29T06:50:00Europe/Amsterdam` form. |
| **Start / End (raw)** (`dtstartRaw` / `dtendRaw`) | The raw source date strings. |
| **Summary** (`summary`) | The event title — suggested target is the node **title**. |
| **Description** (`description`) | The event description — map to the body. |
| **Location** (`location`) | The event location — map to an address or text field. |
| **UID** (`uid`) | The event's unique id — suggested target is **GUID**, giving stable de‑duplication on re‑import. |
| **Last modified** (`lastmodified` / `lastModifiedRaw`) | LAST‑MODIFIED as a timestamp (defaults to "now" if unparseable) and the raw string. |
| **RRULE, Status, Sequence, Transp, Created, DTSTAMP** | Additional calendar metadata. |

Non‑standard `X-` properties on an event are also copied onto the item, so you can
map extra custom properties if your calendar includes them.

Tip: mapping **UID → GUID** is what lets a repeated import update existing events
instead of creating duplicates.

## Import

Add a feed of your new type and run an import. To keep the calendar in sync, use
Feeds' own periodic import settings so it re‑imports on cron. Any parsing errors are
caught and logged to the **feeds** log channel, and the parser returns whatever
items it managed to build.

## Configuring in code

You can also set the parser and its options programmatically:

```php
$ft = \Drupal\feeds\Entity\FeedType::load('events');
$ft->setParser('feeds_ical');
$ft->getParser()->setConfiguration(['filter_days_before' => 30, 'skip_recurrence' => TRUE]);
$ft->save();
```
