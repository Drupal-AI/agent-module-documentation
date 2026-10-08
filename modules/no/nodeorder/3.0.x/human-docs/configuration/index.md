# Configuration

Setting up Node Order is a three-part job: **make a vocabulary orderable**,
**arrange the content** within its terms, and (optionally) **sort a View** by that
manual order. There's also a small settings form for display options.

## Step 1 — Make a vocabulary orderable

A vocabulary only becomes orderable once you switch it on. There are two equivalent
ways:

**From the vocabulary's edit form** (the usual way):

1. Go to **Structure → Taxonomy** and edit the vocabulary
   (`/admin/structure/taxonomy/manage/<vocabulary>`).
2. In the **Node Order** section, tick **Orderable**.
3. **Save**.

**From the Node Order settings form:**

1. Go to **Configuration → Content authoring → Node Order**
   (`/admin/config/content/nodeorder`).
2. Under **Vocabularies**, tick the vocabularies you want to be orderable.
3. **Save configuration**.

Either way, toggling a vocabulary runs a short batch process that assigns starting
positions to every existing content/term pairing in that vocabulary (and cleans
them up again if you turn it off). This needs the **Administer nodeorder**
permission.

## Step 2 — Order the content within a term

Once a vocabulary is orderable, every term in it gets an **Order** tab:

1. Visit a term and open its **Order** tab, or go straight to
   `/taxonomy/term/{term-id}/order`.
2. You'll see a drag-and-drop table of all the content filed under that term.
3. Drag the rows into the order you want and click **Save**.

This requires the **Order nodes within categories** permission. New content, and
content newly tagged into an orderable term, is automatically placed at the top of
the list; removing content rebalances the remaining order for you.

## Step 3 — Sort a View by the manual order

Node Order exposes the manual position to Views as a **Nodeorder** sort and field
(on the taxonomy index). To make a listing respect your ordering:

1. Edit a View that lists content by taxonomy term (for example the *Taxonomy term*
   view that powers the default term pages).
2. Add the **Nodeorder** sort criterion, ascending.
3. Save. The listing now shows content in the order you arranged.

## The settings form, field by field

At **Configuration → Content authoring → Node Order**
(`/admin/config/content/nodeorder`) you'll find these options in addition to the
Vocabularies checkboxes:

- **Show links on node** — whether "ordering" links appear on a node, and for which
  categories: *don't show them*, *show them for all the node's categories*, or *show
  them only for the currently active category*.
- **Link to ordering page** — show the **Order** tab on the term / node-order pages.
- **Link to ordering page (taxonomy admin)** — also show the **Order** tab on the
  taxonomy administration pages, so admins can jump to ordering from there.
- **Override taxonomy page** — replace Drupal's default term page with Node Order's
  own version, which renders content in the manual order. Turn this off if you
  prefer to control the term listing yourself with a View.
- **Entity list limit** — how many nodes to show per page on the drag-and-drop
  ordering screen (default **50**). Lower it if your terms hold a lot of content and
  the ordering page gets unwieldy.

Click **Save configuration** to apply.

## Permissions

- **Order nodes within categories** — grant to editors so they can use each term's
  Order tab and save a new order.
- **Administer nodeorder** — grant to administrators; controls the settings form and
  which vocabularies are orderable site-wide, so treat it as an administrative
  permission.

## A note on storage

Node positions are not stored as config or as a field — they live in a `weight`
column the module adds to the taxonomy index (one row per content item per term).
That means the manual order is content data, not configuration, so it won't travel
through a config export/import; only the *settings* (which vocabularies are
orderable, and the display options) are configuration.
