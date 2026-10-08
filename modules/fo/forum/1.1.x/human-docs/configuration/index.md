# Configuration

Setting up a forum involves three things: building the tree of containers and
forums, tuning the global settings, and granting the permissions your members
need. You'll also usually place the two forum blocks.

## Build the board structure

1. Log in as a user with the **Administer forums** permission.
2. Go to **Structure → Forums** (`/admin/structure/forum`). This is the
   drag-and-drop tree of your board.

The board is made of two kinds of item:

- **Containers** — grouping-only headings that *cannot* hold topics. Use them for
  top-level sections like "Support" or "General". Add one with **Add container**.
- **Forums** — the actual boards where topics are posted. Add one with **Add
  forum**, and set its parent to a container to nest it.

Drag items to reorder or renest them. Behind the scenes each container and forum
is a taxonomy term in the *Forums* vocabulary, so the tree is just a taxonomy
hierarchy. A validation rule prevents topics from being posted directly into a
container, so every discussion lands in a real forum.

## Global settings

Go to **Structure → Forums → Settings** (`/admin/structure/forum/settings`). The
options are:

- **Topics per page** — how many topics a forum lists before paginating (default
  25).
- **Hot topic threshold** — the number of replies at which a thread is flagged
  "hot" (default 15).
- **Default topic order** — the sort order for a forum's topic list: newest post,
  newest topic, most posts, or fewest posts.
- **Active topics block count** — how many rows the *Active forum topics* block
  shows (default 5).
- **New topics block count** — how many rows the *New forum topics* block shows
  (default 5).

Advanced setups can also point the board at a different taxonomy vocabulary, but
the default *Forums* vocabulary is right for almost everyone.

These settings live in the `forum.settings` config object, so you can also set
them from the command line:

```bash
drush cset forum.settings topics.page_limit 50 -y
drush cget forum.settings --format=yaml
```

## Place the two blocks

At **Structure → Block layout**, place either or both of:

- **Active forum topics** — the threads with the most recent replies.
- **New forum topics** — the most recently created topics.

Each block has its own count setting that overrides the global block limits above.
(There is no separate "forum navigation" block — the container/forum tree renders
on the `/forum` index page itself.)

## Permissions

Forum defines only **one** permission of its own; the rest of the access model
comes from the standard node and comment permissions for the forum content and
comment types. On **People → Permissions**:

- **Administer forums** (`administer forums`) — manage the container/forum tree and
  the settings form. This is the only forum-owned permission; reserve it for
  moderators and admins.

For members to actually read and take part, grant the relevant core permissions
for the forum bundles:

- **Access content** — required to view `/forum` and individual forums.
- **Forum topic: Create new content** — start new topics.
- **Forum topic: Edit/Delete own content** (or *any*) — manage topics.
- **Access comments**, **Post comments**, and optionally **Skip comment
  approval** — read and post replies.

So a typical "forum member" role gets *Access content*, *Create forum content*,
*Edit own forum content*, *Access comments*, and *Post comments* — but **not**
*Administer forums*, which stays with your moderators. For example:

```bash
drush role:perm:add moderator 'administer forums'
drush role:perm:add authenticated 'create forum content'
```
