# Configuration

Voting API has two things to set up: a **settings form** that controls how and when
results are tallied, and a collection of **vote types** that define the kinds of
votes your site records.

## Settings form

Log in as a user with the **Administer voting api** permission and go to
**Configuration → Search and metadata → Voting API**, or navigate directly to
`/admin/config/search/votingapi`.

### Calculation schedule

Decides when aggregate results (count, average, and so on) are recalculated after
votes change:

- **Immediate** *(default)* — results are re-tallied the moment a vote is cast.
  Simplest and always up to date, but does the work on every vote.
- **Cron** — changed entities are re-tallied when cron runs. Better for
  high-traffic sites, at the cost of results lagging until the next cron run.
- **Manual** — results are never tallied automatically. Choose this only when a
  companion module manages the recalculation cycle itself.

### Anonymous window

How long (in seconds) before two anonymous votes coming from the same computer (a
hashed IP address) are treated as separate votes rather than a repeat. The default
is `86400` (one day). Set it to `-1` for "never" (the strongest de-duplication —
one vote per computer, effectively forever) or `0` to always count every vote as
distinct. Only a fixed list of interval values up to one week (604800) is allowed.

### User window

The same rollover window, but for repeat votes by the same *registered* user. The
default is `-1` (never — a registered user's repeat vote is always treated as the
same vote).

### Delete everywhere

When a user is deleted, this controls whether their votes cast on *other people's*
content are also removed. Off by default.

You can also set any of these from the command line, for example:

```bash
drush config:set votingapi.settings calculation_schedule cron -y
drush config:set votingapi.settings anonymous_window 3600 -y
```

## Vote types

Vote types are the bundles of the vote entity — each one represents a distinct kind
of vote or rating dimension. Manage them at **Structure → Vote types**
(`/admin/structure/vote-types`), which requires the **Administer vote types**
permission. The module ships one default type, **Normal vote**.

To add a type, click **Add vote type** and fill in:

- **Label** — a human-readable name (Drupal derives the machine name from it).
- **Value type** — how the vote's numeric value is interpreted. This is a free-form
  string; the two common conventions are `points` (for +1 / -1 style sentiment
  votes) and `percent` (for star or percentage ratings).
- **Description** — optional notes about what the type is for.

Add extra vote types when you want to record independent ratings on the same entity
— for instance separate "video", "audio", and "gameplay" scores — which is how
Voting API supports multi-criteria voting.

## A note on cron

If you set the calculation schedule to **Cron**, make sure cron actually runs on
your site. On each run, Voting API recalculates results for every entity that
received votes since the last run.
