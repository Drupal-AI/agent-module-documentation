# Rules — manual setup guide

**Rules** (`rules`) lets you automate your site with no code, using the classic
**event → condition → action** (ECA) model. You pick an **event** — something that
happens on the site, like an entity being saved, a user logging in, or cron
running — attach any number of **conditions** that must be true, and list the
**actions** to carry out when they are. When the event fires, Rules checks the
conditions and, if they pass, runs the actions.

These automations are called **Reaction Rules**, saved as configuration entities
and triggered automatically by a generic event subscriber. Reusable logic can be
saved separately as a **Rules Component** and called from many rules (or from
code), so you don't repeat the same action chain everywhere. Everything is built on
an **expression** engine that nests conditions and actions and passes data between
them through the **Typed Data** module — so one action's output can feed a later
action. Actions and conditions are plugins, and Rules ships many built‑in ones for
entities, nodes, users, paths, site messages, email, and banning IPs.

Site builders manage everything through a UI at **Configuration → Workflow →
Rules**, split into *Reactions*, *Components*, and *Settings*. Developers can build,
save, and run rules and components programmatically, add custom action/condition
plugins, define new events in a `*.rules.events.yml` file, and manage rules from
the command line with Drush. It requires Drupal 10.3 or newer and the **Typed
Data** contrib module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependency
   with Composer and enable it.
2. [Configuration](configuration/index.md) — building reaction rules and
   components, the settings form, permissions, and Drush commands.

## Where it lives in the admin menu

Everything is under **Configuration → Workflow → Rules**
(`/admin/config/workflow/rules`, route `entity.rules_reaction_rule.collection`),
with tabs for **Reactions**, **Components**, and **Settings**.

## How to use it

1. Install the module and its Typed Data dependency, then enable it (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Workflow → Rules → Reactions → Add reaction rule**.
3. Give it a label, pick the **event(s)** to react to, then add **conditions** and
   **actions** — see [Configuration](configuration/index.md) for the full
   walkthrough.
4. Save, and trigger the event to watch the rule fire. If it doesn't behave, turn
   on the debug log (in Settings) to trace what happened.
