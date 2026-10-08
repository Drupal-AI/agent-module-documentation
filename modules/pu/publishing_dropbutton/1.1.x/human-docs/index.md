# Publishing Dropbutton — manual setup guide

**Publishing Dropbutton** (`publishing_dropbutton`) reintroduces two UI elements
that existed in Drupal core 8.3 but were replaced in 8.4: the "dropbutton" style
of publishing control on the node form — a single split button that combines the
save action with the publish/unpublish (or content moderation state) choice,
instead of the separate *Published* checkbox and *Save* button that core uses
today.

**Please read this first:** the module itself carries an explicit warning —
*unless you specifically need this to maintain UI backwards compatibility, you
probably shouldn't install it.* Core's current out‑of‑the‑box publishing UX is
considered an improvement over the old dropbutton. This module exists for sites
that depended on the pre‑8.4 behavior and want to keep it.

If you do need it, it restores publishing dropbuttons for both the plain
node status (published/unpublished) and **Content Moderation** states.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page**. After enabling, you finish setup with one small
form‑display change per content type, described in "How to use it" below.

## Where it lives in the admin menu

The module adds **no configuration page**. The one manual step happens on each
content type's **Manage form display** tab (**Structure → Content types →
*(bundle)* → Manage form display**).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your content type)* → Manage form
   display**.
3. Move the **Status** field into the **Disabled** (hidden) region. With the
   default *Published* widget out of the way, the module's dropbutton takes over
   the publishing control on that content type's add/edit form.
4. Repeat for any other content types where you want the dropbutton.

If you use Content Moderation on the content type, the dropbutton reflects the
available moderation state transitions instead of a simple published toggle.
