# Add Another — manual setup guide

**Add Another** (`addanother`) is a small workflow booster for editors who create
a lot of content of the same type in one sitting. After they save a node, it can
offer a **"Save and add another"** button, an **"Add another…"** message with a
link back to the add form, and an **"Add another"** tab on the node — so the next
node of the same type is always one click away, instead of a trip back through the
admin menu.

Each of those affordances is independent and configured **per content type**, with
site-wide defaults for any content types you create later. You decide, for example,
that your "Event" and "Product" types get the button while your blog stays as-is.
Everything is stored in a single small config object (`addanother.settings`), so the
per-type toggles export cleanly with the rest of your configuration.

It is a pure UI convenience: no fields, no entities, no plugins. It works only with
core **node** content, and two permissions govern it — one to reach the settings and
one (**Use add another**) that a user must have before they see the button, message
or tab at all.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

### Set the site-wide defaults

Go to **Configuration → Content authoring → Add another**
(`/admin/config/content/addanother`; you need the **Administer add another**
permission). The form has four checkboxes that decide the default behaviour for
**new** content types:

- **Save and add another button** (`default_button`, on by default) — adds the
  extra submit button to the node add form.
- **Add another message** (`default_message`, on by default) — shows an
  "Add another…" message with a link after a normal save.
- **Add another tab** (`default_tab`, on by default) — adds an "Add another"
  local-task tab to node pages that jumps straight to the add form for that type.
- **Add another tab on edit page** (`default_tab_edit`, on by default) — also shows
  that tab while editing a node.

### Override it per content type

Each content type's own edit form (**Structure → Content types → *(edit)***) gains
an **"Add another settings"** section with the same four checkboxes. Tick or untick
them there to override the defaults for just that type — for instance, enable the
button on "Product" only, or turn off the after-save message on a type where editors
found it noisy. When a per-type box is left at its default, the site-wide default
above is used.

### Grant the permission

The button, message and tab only appear for users who have the **Use add another**
permission (**People → Permissions**). Grant it to your editorial roles. The button
and message appear only on the node **add** form; "Save and add another" saves the
node and drops the editor straight back onto a fresh add form for the same type.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Add another**
(`/admin/config/content/addanother`). Per-type overrides live on each content
type's edit form under **Structure → Content types**.
