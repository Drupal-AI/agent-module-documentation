# Publication Date — manual setup guide

**Publication Date** (`publication_date`) adds a `published_at` timestamp field to
every node that records when the node was *first* published — a stable date that
is independent of the mutable `created` and `changed` timestamps. It captures the
real "go-live" moment, so it stays correct even after the content is edited,
unpublished, or re-published.

The field stays empty while a node is unpublished and is stamped with the current
time the first time the node is saved in a published state. From then on it is not
overwritten, so it reliably reflects the original publication moment. Editors with
the right permission see a **"Published on"** datetime widget grouped under the
*Authoring/revision information* tab on the node form — leave it blank to use the
submission time, or set it to back-date or forward-date the record (handy when
migrating historical content or planning a launch date).

The field is revisionable and translatable, can be shown with core's `timestamp`
and `timestamp_ago` formatters, and is exposed as a `[node:published]` token (with
date sub-tokens like `[node:published:custom:Y-m-d]`) for use in patterns,
metatags, and templates. A computed `published_at_or_now` property always returns
a value (the stored timestamp, or the current time when none is set), so display
and embargo code never has to handle a null. On install the module back-fills
existing nodes from their first published revision, and it integrates out of the
box with Feeds, Workbench Moderation, and Node Clone.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Publication Date has no settings form of its own. Its "Published on" widget appears
on the node edit form under the *Authoring/revision information* vertical tab, and
its field can be enabled on any node view display or added to a View. Permissions
are set at **People → Permissions** (`/admin/people/permissions`).

## How to use it

### Showing and editing the date

- **On the node form:** the "Published on" widget appears automatically for users
  with permission. Leave it blank to keep the automatic "stamp on first publish"
  behavior, or enter a date to back-date or forward-date the record.
- **In a view display:** the field is hidden by default. Enable it on **Structure
  → Content types → *(your type)* → Manage display** and choose a formatter — the
  absolute **Timestamp** formatter or the relative **Time ago** formatter
  ("published 3 days ago").
- **In Views:** add the **Published on** field or sort to any node-based view to
  list or order content by its true publication date instead of `created`.

### Permissions

Access to the "Published on" widget is governed by granular permissions. The
global ones are:

| Permission | Grants |
|------------|--------|
| **Administer publication date** | Full edit access to the date on any node. |
| **Set any published on date** | Edit the date for any content type. |
| **View any published on date** | See the date (read-only) for any content type. |

In addition, two permissions are generated **per content type** — for example *Set
article published on date* and *View article published on date* — so you can let
some roles edit the date on one content type while only viewing it on another. On
the node form, a user who can edit sees an editable widget, a user who can only
view sees a disabled (read-only) widget, and everyone else sees no widget at all.

### Tokens

Use `[node:published]` wherever tokens are accepted — for example an
`article:published_time` Open Graph metatag or an RSS `pubDate`. Date sub-tokens
work too, such as `[node:published:custom:Y-m-d]` and `[node:published:short]`.

### Built-in integrations

- **Feeds** — a `published_at` import target lets a feed column populate the field.
- **Workbench Moderation** — the date is stamped when a node transitions to a
  published state.
- **Node Clone / Quick Node Clone** — the date is reset on a cloned node so the
  copy gets a fresh publication date.
- **Scheduler** — the module runs after Scheduler, so content published on a
  schedule records the correct go-live time.
