# Target Audience — manual setup guide

**Target Audience** (`target_audience`) lets you restrict who can view or edit any
Drupal entity by adding a single reusable field. Out of the box, Drupal decides
access mainly through roles and permissions — great for site-wide rules, but
awkward when you want to say "only these specific people, or members of this
group, may see or edit this item." Target Audience solves exactly that: you add one
*Target audience* field to a content type (or any fieldable entity type), and
editors choose the audience right on the edit form.

Each target independently grants **view** and/or **edit** to a **role**, an
**individual user** (entered by email address), or a **group** (when the Group
module is installed). The field defaults to *All (everyone)*, so content stays
public until you actually pick an audience — which means adding the field never
accidentally hides existing content. As soon as you choose a role, user, or group,
only that audience can reach the content, and restricted content stops appearing in
listings, search, and everywhere else on the site. It depends only on core's
**Field** and **User** modules; Node and Group integrations are detected
automatically when those modules are present.

This is genuine, well-built access control. For **nodes** it uses Drupal's node
grants system, the correct query-level mechanism, so a restricted node is filtered
out of *all* queries — its canonical page, Views, search, and other listings — not
just hidden on the node page. For **other entity types** there is no query-level
grants system in Drupal, so enforcement happens at runtime through entity access
checks; the practical consequence is that if you write **custom listing queries**
over non-node entities, you must call entity access yourself for those queries to
respect the restriction. The targeting data itself is protected: the field is only
visible and editable to users with the *Administer target audience access*
permission, and it renders nothing on the front end, so the audience list never
leaks through forms, view modes, REST, or JSON:API.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page — Target Audience works entirely through a field
you add yourself and a permission you grant. The permission lives at
**People → Permissions** (`/admin/people/permissions`), and you add the field
through the normal **Field UI** on whichever bundle you want to protect.

## How to use it

1. Enable the module and grant the **Administer target audience access**
   permission (at **People → Permissions**) to the roles that should manage
   audiences.
2. Go to the bundle you want to protect — for example **Structure → Content types
   → Article → Manage fields** — and add a new field of type **Target audience**.
   Set its cardinality to **Unlimited** so several targets can be added.
3. In the field settings, choose which target types are allowed (role, user,
   group) and, when Group is installed, which group types editors may select. The
   default form and view displays are fine as they are — the widget shows on the
   edit form (only to permitted users) and the field renders nothing on display.
4. Edit a piece of content. Leave the audience on **All (everyone)** to keep it
   public, or add rows targeting roles, users (by email), or groups and tick
   **view** and/or **edit**. Save — access takes effect immediately.

If you add the field to content that already exists, rebuild node access
permissions once (via **Reports → Status report**,
`/admin/reports/status`) so existing nodes pick up the new grants. And remember the
non-node caveat above: for entity types other than nodes, any custom listing
queries you write must call entity access themselves to honor the restriction.
Users with the module permission (or core's *Bypass node access*) are never locked
out.
