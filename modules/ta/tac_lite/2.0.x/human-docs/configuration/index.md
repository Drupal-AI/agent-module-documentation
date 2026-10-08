# Configuration

Setting up tac_lite is a five‑step process: create access terms, tell tac_lite
which vocabulary holds them, define one or more schemes, assign grants, and
rebuild permissions. Skipping the rebuild is the single most common reason people
think the module "isn't working."

Everything lives under **Configuration → People → Access by Taxonomy**
(`/admin/config/people/tac_lite`), which requires the **Administer tac_lite**
permission.

## Step 1 — Create a vocabulary of access terms

Before configuring tac_lite, create a taxonomy vocabulary whose terms represent
your access categories — for example a *Department* vocabulary with terms like
*Sales*, *Engineering*, *HR*, or a *Project* vocabulary with one term per client.
Add a term‑reference field for that vocabulary to the content types you want to
control, so nodes can be tagged.

## Step 2 — Select the access vocabulary

On the main settings tab, choose which vocabulary (or vocabularies) tac_lite
should use as access categories. Only terms from the vocabularies you select here
affect access.

There is also a **storage type** option — whether grants store terms by their
numeric **term id (tid)** or by **UUID**. Choose UUID if you deploy configuration
between environments (dev/stage/live) and want the grants to survive, since term
ids can differ between databases. The default is term id.

## Step 3 — Configure one or more schemes

You can define up to **seven** schemes, each on its own tab
(`/admin/config/people/tac_lite/scheme_1`, etc.). A scheme is a bundle of settings
that grants a chosen set of operations in its own access realm. For each scheme
you set:

- **Name** — a label so you can tell schemes apart (e.g. "View access",
  "Editor access").
- **Permissions to grant** — any combination of **grant view**, **grant update**,
  and **grant delete**. This is what the scheme hands out. Keeping view, update
  and delete in separate schemes lets you, say, allow one role to read a category
  while another may edit it.
- **Apply to unpublished content** — when ticked, the scheme's grants also cover
  unpublished nodes, so authorised reviewers can see content that isn't live yet.
  When unticked, only published nodes are affected.
- **Term visibility** — when ticked, the scheme also filters which **terms** a
  user can see (in tag clouds, term pages, and forms), not just which nodes.
  (Users with *administer tac_lite* are exempt from this filtering.)

## Step 4 — Assign grants (roles and users)

Within each scheme you decide who gets which terms:

- **Role defaults** — on the scheme tab, associate roles with terms. Every user in
  that role then receives the scheme's granted operations for content tagged with
  those terms. This is the broad‑strokes assignment.
- **Per‑user grants** — to give one specific person extra access beyond their role,
  open their account edit page and use the **Access by taxonomy** tab
  (`/user/{user}/tac_lite`). Grants set here apply only to that user and stack on
  top of their role defaults.

A note on how grants combine: a user may view/edit/delete a node if they hold a
grant — from either a role default or a per‑user assignment — for **at least one**
of the terms the node is tagged with, in a scheme that grants that operation.
There is also a built‑in fallthrough so that **untagged** nodes remain visible to
everyone rather than being accidentally hidden.

## Step 5 — Rebuild node access permissions (required)

Grants are written when a node is saved, so after you create or change any scheme
you must rebuild them for existing content. Either:

- tick **Rebuild content permissions now** on the scheme form when you save (if you
  leave it unticked, Drupal shows a reminder warning), or
- go to **Reports → Status report** (`/admin/reports/status`) and use **Rebuild
  permissions**.

Until this rebuild runs, existing nodes keep their old access rows and your changes
appear to do nothing.

## Remember the golden rule

tac_lite only **grants** access; it never takes it away. If content you expected to
be hidden is still visible to everyone, that is because nothing is denying it in
the first place — lock it down with core permissions, then use tac_lite to reveal
it to the right people.

## What tac_lite adds

- One permission: **Administer tac_lite** (reach the settings and scheme forms).
- A per‑user cache context so cached term listings vary by each user's grants.
- No new database tables — it works entirely through Drupal's node‑access grants.
