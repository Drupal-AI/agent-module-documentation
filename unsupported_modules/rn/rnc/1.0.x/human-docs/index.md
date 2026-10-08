# Random Name Chooser — manual setup guide

**Random Name Chooser** (`rnc`) is a small, fun utility for running
**Secret-Santa-style** name draws. Participants add names to a list, and each
person draws a random match — with one clever twist: the matcher avoids pairing
someone with their spouse. Spouses are grouped by a shared `spouse_letter`, so
partners are never drawn to give each other a gift. It's the kind of thing you'd
reach for to organise an office or family gift exchange on a Drupal site, with
per-user settings for each participant.

Please note an important status caveat before you invest in it: the project has
been **mothballed** — its maintainer marked it *Unsupported / Obsolete*, citing a
needed name change. It still targets Drupal 10 and 11, but it is not receiving
active development, so treat it as an as-is convenience rather than something to
build a critical workflow on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant its permission.

This module has **no central settings form**. Setup is a matter of granting the
module's permission and then letting participants build the list and draw their
matches, as described below.

## How to use it

1. Grant the module's permission (find it at **People → Permissions**,
   `/admin/people/permissions`) to the roles that should take part in draws.
2. Participants **add their names** to the shared list. Where two participants are
   spouses/partners, group them with the same `spouse_letter` so the matcher keeps
   them apart.
3. Each participant **draws a random match** — the module assigns a name while
   honouring the spouse constraint, so nobody is paired with their partner.

> **Status reminder.** Random Name Chooser is mothballed and unsupported. It's fine
> for a light, seasonal gift-exchange draw, but don't rely on it for anything
> mission-critical, and review it yourself before using it on a production site.
