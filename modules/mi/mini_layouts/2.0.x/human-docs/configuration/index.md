# Configuration

Mini layouts are managed at **Structure → Mini Layouts**
(`/admin/structure/mini_layouts`), which is a list of all the reusable sections
you've created. Everything here requires the **administer mini layouts**
permission. Creating one is a two-step process: first a short settings form, then
the Layout Builder canvas.

## Step 1 — The settings form

Click **Add mini layout** (`/admin/structure/mini_layouts/add`), or edit an
existing one. The form has:

- **Administrative Label** — the name shown when you're placing the block in the
  block chooser. It's for site builders, not end users.
- **Machine name** — the internal id, generated from the label.
- **Category** — how the mini layout is grouped in the block chooser. Leave it
  empty and it's grouped under "Layouts".
- **Required Context** — an optional table where you declare contexts the layout
  needs in order to render context-aware content. For each one you give a label, a
  machine name, a type (chosen from the available typed-data definitions, e.g.
  `entity:node`), and whether it's required. Each entry becomes a context
  definition on the resulting block, so when you place the block you'll be asked to
  map a matching value — for example the current node — which the blocks inside the
  mini layout can then use.

Save the form to create the mini layout.

## Step 2 — The layout

Open the mini layout's **Layout** tab to get the familiar core **Layout Builder**
canvas. Here you add sections (one/two/three column and so on) and drop blocks into
them — this is the reusable unit you're composing. Save when you're done.

## Placing the mini layout

Every saved mini layout is exposed as a block. Place it like any other block:

- In a **theme region** via **Structure → Block layout**, or
- Inside another **Layout Builder** section (for example on a node or page layout).

In the block chooser it appears under its **category** (or "Layouts") with its
**administrative label**. If you declared any **required contexts**, the chooser
will prompt you to map a matching context (such as the current node) when you place
it.

## Good to know

- **Central reuse:** editing a mini layout updates *every* place it's been
  placed — that's the intended behavior, so you can standardize hero bands,
  CTAs, or footer stacks once and have every page reflect a change.
- **Deployable config:** a mini layout's sections are stored as standard
  configuration (`mini_layouts.mini_layout.<id>`), so you can export mini layouts
  and deploy them across environments like any other config.
- There is **no global settings page** — the "configure" link for this module just
  takes you to the Mini Layouts list described above.
