# Configuration

There is no single global on/off switch. Setting up Workbench Moderation is three
steps: turn moderation on for each content type, (optionally) adjust the states
and transitions, and grant the workflow permissions to your roles.

## Step 1 — turn moderation on for a content type

1. Go to the content type's edit page and open its **Moderation** tab — for
   example *Structure → Content types → Article → Moderation*.
2. Tick **Enabled** to switch moderation on for this bundle. (This forces
   revisions on for the type — a moderated bundle must keep revisions.)
3. Under **Allowed moderation states**, choose which states editors may use here
   (by default all four: Draft, Needs Review, Published, Archived).
4. Set the **Default moderation state** — the state new content of this type
   starts in. It must be one of the allowed states; **Draft** is the usual choice.
5. Save.

From now on, editing that content type shows a **moderation state** selector, and
each moderated item gains a **"Latest version"** tab showing the newest forward
(draft) revision. When someone saves, the chosen state decides what happens: a
**Published** state updates the live version, while **Draft** or **Needs Review**
create a forward draft that leaves the live version untouched.

Repeat for every content type that needs a workflow.

## Step 2 — review states and transitions (optional)

The module's admin area lives at **Structure → Workbench moderation**
(`/admin/structure/workbench-moderation`). The defaults suit most sites, but you
can customise them:

- **States** (`/admin/structure/workbench-moderation/states`) — the four default
  states are Draft, Needs Review, Published, Archived. Each state has two key
  flags: **Published** (content in this state is live) and **Default revision**
  (saving into this state makes it the default revision rather than a forward
  draft). You can add your own states here — for example a "Legal review" state.
- **Transitions** (`/admin/structure/workbench-moderation/transitions`) — a
  transition is an allowed move **from** one state **to** another, with a label
  like "Publish". The defaults wire up the usual Draft → Needs Review → Published
  → Archived flow (and back). Add a transition to connect any custom states you
  create.

Managing states and transitions requires the **Administer moderation states** and
**Administer moderation state transitions** permissions (both are marked as
restricted, so grant them only to trusted administrators).

## Step 3 — assign the workflow permissions

This is how you map workflow steps to roles. Go to **People → Permissions** and
grant, per role:

- **Per‑transition permissions** — each transition creates its own permission,
  named `use <transition> transition` (for example *use draft_needs_review
  transition*, *use needs_review_published transition*). A user can only perform a
  transition if they hold its permission. So you might give authors
  *use draft_needs_review transition* and give editors
  *use needs_review_published transition*, enforcing that a second person
  publishes. (After adding a new transition, rebuild permissions / clear caches so
  its permission appears.)
- **View any unpublished content** — required for any moderator to see
  unpublished content across the site.
- **View latest version** — see the newest forward (draft) revision via the
  "Latest version" tab (also needs *View any unpublished content*).
- **View moderation states** — view the moderation states listing.
- **Moderate entities that cannot edit** — lets a user use the moderation form
  even when they don't have edit access to the entity, so reviewers can advance
  content they may not otherwise edit.

## Views and automation

Workbench Moderation adds a **"Latest revision"** filter and moderation
fields/filters to Views, which you can use to build an editorial dashboard (for
example, a list of items currently in Needs Review). For custom behaviour on each
moderated save, developers can subscribe to the module's state‑transition event —
see the [`agent/events/events.md`](../../agent/events/events.md) reference.
