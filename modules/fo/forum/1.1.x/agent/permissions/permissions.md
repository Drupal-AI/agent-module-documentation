# Permissions

Forum defines **one** permission of its own (in `forum.permissions.yml`); the rest of the
access model comes from the standard node and comment permissions for the forum bundle.

| Permission | Machine name | Gates |
|---|---|---|
| Administer forums | `administer forums` | Every admin route (`forum.overview`, add/edit/delete container & forum, `forum.settings`). This is the only forum-owned permission. Restricted/trusted only. |

Grant it with drush:

```bash
drush role:perm:add editor 'administer forums'
```

## Related core permissions (needed for a working board)

These are **not** defined by the forum module but govern the actual forum content and
replies (they come from node and comment for the `forum` / `comment_forum` bundles):

- `access content` — required to view `/forum` and `/forum/{term}` (see `forum.routing.yml`).
- `create forum content` — start new forum topics (node type `forum`).
- `edit own forum content` / `edit any forum content` — edit topics.
- `delete own forum content` / `delete any forum content` — delete topics.
- `access comments`, `post comments`, `skip comment approval` — read and reply to topics
  (comment type `comment_forum`).

So a typical "authenticated forum member" role gets `access content`, `create forum
content`, `edit own forum content`, `access comments`, `post comments` — and NOT
`administer forums`, which is reserved for moderators/admins who manage the board tree and
settings.
