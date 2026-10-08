# Configuration

Setting up Recently Read is three steps: choose what to track, decide how long to
keep it, and put a history list somewhere your visitors can see it.

## 1. Choose which entity types are tracked

Go to **Structure → Recently read types** (`/admin/structure/recently-read`).
This page lists one entry per tracked entity type. On a fresh install it already
contains one entry for **node** content.

Each entry has:

- A **label / entity type** — the entity type it applies to (for example
  `node`).
- A **bundle list** — optionally restrict tracking to specific bundles. If you
  leave this empty, the *whole* entity type is tracked. If you select bundles
  (for example only *Product* nodes), only those are recorded.

Use the **Add** button to start tracking another entity type — a custom
`recipe`, `course`, or `media` entity, for example. Only entity types that have
an entry here are ever recorded.

Recording is automatic and needs nothing further: whenever a tracked entity is
rendered in its **full** view mode, its view is recorded. Previews and teaser /
other view modes are ignored.

## 2. Pruning / retention settings

Go to **Configuration → System → Recently Read**
(`/admin/config/system/recently-read/config`). You need the **Access
configuration pages** permission. These settings decide how history is trimmed so
the table does not grow forever. Choose a **delete configuration**:

- **Never** — keep all history indefinitely.
- **By time** — set a time expression (for example `-1 month`). On each cron run,
  records older than that are deleted.
- **By count** — set a number N. Each time a new view is recorded, the user's
  history is trimmed to the newest N records.

Set the accompanying **time** or **count** value to match the strategy you
picked, then save.

## 3. Display the history (Views)

The module ships a view named `recently_read_content` that lists the current
user's recently read nodes. To show it:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Recently read content** block in the region you want.

### Building your own history list

To list a different entity type or customize the display, create a view over the
entity you track and:

1. Add the **Recently read** relationship, and tick **Require this
   relationship** so only rows with history are shown.
2. Scope the relationship to the **current user**.
3. Optionally add the **Recently read user filter** (a boolean filter) to limit
   rows to the acting user.
4. Sort by the relationship's **created** date, descending, for
   most‑recent‑first order.

The shipped `recently_read_content` view is a good starting template to
duplicate.
