# Configuration

Layout Builder IPE works as soon as it is enabled — the **Customize** link appears
on Layout Builder‑enabled pages for users with the right permissions. Beyond that,
the module has a **settings form** (configuration route
`layout_builder_ipe.config`) for its optional and experimental behaviours, and it
adds its own **permissions**.

## Permissions

Because IPE lets people rearrange a page's layout directly on the front end, treat
its permissions the way you would any layout‑management capability — grant them
only to trusted editorial roles. Go to **People → Permissions**
(`/admin/people/permissions`) and set the module's permissions per role, including
**Break locks on Layout Builder IPE**, which lets a user take over an editing
session that another user has locked on a content entity.

Remember that these permissions govern the *editing UI*; the underlying right to
edit an entity's layout still comes from Layout Builder's own permissions. A user
needs both.

## Settings form

The settings form is where you enable the module's optional behaviours. The main
options are:

- **Hide local tasks while editing** — removes the local task tabs from view while
  a layout is being edited in place, for a cleaner editing surface.
- **Position blocks at a specified position** — adds controls to place a block at
  a specific position rather than always appending it. This is **experimental** and
  may interfere with other Layout Builder contrib modules that modify the "Add
  block" button, so test it against the rest of your Layout Builder stack.
- **Override the default EntityChangedConstraint** — replaces core's simple
  "changed time" check with smarter logic to decide whether an entity can be saved.
  This is also **experimental** and can cause issues in more complex setups, so
  enable it only after testing.

The module also enforces **non‑concurrent editing** (one editing session per user)
and **content locking** (one editing session per content entity), so editors do
not clobber each other's in‑progress layout changes; locks can be broken by users
who hold the break‑locks permission described above.

Turn on only the behaviours you need, save the form, and verify the editing
experience on a test page before rolling it out to editors.
