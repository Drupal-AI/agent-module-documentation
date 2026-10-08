# Configuration

Go to **Configuration → Content authoring → Content lock**
(`/admin/config/content/content_lock`). The form requires the **Administer
content lock** permission, and everything you set is stored as exportable
configuration so it deploys between environments.

## Which content is lockable

- **Entity types and bundles** — the heart of the form. For each supported
  content entity type you choose whether locking is on, and whether it applies to
  all bundles or only specific ones (for example, lock only the Article and Basic
  page content types, leaving media and users unlocked). Only content entity
  types with a numeric ID can be locked, so those are the only ones offered.

## Locking behavior

- **Verbose** *(on by default)* — show a message to the editor when their edit
  locks the content, and to a second user when they are blocked. Turn it off for
  a quieter experience.
- **Translation‑level locking** — lock individual translations rather than the
  whole entity, so different editors can work on different languages of the same
  content at once. This requires the **Conflict** module to be installed before
  you can enable it in the UI.
- **Form‑operation locking** — by default an entity is locked whenever any of its
  forms is opened. You can narrow this per entity type using one of three modes:
  - **Disabled** *(default)* — lock regardless of which form is opened.
  - **Allowlist** — lock *only* for the form operations you list (for example the
    default edit form, but not a separate layout or delete form).
  - **Denylist** — lock for every form operation *except* those you list.

  This lets users edit *different* forms of the same entity concurrently when
  that is safe.

## Lock timeout

- **Timeout** — how long, in minutes, before an abandoned lock is considered
  stale (default 30 minutes; stored internally in seconds). A stale lock can then
  be broken so editing can resume. Clear the field to disable timeout‑based
  breaking entirely.

  Note that the base module records the timeout but does not by itself
  auto‑release stale locks — that behavior comes from the (deprecated)
  **Content Lock Timeout** submodule, or you can break stale locks manually.

## Breaking a lock

When a lock is holding up work, it can be broken from the entity's break‑lock
page, which releases it so anyone can edit again. Access is granted to a user who
either holds the **Break content lock** permission, or already owns the lock
themselves (so people can always release their own lock).

## Permissions

Content Lock defines two permissions under **People → Permissions**:

- **Administer content lock** — reach this settings form and choose what is
  locked. Keep it to administrators.
- **Break content lock** — forcibly release another user's lock. Give it to
  trusted editorial leads.

## Views integration

Content Lock ships Views building blocks for editorial dashboards: an **Is
locked** filter, a **Break link** field (unlock inline from a listing), a sort,
and a matching access check — plus a bulk **Break Lock** action.
