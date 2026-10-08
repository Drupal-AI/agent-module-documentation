# EVA — manual setup guide

**EVA** (Entity Views Attachment, machine name `eva`) lets you take the output of a
View and attach it directly to an entity — a node, a user, a taxonomy term, a
comment, or any content entity — where it appears as an extra field on that
entity's display. Instead of building a page or a block, EVA gives a View a new kind
of *display* that renders inside another entity's page.

The classic use cases are "related content" listings: a "More by this author" list
on a user profile, a "Related articles" block under a node, a term's tagged content
shown right on the term page, and so on. Because EVA passes the *current* entity to
the View as a contextual filter argument, the same View automatically shows the
right results for whichever entity is being viewed — no custom code required.

Once you add an EVA display to a View, EVA exposes it as a pseudo‑field on the
target entity type's **Manage display** page. From there you position it among the
entity's real fields, reorder it, or turn it off per view mode, exactly like any
other field. EVA depends only on core's Views module; the optional
[Token](https://www.drupal.org/project/token) module adds a handy token browser to
the arguments form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the services,
hooks, and template internals — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

EVA has no central settings page of its own, so everything you need to set it up is
covered in *How to use it* below.

## Where it lives in the admin menu

EVA has **no admin settings form**. You configure it in two familiar places:

- On a **View** — you add an "EVA" display to a View at
  **Structure → Views** (`/admin/structure/views`).
- On the target entity's **Manage display** page — for a content type, that's
  **Structure → Content types → (your type) → Manage display**.

## How to use it

Attaching a View to an entity is a three‑step process.

**1. Add an EVA display to your View.** Edit (or create) a View at
`/admin/structure/views`. Under **Displays**, click **+ Add** and choose **EVA**.
This display has no path and no block — it renders through the entity it is attached
to.

**2. Tell the display what to attach to and what to pass.** In the display's
**Entity content settings** section, configure:

- **Entity type** *(required)* — the content entity type this View attaches to
  (node, user, taxonomy term, etc.). Changing it resets the bundle selection.
- **Bundles** — tick the specific bundles you want. If you leave them all
  unticked, the View attaches to *every* bundle of that entity type.
- **Arguments** — how the current entity is fed into the View's contextual filter:
  - *None* — pass nothing.
  - *Entity ID* — pass the entity's ID (e.g. the node ID or user ID).
  - *Token* — replace a slash‑separated token string against the current entity and
    pass the result. For example, `[node:author:uid]` passes the node author's user
    ID, so you could list that author's other posts. Separate multiple arguments
    with `/`.
- **Show title** — render the View's title above its output.
- **Hide output if the view is empty** — render nothing when the View has no
  results.
- **Disable by default** — add the new pseudo‑field to the *disabled* region on
  Manage display, so editors have to opt it in per display.

For the argument to do anything, your View needs a matching **contextual filter**
(argument) — for instance "Content: Authored by (uid)" or "User: Uid" — that
consumes the value EVA passes in. Install the optional **Token** module to get a
token browser under the arguments field.

**3. Place it on the entity display.** Go to the target entity's **Manage display**
page (for nodes, `/admin/structure/types/manage/{bundle}/display`). You'll see a new
row named after your View. Drag it to reorder it among the real fields, move it
between regions, or disable it for particular view modes — just like a field. If
your View uses an exposed filter, EVA also offers a second pseudo‑field so you can
render the exposed form separately.

> **Watch out for infinite loops.** If your EVA View renders entities using a view
> mode, do **not** include the EVA field itself in that same view mode — the render
> will recurse endlessly.
