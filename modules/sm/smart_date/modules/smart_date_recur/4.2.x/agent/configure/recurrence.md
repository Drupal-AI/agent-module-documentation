# Recurrence: rules, overrides, instances & formatters

## Enabling
On a content type with a `smartdate` field, the Smart Date widget shows a **Repeat** control
once this submodule is enabled. Choosing a frequency generates an RRULE.

## Entities
- `smart_date_rule` (`Entity\SmartDateRule`) — stores the RRULE, timezone, frequency, limit,
  and links to the host entity/field. Instances are generated from it (`makeRuleInstances`,
  `getRuleInstances`).
- `smart_date_override` (`Entity\SmartDateOverride`) — a single modified/cancelled instance,
  kept separate so the base rule is unchanged.

## Managing instances (admin UI)
Routes under `/admin/content/smart_date_recur/{rrule}/…`:
- `.../instances` — list occurrences.
- `.../instance/reschedule/{index}` — move one occurrence.
- `.../instance/remove/{index}` — cancel one occurrence.
- `.../apply_changes` — push edits forward to the series.
- `overrides/{smart_date_override}/delete` — revert an override.

## Formatters (`Plugin/Field/FieldFormatter/`)
- `smart_date_recurring` (`SmartDateRecurrenceFormatter`) — renders the recurrence summary.
- `SmartDateDailyRangeFormatter` — daily time range across a series.

## Views
Frequency filter (`Plugin/views/filter/Frequency.php`) to filter by recurrence frequency.

## Instance maintenance
Queue worker `RecurRuleUpdate` (`Plugin/QueueWorker/`) regenerates future instances on cron.
