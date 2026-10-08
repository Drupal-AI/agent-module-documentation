# Gamify — manual setup guide

**Gamify** (`gamify`) adds gamification — points and rewards — to your site's
community UI, to nudge users toward more activity. It awards points for things
people do, such as creating, editing, or deleting entities, and it can drive
leaderboards and similar engagement features off those points.

Rather than inventing its own rules engine, Gamify is built on **ECA**
(Event‑Condition‑Action): the point‑awarding logic is expressed as ECA models, so
you decide which events earn points and how many by configuring ECA — a flexible,
no‑code way to define the rules. Points are stored via a **User Points** clone
that ships with Gamify as a submodule (the original User Points module is
unmaintained, so Gamify bundles an updated copy for Drupal 9+). Gamify provides its
own permissions and depends on ECA. This is a **beta** release (`1.1.0-beta11`) on
core `^9 || ^10 || ^11`.

Two things to keep in mind:

- **It tracks personal data.** Per‑user activity and point totals are personal
  data — expose leaderboards and point displays appropriately, and handle the
  activity data in line with your privacy policy.
- **Rules are powerful.** ECA models can do far more than award points, so keep
  authoring of the gamification rules to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and ECA.

Gamify has **no single settings form of its own** — the point‑awarding rules are
authored as ECA models, and points are managed through the bundled User Points
functionality, as described in "How to use it" below.

## Where it lives in the admin menu

Gamify provides its own permissions, managed at **People → Permissions**. The
rules that award points are ECA models, edited in the **ECA** UI (**Configuration
→ Workflow → ECA**), and user point totals are managed through the bundled User
Points feature.

## How to use it

1. After enabling, review Gamify's permissions at **People → Permissions** and
   grant them to the appropriate roles — keep rule authoring to trusted admins.
2. In the **ECA** UI, configure or adjust the models that award points for user
   activity (creating/editing/deleting content, and any other events you want to
   reward).
3. Surface the results — points and leaderboards — where it makes sense for your
   community, taking care to display personal data appropriately.
