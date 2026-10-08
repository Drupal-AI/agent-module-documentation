# Configuration

Entity Lifecycle is configured mainly at **Configuration → Content authoring →
Entity Lifecycle**. This is where you decide which content is scanned, what statuses
it can take, and when the scanner runs. User‑account lifecycle is configured
separately (see the end of this page).

## Enable scanning per bundle

Scanning is opt‑in per content type (and per supported entity type). Enable it only
for the bundles whose freshness you want to track — for example your "Event" or
"Policy" content types — and leave the rest alone. This keeps the review cycle focused
on content that actually goes stale.

## Define statuses

Statuses describe where a piece of content sits in its lifecycle. Out of the box the
cycle uses states like **Current**, **Needs Review** and **Outdated**, and you can
configure statuses with:

- a **color** so they stand out in dashboards and banners, and
- a **review flag** marking whether that status means the content needs attention.

## Set conditions

Conditions are the rules the scanner evaluates to decide when content moves out of
"Current." They are provided by an extensible **condition plugin system** and can be
organized into **groups**. Typical conditions look at things like content **age**,
**usage**, or **login activity** (for users). Configure the conditions that define
"stale" for your site, and content matching them is assigned a review/outdated status.

## Review validity period

Set, per content type, how long a review stays valid — the window after which content
that was marked Current should be re‑evaluated. This drives how often the same content
comes back around for review.

## Scan interval

Choose how often the cron‑based scanner runs its evaluation: **every cron run**, or
every **6 hours**, **12 hours**, **daily**, **2 days**, or **weekly**. Less frequent
intervals reduce load on large sites; more frequent ones keep statuses fresher.

## The review banner and editing

When someone views content that needs review, Entity Lifecycle shows a **banner**
prompting attention. **Editing the content resets it to Current**, restarting the
cycle — so simply keeping content up to date is what clears the flag.

## Editorial dashboards (Views)

Entity Lifecycle integrates with **Views**, so you can build editorial dashboards
that list content by lifecycle status — a ready way to see everything that needs
review in one place.

## Run a scan manually (Drush)

Besides the scheduled cron scan, the module provides **Drush commands** to trigger a
scan on demand — handy for testing your conditions or forcing an immediate refresh.
Run them prefixed with `ddev` from the host, or without the prefix inside `ddev ssh`.

## User‑account lifecycle

To track inactive user accounts, enable the module's **User** part and configure it at
**Configuration → People → Account settings**. This applies the same
freshness/review idea to user accounts — for example surfacing accounts that haven't
logged in for a long time, for cleanup or security review.
