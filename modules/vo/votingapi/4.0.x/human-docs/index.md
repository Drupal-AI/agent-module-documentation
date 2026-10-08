# Voting API — manual setup guide

**Voting API** (`votingapi`) is a developer framework for building voting and rating
systems in Drupal. It stores every individual vote cast against any entity — a node,
a comment, a user, anything — and automatically tallies aggregate results for you:
count, average, sum, minimum, maximum, and median. What it deliberately does *not*
provide is an end-user voting widget. There are no stars or thumbs-up buttons out of
the box; a companion module (or your own code) presents the widget and casts votes,
and Voting API does the storing and the maths.

Because it is a framework, Voting API is most useful either as a dependency of a
rating module or as the foundation for custom voting behavior you build yourself.
Votes are stored as `vote` entities and organized into *vote types* (bundles), so
you can support multi-criteria ratings — for example rating a game separately on
video, audio, and replayability. Aggregate results are cached as separate entities
so reading a score is cheap, and you control when those results are recalculated:
immediately on every vote, batched at cron, or manually.

It also handles the practical details of real-world voting: throttling repeat
anonymous votes by a hashed IP address within a configurable time window, the same
for repeat votes by registered users, Views integration for both raw votes and
tallied results, and clean-up of votes when the voted entity is deleted. An optional
`votingapi_tokens` submodule exposes vote aggregates as tokens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to cast votes
and read results in code — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally add the tokens submodule.
2. [Configuration](configuration/index.md) — the settings form (calculation
   schedule and anti-abuse windows) and managing vote types, field by field.

## Where it lives in the admin menu

- Settings form: **Configuration → Search and metadata → Voting API**
  (`/admin/config/search/votingapi`), gated by the **Administer voting api**
  permission.
- Vote types: **Structure → Vote types** (`/admin/structure/vote-types`), gated by
  the **Administer vote types** permission.

## How to use it

On its own Voting API records and tallies votes but shows nothing to visitors. In
practice you either install a widget/rating module that builds on it, or write code
that casts `vote` entities and reads the cached results. After enabling, open the
settings form to choose how and when results are calculated, review the anti-abuse
windows, and add any extra vote types you need for different rating dimensions. See
[Configuration](configuration/index.md) for each option, and the
[`agent/`](../agent/start.md) docs for the code-level API and Drush commands
(`drush voting:recalculate`, `voting:generate`, `voting:flush`).
