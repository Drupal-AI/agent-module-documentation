# Configuration

Configuring Domain Menu Access is a two-step process: first tell it which menus
should be domain-aware, then assign individual links to domains on the standard
menu link form.

## Step 1 — choose which menus participate

1. Log in as a user with the **Administer domains** permission.
2. Go to **Configuration → Domain → Domain Menu Access**, or navigate directly to
   `/admin/config/domain/domain_menu_access/config`.
3. Tick the menus you want to be domain-aware (for example *Main navigation* or a
   *Footer* menu) and **Save**.

Only menus on this list expose the per-domain fields on their links and get
filtered per domain. For any menu you leave unticked, the domain fields are hidden
from the link form entirely, and its links keep whatever domain values they may
already have but are not filtered.

## Step 2 — assign links to domains

For a link in a participating menu:

1. Go to **Structure → Menus**, open the menu, and edit the link
   (or edit it from the node/content form where it was created).
2. Expand the **Domain** section. It contains the same two controls Domain Access
   uses on nodes:
   - **Domain access** checkboxes — the domains this link belongs to. On a domain
     you tick, the link is shown; on a domain you leave unticked, the link is
     hidden (and so is everything nested beneath it).
   - **Send to all affiliates** — tick this for links that should appear on every
     domain, now and in future, without listing them individually.
3. **Save** the link.

The *Domains* column added to the menu overview table
(**Structure → Menus → *(your menu)***) shows each link's current assignments so
you can review them at a glance.

## A note on the administration area

These per-domain visibility rules are deliberately **ignored inside the
administration area**. There, menu links show or hide based only on Drupal's
standard *Enabled* setting. This prevents an admin from accidentally losing access
to a link because of a domain rule while managing the site.

## Editing links across domains

By default a user can only manage menu links belonging to the domain they are
currently on. Grant the **`administer menu items across domains`** permission
(**People → Permissions**) to trusted staff who need to edit links for any domain
regardless of which one they are viewing.
