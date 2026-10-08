# Configuration

Paragraph Anchors has a single settings form that controls which paragraphs get
anchors, how the anchor slug is built, and whether the copy‑link button appears.

## Open the settings form

1. Log in as a user with the **Administer Paragraph Anchors settings** permission
   (an administrator by default).
2. Go to **Configuration → Content → Paragraph Anchors**, or navigate directly to
   `/admin/config/content/paragraph-anchors`.

## Enable on these paragraph bundles

A list of checkboxes, one per paragraph type. Tick the bundles that should get
anchors. When you enable a bundle, the module attaches two fields to it:

- **Generated Anchor ID** (`field_generated_anchor_id`) — the read‑only field that
  stores the generated slug, and
- the per‑instance **Copy anchor link button** override
  (`field_anchor_copy_override`).

Unticking a bundle **removes both fields** from it again, so only enable the types
that genuinely need deep‑link anchors.

## Source fields (priority order)

A text area with **one field machine name per line**. When a paragraph is saved,
the module walks this list from top to bottom and uses the **first field that has a
value** to build the anchor slug. The default list covers the common title‑like
fields:

```
field_title
field_heading
field_name
field_label
title
```

Add your own field machine names to the list (or reorder them) if your paragraph
types use different title fields. If none of the listed fields has a value on a
given paragraph, the module falls back to that paragraph's UUID so there is always
an anchor.

## Show 'copy anchor link' button by default

A checkbox that sets the **site‑wide default** for the small copy‑link button that
can appear on each anchored paragraph on the front end.

Keep in mind this default is always subject to the **Access "copy anchor link"
buttons** permission: if a user's role does not have that permission, the button is
hidden for them no matter what this checkbox says. And individual paragraphs can
override this default through their **Copy anchor link button** field (*Use site
default / Always show / Always hide*) on the paragraph edit form.

## How the pieces interact

For a copy‑link button to show on a given paragraph, three things line up:

1. the viewer's role has the **Access "copy anchor link" buttons** permission
   (checked first), then
2. the paragraph's own **Copy anchor link button** override — or, if that is set to
   *Use site default*, the
3. site‑wide **Show 'copy anchor link' button by default** setting above.

## Save

Click **Save configuration** at the bottom of the form. Newly enabled bundles get
their anchor fields immediately; each paragraph's anchor is (re)generated the next
time it is saved.
