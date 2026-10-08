# Configuration

Geysir has no settings form. Setting it up is really two things: making sure you have
a node with a Paragraphs field, and granting the one permission — carefully.

## Prerequisites for the buttons to appear

Geysir only renders its front-end action buttons when **all** of the following are
true for the node you're viewing:

- the node has an **Entity Reference Revisions** field targeting **paragraph**
  entities (nested-paragraph parents are skipped — the parent must be a node),
- the current user has the **Manage Paragraphs from the front-end** permission,
- the current user can update the node (`update` access), and
- you're viewing the **latest, default-language revision** (for translating, view a
  translated version of the node).

Field cardinality and required fields are respected: *Add* hides when the field is
full, and you can't delete the last item of a required field.

## Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant **Manage
Paragraphs from the front-end** to the roles that should edit paragraphs in place.
Then reload a Paragraph-based node: hover a paragraph to reveal the Add / Edit /
Delete / Cut / Paste / Translate buttons. Use the **Geysir toolbar tab** to toggle the
buttons on or off while you work.

## Who should get this permission

The `/geysir/...` action routes behind the buttons require the *Manage Paragraphs
from the front-end* permission. Recommended handling:

- Grant it only to roles you already trust to edit site-wide content.
- Keep it on the same roles that already hold the relevant node **update**
  permissions.

## Extending the action links (developers)

The only extension point is `hook_geysir_paragraph_links_alter()`, which lets a custom
module add, remove, or reorder the per-paragraph action links — for example to inject
"move up" / "move down" links. See the [`agent/`](../agent/start.md) docs for the hook
signature and a code example.
