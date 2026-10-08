# Login Count — manual setup guide

**Login Count** (`login_count`) does exactly one thing and does it deliberately
simply: it counts how many times each user has logged in and exposes that count to
**Views**. There's nothing more to it — no dashboards, no settings, no per‑login
records.

What sets it apart from similar modules is *what it doesn't* store. Instead of
writing a database row for every single login, it just increments a per‑user
counter. That has two nice consequences. There's no ever‑growing table to purge
and no data to lose track of, and there's **no privacy concern** — it doesn't
record IP addresses, user agents, or any other login detail, just a running total.
If a user is deleted, their count record is removed too.

Because the count is exposed as a Views field, you can add it to any user‑based
view without needing aggregation or a relationship — it's a plain field on the
user. That makes it easy to build, say, a "most active users" list or simply show
each account's login tally in an admin report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — counting starts automatically once the module
is enabled, and you display the count through Views (described below).

## Where it lives in the admin menu

Login Count adds no admin settings page. It works automatically after enabling,
and you surface the count from **Structure → Views**
(`/admin/structure/views`).

## How to use it

1. Enable the module. From that point on, each user's login count increments
   automatically every time they log in.
2. Create or edit a view whose rows are **users**.
3. Under **Fields**, add the **Login Count** field. No aggregation or relationship
   is required — it's a direct field on the user.
4. Display or sort by it as you like — for example, sort descending to list your
   most active accounts.

> **A light privacy note:** although Login Count stores no IP or user‑agent data,
> a per‑user login tally is still user‑activity data and can hint at usage
> patterns. Show it only in views whose access is limited to appropriate roles.
