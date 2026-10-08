# User Expire — manual setup guide

**User Expire** (`user_expire`) automatically **blocks user accounts** — either on a
specific date you set for an individual user, or after a configurable period of
**inactivity** defined per role — and can email users a warning before their account
expires. It's the tidy way to enforce a policy like "contractor accounts end on their
last day" or "dormant vendor accounts get disabled after 90 days" without anyone
remembering to do it by hand.

There are two complementary mechanisms. **Per‑user:** editors with the right permission
see a "User expiration" section on each account's edit form, where they tick a box and
pick a date; that account is blocked on that date. **Per‑role:** on the settings form you
set, for each role, a number of days of inactivity after which accounts holding that role
are blocked. "Inactivity" means time since last login — or since account creation for
users who never logged in. All the actual blocking happens on **cron**: it sends any
warning emails first, then blocks expired per‑user accounts, then blocks inactive per‑role
accounts, logging each one.

Warning emails are optional and fully templated (with tokens), throttled so they aren't
re‑sent too often, and start a configurable number of days before expiry. The module also
adds an **Expiring users** report, Views integration (so you can build your own lists by
expiration date), and a Rules action for automation. It depends only on core's **User**
module and works on Drupal 10.3+, 11, and 12. Three restricted permissions gate the
account‑edit control, the report, and the settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the per‑role inactivity rules, warning
   emails, per‑user dates, permissions, and the Expiring users report.

## Where it lives in the admin menu

The settings form is at **Configuration → People → User expire**
(`/admin/config/people/user-expire`), guarded by the *administer user expire settings*
permission. The **Expiring users** report is at **Reports → Expiring users**
(`/admin/reports/expiring-users`). A single account's expiration date is set on that
user's own edit form.

## How to use it

1. Enable the module and make sure **cron** runs regularly — all blocking happens on
   cron.
2. To expire by inactivity, open the settings form and set a number of days for the
   relevant role(s).
3. To expire a single account on a date, edit that user and use the "User expiration"
   section (needs the *set user expiration* permission).
4. Optionally enable and customise the warning email.

See [Configuration](configuration/index.md) for the full walkthrough.
