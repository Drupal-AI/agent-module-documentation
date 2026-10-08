# Configuration

Entity Reference Preview has a small settings form plus a few things you turn on in
other parts of the admin UI (a field formatter, an opt‑in on Views, and
permissions). This page walks through each.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Reference Preview**, or
   navigate directly to `/admin/config/content/entity-reference-preview`.

The main setting here controls the **"unpublished draft" indicator** — the small
blue dot the module can show, during normal (non‑preview) browsing, on referenced
entities that have a publishable draft. Enable it on this form if you want editors
to see at a glance which embedded content has pending draft changes. (Users also
need the *view entity_reference_preview indicator* permission for the dot to
appear — see Permissions below.)

## Enable preview on a reference field

The preview behaviour is opt‑in per field, through a formatter:

1. Go to the **Manage display** page of the entity whose references you want to
   preview (for example **Structure → Content types → Landing page → Manage
   display**).
2. Set the entity-reference field's **Format** to the Entity Reference Preview
   formatter. It renders exactly as usual in normal viewing.
3. Click **Update**, then **Save** the display.

Now, when you view that entity on its **latest‑revision** route (its `.../latest`
tab), the referenced entities render at their latest (draft) revision too.

## Preview from anywhere with the toolbar/block button

Some pages — a Views listing, a block, a Layout Builder page — are not previewable
entities and have no "Latest" tab. For those, the module provides a **toolbar item
and a block** containing a button that manually **starts and stops preview mode**.
While preview mode is on, any field using the preview formatter shows its latest
draft. Place the block through **Structure → Block layout** if you prefer it in the
page rather than the toolbar. Note that only content using the preview formatter is
affected — nothing else on the page is previewed.

## Preview entities rendered by a View

To preview the latest versions of entities listed by a View, **opt in to
previewability on that View**. Once enabled, browsing the site in preview mode will
show the latest revisions in that listing.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`) to the
appropriate roles:

- The permission to use preview mode, so editors can start/stop previewing and see
  draft references.
- **view entity_reference_preview indicator** — required for a user to see the
  blue "has an unpublished draft" dot (which must also be enabled on the settings
  form above).

## Save

Click **Save configuration** on the settings form to store your changes. Remember
that the settings form only governs the indicator; enabling preview itself happens
on each field's *Manage display* and on your Views.
