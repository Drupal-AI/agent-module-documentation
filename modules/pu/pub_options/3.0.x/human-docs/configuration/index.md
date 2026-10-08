# Configuration

All of the module's work happens on one screen: **Configuration → Content
authoring → Publishing options** (`/admin/config/content/publishing-options`).
Here you create, edit, and delete your custom publishing options and decide which
content types each one applies to.

## Create a publishing option

1. Log in as a user with permission to administer publishing options (an
   administrator by default).
2. Go to **Configuration → Content authoring → Publishing options**.
3. Click **Add publishing option**. You land on the add/edit form.
4. **Name** — type a human‑readable name for the option, for example *Featured*,
   *Archived*, or *Show in sidebar*. This is the label editors will see on the
   node form.
5. **Content types** — associate the option with the content types it should
   appear on. Only the types you tick here will show the flag on their add/edit
   forms.
6. Click **Save**.

You can return to this screen any time to edit an option's name or the content
types it applies to, or to remove it.

## Associating options from the content type form

There's a second, equivalent place to wire these up. When you add or edit a
content type at **Structure → Content types**, you'll find a **Publishing
options** section where you can associate the same custom options with that type.
Use whichever workflow fits how you think — both edit the same underlying
settings.

## Setting the flag on a node

Once an option is associated with a content type, editors set it while creating
or editing content:

1. Add or edit a node of that content type (`node/add/…` or `node/{id}/edit`).
2. Open the **Promotion options** section (the same place core's *Promoted to
   front page* and *Sticky* live).
3. Tick or untick your custom options as needed, then save the node.

## Using the flags in Views

Publishing options integrates with Views, so each custom flag is available as:

- a **field** — to display whether a node has the flag set,
- a **filter** — to limit a list to nodes that do (or don't) have the flag, and
- a **contextual filter** — to argue a list by the flag value dynamically.

To use these, create or edit a View whose rows show **Content**, then add the
publishing‑option field, filter, or contextual filter you need.

## A note on what the flags mean

Custom publishing options are simply boolean metadata — they do **not** control
who can see or edit content on their own. Their effect comes entirely from how
you use them: styling "Featured" nodes differently in your theme, filtering them
into a Views block, or writing custom logic that reads the flag. If you need
genuine access control, build that logic around the flag rather than relying on
the flag itself.
