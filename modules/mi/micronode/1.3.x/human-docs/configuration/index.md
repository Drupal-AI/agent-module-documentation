# Configuration

Micronode has **no central settings page**. Instead, you flag content types one at a
time on their own edit form. The flag is stored as a per‑type setting, so it travels
with the content type's configuration.

## Mark a content type as micro-content

1. Go to **Structure → Content types**, and edit the type you want to treat as
   micro‑content (`admin/structure/types/manage/{type}`).
2. Open the **Micro‑content settings** vertical tab (near the other tabs like Menu
   settings and Display settings).
3. Tick **Is micro‑content**.
4. Click **Save**.

That's it — the type is now micro‑content. You can untick the box and save later to
turn it back into a normal content type at any time. Whenever you toggle the flag,
the module clears all cache bins so listings and views update immediately.

## What flagging a type does

Once a type is flagged:

- **Its nodes lose their public page.** For anyone who can't *update* the node,
  visiting its canonical `/node/{id}` page returns "access denied." Editors (users
  with update access) can still open the node — this is how they edit it.
- **The node still renders when embedded.** Only the node's own page is blocked; the
  node continues to render normally inside reference fields, views, and layouts. So a
  card or snippet shows up wherever you place it, just not as a standalone URL.
- **It's removed from the "Add content" chooser.** Micro‑content types no longer
  appear on the standard `/node/add` page (unless you use Type Tray, which takes over
  that page).
- **It gets a dedicated add page.** Editors create micro‑content from
  `/node/add-microcontent`, which lists only the micro‑content types. Access to that
  page is granted to users who can create at least one micro‑content type.
- **Admin Toolbar links are regrouped.** With `admin_toolbar_tools` installed, the
  "add" links for micro‑content types move under their own **Add Micro‑Content**
  toolbar section.
- **New Views exclude it by default,** and micro‑content bundles are dropped from
  exposed content‑type filters when the micronode Views filter is used.
- **It's hidden from entity autocompletes,** so micro‑content nodes don't clutter
  reference‑field suggestions unless a given autocomplete explicitly allows them.

## Using the Views filter

The module adds a boolean **Is Micro‑content** filter you can add to any node View to
include or exclude micro‑content nodes.

**Important one‑time step:** on a content type that existed *before* you installed
the module, the flag is unset (neither true nor false) until you re‑save the type
once. The Views filter only recognizes types whose flag is an explicit yes or no. So
after installing the module, open and **save each content type once** (even without
changing anything) so the flag initializes and the filter sees every type correctly.
