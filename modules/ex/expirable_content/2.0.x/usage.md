<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds computed "expiration date" and "warning date" fields to any content entity bundle, derived from a chosen date field plus a per-bundle day offset, without taking any action when those dates arrive.

---

Expirable Content lets an administrator mark any content entity bundle (nodes, media, users, comments, custom entities, etc.) as expirable through an `expirable_content_type` config bundle. For each configured bundle you pick a base date field (a `timestamp`, `created`, or `changed` field), a number of "days before expiration", and a number of "days to notify before expiration". The module then exposes two read-only computed base fields on every entity of that bundle — `expiration_date` (base date + N days) and `warning_date` (expiration date − warn days) — and mirrors those values into an internal, revisionable `expirable_content` tracking entity that is kept in sync by entity insert/update/delete/revision-delete hooks. Views integration adds the two dates as field/filter/sort handlers on the target entity's base and revision tables. Crucially, the module performs NO action of its own when a date passes: there is no cron job, no unpublishing, and no deletion. It only computes and records the dates, leaving the actual "what happens on expiration" to rules-based tools such as Rules, ECA, or the Message suite, or to a Views listing. Configuration lives at Administration › Structure › Expirable Content types and is gated by the single "administer expirable_content types" permission.

---

- Add a computed expiration date to article nodes calculated as "authored/created date + 30 days".
- Add a warning date that fires a configurable number of days before an entity's expiration date.
- Configure expiration for any content entity type, not just nodes (media, users, comments, custom entities).
- Base expiration on a `changed` field so content "expires" a set number of days after it was last edited.
- Base expiration on a `created` field so content expires a fixed period after authoring.
- Base expiration on a custom `timestamp`/date field to give editors explicit control of the countdown.
- Build a Views listing of content sorted by upcoming expiration date.
- Build a Views listing filtered to content whose warning date has already passed (content needing review).
- Expose expiration and warning dates as Views fields on both the default and latest-revision rows.
- Drive an ECA / Rules model off the computed expiration date to unpublish, notify, or archive content.
- Send an editor reminder email via the Message suite when an entity reaches its warning date.
- Track per-bundle expiration policy centrally (days-to-expire and days-to-warn) instead of per node.
- Enable or disable expiration for a bundle with a single status checkbox, without deleting the config.
- Keep expiration data revision-aware, with a tracking record created per content revision.
- Automatically remove expiration tracking records when the source content or revision is deleted.
- Provide expiration metadata to time-limited campaign or promotion content.
- Model "review by" dates for compliance content that must be re-checked periodically.
- Surface which pages are stale by sorting a moderation dashboard on the warning date.
- Let editors see, in a report, all content due to expire within the coming week.
- Apply different expiration windows to different bundles of the same entity type.
- Combine the computed dates with Scheduler-style workflows built in ECA rather than a bundled cron action.
