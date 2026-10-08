<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Submissions Limit (comment_submissions_limit) — agent index

Server-side **rate limiter for comment submissions**. Per comment type you configure a
**limit**, a **time interval** (number + unit), and a set of **comment fields**; when a comment
is submitted the module counts existing comments of that type whose selected field values match
the submission within the interval, and blocks the submission (form validation error) once the
count reaches the limit. Package `Comment`. Core `^10.3 || ^11.0`. License GPL-2.0-or-later.
Installed as **1.0.0-beta1** (version dir `1.0.x`). Depends only on core **`comment`**.

## What it provides (from source — the whole module is one `.module` + one value object)

- **`comment_submissions_limit.module`**
  - `hook_form_comment_type_edit_form_alter` — adds a **"Comment Limit Settings"** details group to
    the comment type edit form (`/admin/structure/comment/manage/{comment_type}`, core route
    `entity.comment_type.edit_form`, gated by core permission **`administer comment types`**). Fields:
    `Limit` (number, min 1, default 5), `Interval Number` (number, min 1, default 1),
    `Interval Unit` (select: hour/day/week/month, default hour), `Fields` (multi-select of the
    comment type's field definitions, minus `cid`/`uuid`/`comment_type`). Registers an
    `#entity_builders` callback.
  - `comment_submissions_limit_comment_form_builder` — writes the four values into the comment
    type entity as **third-party settings** under the `comment_submissions_limit` namespace
    (`limit`, `interval_number`, `interval_unit`, `fields`).
  - `hook_form_comment_form_alter` — appends `comment_submissions_limit_comment_form_validate` to
    the comment form's `#validate`.
  - `comment_submissions_limit_comment_form_validate` — the enforcement (see subdoc). Reads the
    third-party settings, builds a comment entity query filtered by `comment_type`, `created >
    (now − interval)`, and one `=` condition per selected field (submitted value), counts up to
    `limit`, and if `count == limit` sets a form error on every selected field.
- **`src/Interval.php`** — `final class Interval` value object (`number`, `unit`), constructor
  whitelists unit to `minute|hour|day|week|month|year` (throws `InvalidArgumentException`
  otherwise). `subtract(DrupalDateTime)` returns `now − interval` with a month-end clamp
  (Mar 31 − 1 month → Feb 28, not Mar 3).
- **Config schema** (`config/schema/comment_submissions_limit.schema.yml`) — third-party settings
  schema `comment.type.*.third_party.comment_submissions_limit` (limit int, interval_number int,
  interval_unit string, fields array).

## What it does NOT provide

- **No permission** of its own (no `.permissions.yml`, no `hook_permission`). Access to the
  settings comes entirely from the core comment-type-edit form's `administer comment types`
  permission.
- **No routes, services, controllers, blocks, plugins, install/update hooks, or templates.**

## Solution docs

- **Settings, enforcement/count query, Interval math** → [config/settings.md](config/settings.md)
