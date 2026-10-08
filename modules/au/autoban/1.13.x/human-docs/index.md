# Autoban — manual setup guide

**Autoban** (`autoban`) automatically bans IP addresses by watching Drupal's own log. It
scans the watchdog (dblog) table for log entries that match a rule you define — for
example repeated *page not found* errors from a vulnerability scanner probing for
`/wp-login.php` — and, once an IP crosses the rule's threshold within a time window, hands
that IP to a **ban provider** to be blocked (core's Ban module by default).

Everything revolves around **rules**. Each rule is a small piece of configuration that
says: match log entries of a given **type** (such as *page not found* or *access denied*)
whose **message** matches a pattern, optionally filtered by referer and by whether the
visitor was anonymous or authenticated, within a rolling **window** (say, one hour); if the
same IP shows up at least **threshold** times, ban it via the chosen **provider**. Rules run
automatically on cron, on every request in "force mode" for near‑real‑time banning, from the
admin UI, or from a Drush command.

Autoban comes with helpful supporting tools: an **Analyze** page that suggests rules from
the noisiest current log messages, a **Test** page that previews exactly which IPs a rule
would ban before you enable it, a global **whitelist** of IPs that must never be banned, and
(via a submodule) one‑click "ban this IP" links right in the core *Recent log messages*
report. The actual banning is done by pluggable providers supplied by the bundled submodules:
**Autoban Ban** (core Ban, single IPs), and **Autoban Advanced Ban** (single IPs and whole
CIDR ranges). All of it — settings and rules — is exportable configuration. The module
targets **Drupal 9.3+, 10, or 11** and depends on core's **Database Logging** (`dblog`)
module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   choose the ban‑provider submodule(s) you need.
2. [Configuration](configuration/index.md) — the global settings, creating and testing ban
   rules, and running them (cron, force mode, or Drush).

## Where it lives in the admin menu

Autoban lives under **Configuration → People → Autoban**
(`/admin/config/people/autoban`), which is the rules list. From there you reach the add/edit
rule forms, the **Analyze** and **Test** screens, the **Delete all** action, and the global
**Settings** form at `/admin/config/people/autoban/settings`. All of it is gated by the
single **Administer autoban** permission.

## How to use it

Because Autoban needs a ban provider to actually block an IP, the first step after enabling
the module is to enable at least one provider submodule (usually **Autoban Ban** for core
Ban). Then create a rule, preview it on the **Test** page, and let cron run it — or run it
immediately from the UI or with `drush autoban:ban`. The full workflow, rule fields, and
global settings are covered in [Configuration](configuration/index.md).
