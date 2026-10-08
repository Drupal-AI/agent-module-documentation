# Configuration

Simplenews Scheduler has **no global settings page** (`configure` is null). You schedule each
newsletter individually, on the newsletter node itself. There is one site-wide config value
(the default send action) and two permissions, covered below.

## Schedule a newsletter

1. Log in as a user with the **send scheduled newsletters** permission.
2. Edit or create a Simplenews newsletter node and open its **Simplenews** send tab (the same
   tab you normally use to send an issue). The tab only offers scheduling when the node is a
   *template* (not itself a generated edition) and has not already been sent.
3. In the **Scheduled Newsletter** section, fill in:
   - an **activated** toggle — turn scheduling on for this newsletter;
   - a **start date** — when the first send should happen;
   - a **frequency / interval** — send every *N* days, weeks, or months;
   - a **stop condition** — stop after a fixed number of editions, stop on a specific end
     date, or run indefinitely with no end.
4. Save. The schedule is stored in the module's own `simplenews_scheduler` database table,
   keyed to this node.

From then on, whenever a send comes due, cron clones this template into a new edition node and
sends it. You edit the schedule any time by returning to the same send tab.

## How the automatic sending works

On each cron run the module looks for activated schedules whose next run time has passed. For
each due schedule it works out the edition's timestamp, reschedules the next run, **clones the
template node** into a new edition node, and hands that edition to Simplenews to mail. Because
this is entirely cron-driven, the practical rule is: **run cron at least as often as your
shortest interval.** A daily newsletter needs cron at least daily; if cron is late, the send is
late.

## The Newsletter Editions tab

Every scheduled newsletter gains a **Newsletter Editions** tab at `/node/{node}/editions`. It
lists the editions already generated and the ones still upcoming, with their dates — a running
record of what the schedule has sent. Viewing it requires the **overview scheduled
newsletters** permission.

## The one site-wide setting: default send action

There is a single global config value, `simplenews_scheduler.settings:default_send_action`, an
integer that sets the initial *send action* applied to a newly created schedule. It defaults to
`5` (Simplenews' "send none"). Most sites never need to touch it; if you do, set it with Drush:

```bash
drush config:set simplenews_scheduler.settings default_send_action 5 -y
```

## Permissions recap

| Permission | Controls |
|---|---|
| `send scheduled newsletters` | Seeing and using the scheduling form on a newsletter's send tab. |
| `overview scheduled newsletters` | Viewing a newsletter's `/node/{node}/editions` overview. |

## For developers: rewrite each edition as it is generated

If you need each edition to differ (a date-stamped title, a generated body, a dynamic subject),
implement `hook_simplenews_scheduler_edition_node_alter()`. It fires on each cron run after the
template is cloned but before the edition is saved and sent, so you can rewrite the edition node
in code. See the sibling [`agent/hooks/edition.md`](../agent/hooks/edition.md) doc for the
signature and an example.
