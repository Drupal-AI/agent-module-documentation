# Configuration

Autoban has two layers: the **global settings** that shape how matching works and when rules
run, and the **rules** themselves. Everything is under **Configuration → People → Autoban**
(`/admin/config/people/autoban`) and requires the **Administer autoban** permission.

## Permission

The module defines one permission, **Administer autoban** (`administer autoban`). It guards
every Autoban screen — the rules list, the add/edit/delete rule forms, the settings form, and
the Analyze, Test, Ban, and Delete‑all pages — and controls access to the rule entities
themselves. There are no finer‑grained permissions: a role either administers all of Autoban
or none of it, so grant it only to trusted administrators.

## Global settings

Open the settings form at **Configuration → People → Autoban → Settings**
(`/admin/config/people/autoban/settings`). The main options are:

- **Query mode** — how a rule's message/referer pattern is matched against the log: `LIKE`
  (simple substring/wildcard matching) or `REGEXP` (regular expressions, so one rule can match
  a whole family of malicious paths).
- **Use wildcards** — when off, Autoban automatically appends wildcards to your message
  patterns so you don't have to.
- **Thresholds** and **Windows** — the option lists offered for a rule's *threshold* (how many
  matching entries) and *time window* fields, plus a **default window** pre‑filled on new
  rules.
- **Whitelist** — a list of IP addresses that must **never** be banned (your office, a CDN,
  monitoring services). Fill this in before enabling aggressive rules.
- **Analyze exclusions** and **Analyze threshold** — which log types the Analyze page ignores,
  and the threshold it uses when suggesting rules.
- **Run on cron** *(on by default)* — evaluate every rule on each cron run.
- **Force mode** — evaluate rules on **every request** for near‑real‑time banning (heavier, but
  faster to react).
- **Debug** — log what each rule query matched, useful when tuning a rule.

You can also read or set any of these from Drush, for example:

```bash
drush cget autoban.settings autoban_query_mode
drush cset autoban.settings autoban_query_mode REGEXP -y
```

## Creating a ban rule

From the rules list (`/admin/config/people/autoban`), click **Add rule** and fill in:

- **Log type** — the watchdog log type/channel to scan, e.g. *page not found* (404s),
  *access denied* (403s), or *user* (login activity).
- **Message pattern** — the text the log message must match (a scanner path such as
  `wp-login`, for instance). How this is interpreted depends on the global **Query mode**.
- **Referer** *(optional)* — a pattern the referring URL must match, handy for catching spam
  referrers.
- **User type** — whether to count entries from anyone, only anonymous visitors, or only
  authenticated users. Restricting to anonymous keeps logged‑in staff from ever being caught.
- **Threshold** — ban the IP once it has at least this many matching entries in the window.
- **Time window** — the rolling period of log entries to consider, e.g. *1 hour* or *1 day*
  (leave empty to consider all entries).
- **Provider** — which ban provider carries out the ban. The choices come from the enabled
  submodules: **Core Ban** (`ban`), **Advanced Ban** (`advban`), or **Advanced Ban (range)**
  (`advban_range`) for CIDR ranges.

Save the rule. Rules are stored as exportable configuration (`autoban.autoban.<id>`), so you
can deploy them across environments like any other config.

## Test before you enable

Before trusting a rule, use the tools on the rules list:

- **Test** (on a rule's row) previews exactly which IPs the rule *would* ban right now, so you
  can confirm it isn't catching legitimate traffic.
- **Analyze** (`/admin/config/people/autoban/analyze`) inspects your current log noise and
  suggests rules for the most frequent offending messages — a quick way to bootstrap sensible
  rules.
- **Delete all** wipes every rule if you want to start over.

## Running the rules

Once you're confident in a rule, it can run several ways:

- **On cron** — with **Run on cron** enabled (the default), every rule is evaluated on each
  cron run. This is the normal hands‑off mode.
- **In force mode** — with **Force mode** enabled, rules are evaluated on every request for
  faster reaction, at some performance cost.
- **From the UI** — use the "ban" action on the rules list to process rules on demand.
- **From Drush** — run the ban logic outside cron, for example from a deploy hook or a
  scheduled job:

  ```bash
  drush autoban:ban                    # process every rule (like cron)
  drush autoban:ban ban_404_scanners   # process just one rule by its id
  ```

  Remember that each rule bans through its configured provider, so the matching provider
  submodule (e.g. Autoban Ban) must be enabled for the ban to actually take effect.
