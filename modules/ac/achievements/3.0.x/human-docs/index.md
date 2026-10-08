# Achievements — manual setup guide

**Achievements** (`achievements`) is a gamification framework for Drupal. Users
**unlock achievements** and **earn points** as they reach milestones — posting
content, commenting, logging in, or any custom event you decide to reward. It is a
way to drive engagement by turning ordinary site activity into badges and a running
score.

It comes with leaderboards and a per-user achievements page out of the box. Two
Views — `achievement_totals` and `achievement_unlocks` — power the leaderboards,
and each user gets a page showing what they have unlocked. Because these are built
on Views and normal entity access, they are governed by your site's usual access
rules; the module has no access-control role of its own.

Achievements is also a developer framework. You define the achievements your site
offers, and you award them from your own code or event handlers when the milestones
you care about happen. Simpler milestones can be wired up through configuration,
while anything custom is awarded programmatically.

One privacy note worth keeping in mind: leaderboards and the per-user pages can
expose usernames and activity to whoever can view them. Decide who should see the
leaderboards and set the relevant Views / page access accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, defining
   achievements, and the developer side.

## Where it lives in the admin menu

Achievements has a settings form (`achievements.settings`). Leaderboards are
provided as Views (`achievement_totals`, `achievement_unlocks`), and each user has
their own achievements page. See [Configuration](configuration/index.md).
