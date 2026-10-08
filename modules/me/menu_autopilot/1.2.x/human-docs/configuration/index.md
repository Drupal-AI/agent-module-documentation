# Configuration

Setting up Menu Autopilot in 1.2.x has two layers: a **settings page** that
decides which menus the module is allowed to touch and the defaults it uses, and
the **per-link "Menu Autopilot: children of …" section** where you turn an
individual link into a dynamic parent.

## The settings page

1. Log in as a user with the **Administer Menu Autopilot** permission (see
   [Permissions](#permissions) below).
2. Go to **Structure → Menu Autopilot** (`/admin/structure/menu/autopilot`).
3. Configure:
   - **Managed menus** — the menus Menu Autopilot is allowed to sync. **Only
     these menus are ever touched.** By default this is the **main** menu. If you
     mark a link as a dynamic parent in a menu that is *not* on this list, the
     setting is stored but never acted on — so if your dynamic parent seems
     inert, check that its menu is managed here.
   - **Default sort** — the default child order applied to new dynamic parents:
     A→Z (`title_asc`), Z→A (`title_desc`), newest first (`created_desc`),
     oldest first (`created_asc`), or **Keep current order** (`preserve`).
   - **Default limit** — the default maximum number of children for new dynamic
     parents (`0` means unlimited).
4. Save. Saving reconciles the managed menus immediately.

## Turn a menu link into a dynamic parent

1. Go to **Structure → Menus** (`/admin/structure/menu`) and edit a link in a
   **managed** menu.
2. Open the **"Menu Autopilot: children of …"** section on the link's edit form.
   (This section never appears on a link that Menu Autopilot generated itself — a
   managed child instead shows a short notice pointing you back to the parent.)
3. Choose what **children come from**:
   - **Nothing (curated by hand)** — the link stays curated (clears any
     dynamic-parent setting).
   - **Nodes tagged with a taxonomy term** — children are the published nodes
     tagged with a chosen term. You pick the **reference field** (the node field
     that references terms, offered as a list — no machine-name typing) and the
     **term** itself; you can optionally narrow by **content type**.
   - **All nodes of a content type** — children are all published nodes of a
     chosen content type.
   - **A hand-picked list of nodes** — children are a hand-picked, ordered list of
     nodes you add by autocomplete; unpublished nodes are skipped.
4. For the term and bundle sources, set **Sort children by** (A→Z, Z→A, newest,
   oldest, or **Keep current order**) and a **limit** (`0` = unlimited).
5. Optionally set a **Child menu label** — a token pattern for the child label,
   for example `[node:title]` or `[node:title] [node:field_subtitle]`. Leave it
   blank to use the node title. (URIs are never tokenized — only the visible
   label. Special characters such as `&` are stored literally, not escaped.)
6. Save the link. The parent's children are reconciled immediately, and stay in
   sync automatically on later content publish/update/unpublish/delete.

The form validates the fields each source needs (a term source needs a reference
field and a term; a bundle source needs a content type; a manual source needs at
least one node) and shows any error inline on the relevant field.

## Keep current order (drag-and-drop)

Set **Sort children by → Keep current order** on a term or bundle source and the
module leaves existing child weights alone, so you can drag the children into any
sequence on the menu overview. New matching nodes append after the current last
child rather than jumping into the middle, and unpublished/deleted nodes are still
removed automatically. The A→Z and date sorts, by contrast, rewrite the order on
every sync. (A hand-picked list always follows the order you entered the nodes.)

## The "Existing children" policy

When the parent already has children, the **Existing children** radios decide
what happens to them:

- **Reuse matching links (keep extras)** *(default)* — reuse hand-created links
  that already point at a source node, and leave any curated extras alone.
- **Reuse matching links, remove extras** — reuse matches, and delete unmanaged
  extras that are not in the source.
- **Add missing children only** — only create links for source nodes that have no
  child yet; change nothing that already exists.
- **Replace all children** — delete all unmanaged children, then build the managed
  set from scratch.

There is also a **Move matching links from elsewhere in this menu** checkbox: move
unmanaged links from elsewhere in the *same menu* that already point at a source
node under this parent, then apply the policy above. Links owned by another
automatic parent are left alone. Matching is done by node URIs and path aliases,
so existing links are recognised as the same destination rather than duplicated.

## Editing an automatic child's page

When you edit a node that appears in a managed menu as an automatic child, the
node form shows a read-only **Menu link** notice instead of core's "Provide a menu
link" widget. Its label and order are owned by the parent's Menu Autopilot
section, so edit the parent to change them. Saving the node's other fields no
longer disturbs the managed link (earlier versions could fatal or trip a
pending-revision menu constraint here).

## Permissions

Grant under **People → Permissions** (`/admin/people/permissions`):

- **Administer Menu Autopilot** (`administer menu autopilot`) — gates the settings
  page (choosing managed menus and the default sort/limit). This is marked as a
  security-sensitive permission, so grant it only to trusted site builders.

The per-link **"Menu Autopilot: children of …"** section is not gated by a
separate Menu Autopilot permission — it rides on the standard menu-link edit form,
so it is available to anyone who can administer that menu through core's own menu
permissions.

## Drush commands

Both commands act only on the managed menus and are safe to run repeatedly (a
second run makes no changes):

- **Rebuild everything** — reconcile every dynamic parent (create, reorder,
  rename, prune from published content). Use after a bulk import, after changing a
  parent's source, or on a schedule as a self-healing pass:

  ```bash
  drush menu-autopilot:rebuild
  # short alias:
  drush ma:rebuild
  ```

- **Normalize URIs** — rewrite any managed link that targets an editorial or
  internal node route (for example `/node/12/latest` or `internal:/node/12`) to a
  canonical `entity:node/<nid>` URI, so it resolves to the node's real path alias
  instead of 404-ing a decoupled front end. A handy one-time cleanup when adopting
  the module; already-canonical links are untouched:

  ```bash
  drush menu-autopilot:normalize-uris
  # short alias:
  drush ma:fix-uris
  ```
