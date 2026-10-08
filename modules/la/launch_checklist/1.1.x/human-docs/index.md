# Launch Checklist — manual setup guide

**Launch Checklist** (`launch_checklist`) puts a pre‑launch checklist *inside*
Drupal, built on top of the [Checklist API](https://www.drupal.org/project/checklistapi)
module. Instead of a launch document that gets copied per project and diverges
immediately, the list of things that must be true before a site goes live lives on
the site itself — visible to whoever is working on it. Checklist API records **who
ticked each item and when**, which turns the list into an audit trail: the part
that matters when a launch goes wrong and the question is what was actually
checked.

The checklist is broken into 14 sections. Each item has a description and helpful
links to complete or verify it — the unglamorous things that have each caused a
real incident: robots.txt still disallowing everything, the staging site left
indexed, analytics not installed, the sitemap not submitted, error display left
on, cron not configured, the install‑time admin password unchanged, email pointing
at a catch‑all, favicon missing, 404 and 403 pages unset. Checking off items and
saving stores the timestamp and the user against each item in the database, and
that state can be exported through Configuration synchronization into version
control. It is brought to you by Kanopi Studios.

Two things are worth keeping in mind. First, **a checklist is a memory aid, not a
test** — ticking "analytics installed" records a claim, and a site with every box
checked can still be broken, so the items worth having are the ones someone
genuinely verifies. Second, **edit the list to your organisation**: a generic
checklist is a starting point, and the items that catch real problems are the ones
added after the last launch went wrong.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Checklist
   API dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — where the checklist lives, working
   through the items, and how the sign‑off is recorded.

## Where it lives in the admin menu

Launch Checklist registers a Checklist API checklist (route
`checklistapi.checklists.launch_checklist`). Once enabled it appears alongside any
other checklists in the **Configuration** area — see
[Configuration](configuration/index.md) for how to open and work through it.
