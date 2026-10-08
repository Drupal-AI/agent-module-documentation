# Configuration

Comment Delete has **no central settings page**. You configure it **per comment
field**, and you control who can do what through its permissions. This page covers both.

## Configure a comment field

1. Find your comment field's edit form — from a content type's **Manage fields**, or via
   **Structure → Comment types → Manage fields** — and edit the comment field (for
   example `comment` on Article, or `comment_forum` on a forum).
2. Scroll to the **"Comment Delete"** section and set the options below.
3. Save the field.

Because the settings live on the field, different comment fields can behave differently.

### The options

- **Operation(s)** — which deletion behaviours are offered. Tick any of:
  - **Hard** — delete the comment *and* its replies.
  - **Partial hard** — delete the comment but move its replies up one thread level, so
    the conversation stays readable.
  - **Soft** — delete the comment but keep its replies.

  If you tick none, the field falls back to core's default deletion behaviour.
- **Visibility** — how the operation chooser appears on the delete confirmation form:
  **visible** (always show the choices), **visible when multiple** (only show them when
  the user actually has more than one option), or **invisible** (hide them and always
  use the default operation).
- **Label** — optional per-operation label overrides (for example, call soft delete
  "Redact comment").
- **Message** — optional per-operation confirmation messages shown after deleting;
  these support comment tokens.
- **Mode** (for soft delete) — **unset** blanks the comment's subject and non-base
  fields, while **unpublished** instead sets the comment unpublished (which keeps the
  thread levels intact).
- **Anonymize** — with the *unset* soft-delete mode, reassign the deleted comment's
  author to the Anonymous user.
- **Default** — the pre-selected operation (must be one of the allowed operations
  above); it's the one used when the chooser is hidden.
- **Time limit** / **Timer** — when the time limit is on, ordinary delete permissions
  expire *Timer* seconds after the comment was created — giving authors a time-boxed
  "undo" window. The "anytime" permissions (below) ignore this.

### Setting it from the command line

The settings are stored as third-party settings on the comment field's config entity,
`field.field.<entity>.<bundle>.<field>`. Read one back with, for example:

```bash
drush cget field.field.node.forum.comment_forum third_party_settings.comment_delete
```

## Permissions

At **People → Permissions**, the module adds both fixed permissions and per-field ones.

### Static permissions

| Permission | Grants |
|---|---|
| **Administer comment delete settings** | the module's admin flag. |
| **Delete own comment** | delete comments you authored (respects the time limit). |
| **Delete own comment anytime** | delete your own comments, ignoring the time limit. |
| **Delete any comment** | delete any comment (respects the time limit). |
| **Delete any comment anytime** | delete any comment, ignoring the time limit. |

### Per-field permissions

For **every** comment field on the site, the module also generates permissions scoped
to that entity type + bundle + field, so you can grant rights on a per-field basis:

- **delete own / delete any** (and their *anytime* variants) — whether a user may
  delete their own, or anyone's, comments in that field.
- **delete replies** (and *anytime*) — delete an immediate reply to your own comment.
- **allow &lt;operation&gt; delete** — these gate *which operations appear* in the
  confirmation form. A user only sees the **hard**, **partial hard** or **soft** choice
  if they hold the matching "allow" permission — so you can, say, let regular users
  soft-delete while reserving hard delete for moderators.

In short: the **delete …** permissions decide *whether* someone can delete a comment;
the **allow … delete** permissions decide *which operations* they're offered. The
"anytime" variants bypass the field's time limit.
