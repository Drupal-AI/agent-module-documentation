# Configuration

DB Log Filter does nothing until you configure it — by default every message logs.
This page explains the settings and how the include/exclude logic works.

## Open the settings form

1. Log in as a user with the core **Access site reports** permission.
2. Go to **Reports → DB Log Filter settings**, or navigate directly to
   `/admin/reports/dblog-filter`.

The form has two parallel, identically‑shaped groups: one for the **database log**
and one for **syslog** (the syslog group only matters when the core Syslog module
is enabled). You can filter the two destinations completely independently — for
example, keep detailed dblog while trimming syslog, or vice versa.

## The method: include vs exclude

Each group has a **method** that decides how a matched rule is interpreted:

- **Exclude** *(default)* — a message that **matches** a rule is **dropped**;
  everything else is logged.
- **Include** — only messages that **match** a rule are logged; everything else is
  dropped.

## Severity levels

Each group has the eight RFC severity levels — `emergency`, `alert`, `critical`,
`error`, `warning`, `notice`, `info`, `debug` — each with a checkbox (all
unchecked by default). Severity is evaluated **first**: if a message's level is one
of the checked levels, the decision is made immediately (with *include*, it is
logged; with *exclude*, it is dropped) and the channel rules are not consulted.

So to **log only `error` and worse**, set the method to *Include* and check
`emergency`, `alert`, `critical`, and `error`.

## Channel rules

When severity alone doesn't decide it, the per‑channel rules are checked. Each rule
is one line in the form `channel|level1,level2,…` — for example:

- `cron|info,notice,debug` — matches info/notice/debug messages on the `cron`
  channel.
- `mymodule|notice,warning` — matches notice/warning messages from `mymodule`.

The **channel** is the logger channel string (what a module passes to
`\Drupal::logger('channel')`), and the levels are the lowercase RFC names. You can
optionally attach a **regex** to a rule so it only matches messages whose text
matches the pattern — useful for silencing one specific benign message on an
otherwise wanted channel/level.

## How the decision is made (summary)

For each message:

1. If its severity is one of the checked levels → decide now (*include* = log,
   *exclude* = drop).
2. Otherwise, test it against each channel rule (channel + level, plus the
   optional regex).
3. Final result: with *include*, log only if a rule matched; with *exclude*, log
   only if **no** rule matched.

With the shipped defaults (no level checked, no channel rules), nothing matches, so
under the default *exclude* method **everything logs**.

## Examples

**Exclude a chatty channel** from the database log, keeping everything else — set
the dblog method to *Exclude* and add the channel rule `cron|info,notice,debug`.

**Log only errors and worse** — set the method to *Include* and check the
`emergency`, `alert`, `critical`, and `error` severities.

Save the form with **Save configuration** when done.

## Restore "log everything"

Set the method back to **Exclude**, uncheck all severity levels, and clear the
channel rule lists (for both the dblog and syslog groups). That is the module's
shipped baseline, where nothing is filtered.
