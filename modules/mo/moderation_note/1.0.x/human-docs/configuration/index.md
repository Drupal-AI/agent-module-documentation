# Configuration

## Prerequisites

Moderation Note sits on top of core Content Moderation, so before notes can appear:

1. Enable and configure a **content-moderation workflow** (under **Configuration →
   Workflows**) on the entity types and bundles you want to annotate. Notes attach to
   the **latest revision** of moderated entities.
2. Make sure reviewers can reach Draft (latest, unpublished) revisions to annotate
   them — grant editorial roles the core **View the latest version** permission, and
   usually **View any unpublished content** too.

## The settings page

There is a single option, at **Configuration → Moderation note**
(`/admin/config/moderation-note`, requires **Administer moderation notes**):

- **Send email notifications** — the master switch for all note emails. It is **on**
  by default. Turn it off to silence every notification.

## Email notifications

When notifications are on, the module emails the relevant people as notes move through
their lifecycle:

- **Note created** — the moderated entity's creator and last editor.
- **Note assigned** — the assignee.
- **Note resolved, re-opened, or replied to** — the entity's creator and last editor,
  the assignee (if any), and everyone who replied to the note.
- **Note deleted** — no email.

To customise the wording, override the mail template
`templates/mail-moderation-note.html.twig` in your theme.

## Permissions and the access model

Grant these under **People → Permissions** to your editorial roles. Access to notes
is deliberately tied to the moderated content's own access, so notes are never visible
to anyone who cannot already see the content.

| Permission | What it allows |
|------------|----------------|
| **Access moderation notes** | View notes (and the note lists). A holder can read all notes on any content they can view — this is the intended collaborative design, bounded by the content's view access. |
| **Create moderation notes** | Add notes on content the user can edit. |
| **Create moderation notes on uneditable entities** | Add notes even when the user cannot edit the content. |
| **Create moderation note replies** | Reply to an existing note. |
| **Resolve moderation notes on editable entities** | Resolve someone else's note, provided the user can edit that content. |
| **Administer moderation notes** | Full control over all note operations. This one is marked *restrict access* — grant it only to trusted roles. |

Editing or deleting a note is otherwise limited to the note's own author (plus the
administer permission). Resolving a top-level note is allowed for the note owner, an
administrator, or someone who can edit the content and holds the resolve permission.

## How reviewers use it

Once workflows and permissions are set up, a reviewer opens the latest revision of a
moderated entity, selects text in a field, and clicks **Add note**. The note (and any
replies) show in an off-canvas sidebar. Notes can be assigned to a colleague — who
then sees them in their **Assigned notes** toolbar tab and at
`/user/{uid}/moderation-notes` — and resolved once addressed. There is no per-bundle
configuration to do beyond the workflow itself; the note entity is not fieldable and
has no bundles of its own.
