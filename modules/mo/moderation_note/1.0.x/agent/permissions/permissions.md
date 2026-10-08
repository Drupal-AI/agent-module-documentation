# Permissions — the access model

Defined in `moderation_note.permissions.yml`:

| Permission | Gates |
|---|---|
| `access moderation notes` | View moderation notes (see the note view + list/assigned-list routes). |
| `create moderation notes` | Create notes on entities the user can edit (and unconditionally per `_moderation_note_on_entity`). |
| `create moderation notes on uneditable entities` | Create notes when the user **cannot** update the entity (`entity->access('update')` is forbidden). |
| `create moderation note replies` | Reply to an existing note. |
| `resolve moderation notes` | (title only) part of the resolve flow. |
| `resolve moderation notes on editable entities` | Resolve someone else's note if the user can update the moderated entity. |
| `administer moderation notes` | Full override for all note operations; also the entity `admin_permission`. **`restrict access: true`.** |

## Access logic (from `AccessControlHandler` + `_moderation_note_on_entity`)
Access is intentionally coupled to the **moderated entity's** own access, so notes never leak beyond
who may see/edit the content:

- **view** — `access moderation notes` (or admin) **AND** `view` access to the moderated entity.
- **create** (route `moderation_note.new` custom access & `checkCreateAccess`) —
  `create moderation notes`, **or** `create moderation notes on uneditable entities` when the user's
  `update` access to the entity is forbidden, **or** admin.
- **update / delete** — only the **note owner** (uid match) or admin; update also requires the note
  be published; delete also requires the note is a reply or is unpublished.
- **reply** — `create moderation note replies` **or** `create moderation notes` **or** admin.
- **resolve** — note owner, **or** admin, **or** (`resolve moderation notes on editable entities`
  **and** `update` access to the moderated entity); only for top-level notes (no parent).

## Recommended grants (from README)
Give note users core `view latest version` and often `view any unpublished content` too, so they can
reach Draft (latest, non-default) revisions of Published content in order to annotate them.

## Notes for reviewers
- `access moderation notes` lets a holder read **all** notes (including other users' notes and
  replies) on any content they can view — this is the intended collaborative design, not a leak:
  visibility is bounded by the moderated entity's view access.
- None of the non-admin permissions is `restrict access: true`; scope them to editorial roles.
