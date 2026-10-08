# Configuration

There's no central settings page — you enable and configure the feature **per
paragraph type**. This page walks through it.

## Prerequisite — define the view modes you want to offer

The editor's dropdown can only list view modes that actually exist and are turned on
for the paragraph type. So before you start:

1. Make sure the presentations you want (e.g. *Teaser*, *Compact*, *Full width*) exist
   as view modes. Add new ones under **Structure → Display modes → View modes** if
   needed.
2. On the paragraph type's **Manage display** tab, open **Custom display settings**
   and tick the view modes you intend to offer, so each gets its own configurable
   display.

Only view modes enabled in *Custom display settings* here will be selectable later.

## Step 1 — Turn the feature on for a paragraph type

1. Go to **Structure → Paragraphs types**, and **Edit** the type
   (`/admin/structure/paragraphs_type/<type>`).
2. Tick **Enable Paragraph view mode field on this paragraph type**.
3. Save.

This adds a "Paragraph view mode" field to the type. (Unticking the box and saving
removes the field and its stored data, cleanly turning the feature off.)

## Step 2 — Configure the select on Manage form display

1. Go to the type's **Manage form display** tab.
2. If the **Paragraph view mode** row is in the *Disabled* region, drag it up into the
   form (it normally sits at the very top).
3. Click its cog to set:
   - **Available view modes** — tick which view modes editors are allowed to choose.
     This is how you restrict editors to two or three approved layouts rather than
     every view mode on the site. (If you tick none, the select falls back to a single
     "Default" option.)
   - **Default value** — the view mode pre-selected on new paragraph items, so most
     paragraphs need no editor decision.
   - **Bind with the form mode** — when on (the default), changing the view-mode
     select reloads the paragraph's edit form over AJAX and switches it to a *form
     mode* with the same machine name as the chosen view mode (if one exists). Use
     this to show a different set of edit fields per presentation — for example hiding
     fields a "compact" rendering doesn't use. Leave it off if you don't need the edit
     form to change.
   - **Apply to preview mode** — off by default. Leave it off so the module doesn't
     override Paragraphs' own back-end **preview** display (which keeps preview
     working normally). Turn it on only if your site uses the preview view mode as a
     real, front-facing display.
4. **Update**, then **Save**.

## Step 3 — Use it as an editor

Now, when editing content that has these paragraphs, each paragraph shows a
**Paragraph view mode** dropdown at the top. Pick a presentation per item; when the
content is rendered, that paragraph displays in the chosen view mode. If you enabled
form-mode binding, changing the dropdown also reshapes the paragraph's edit fields on
the spot.

## Advanced: form modes with matching names

The form-mode binding feature switches the edit form to a **form mode whose machine
name matches the chosen view mode**. So if you offer a `compact` view mode and want
the editor to see fewer fields when they pick it, create a paragraph **form mode**
named `compact` (under **Structure → Display modes → Form modes**), enable and
configure it on the paragraph type's **Manage form display**, and the module will use
it automatically when "compact" is selected. If no matching form mode exists, the edit
form simply stays on the default — nothing breaks.

## Turning it off

Untick the enable checkbox on the paragraph type edit form and save. The view-mode
field (and any values editors chose) is removed, and paragraphs of that type go back
to rendering in whatever view mode the site requests.
