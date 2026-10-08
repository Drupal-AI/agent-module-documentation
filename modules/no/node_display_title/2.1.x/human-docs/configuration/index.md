# Configuration

Node Display Title has one settings form plus a small set of permissions. The form
chooses *which content types* offer a display title; the permissions decide *who* can
manage that setting and edit the field.

## Choose which content types use display titles

1. Go to **Configuration → Content authoring → Node Display Title**
   (`/admin/config/content/display-title-settings`). You need the **manage display
   title field settings** permission to open it.
2. Tick each content type that should expose the **Display title** field, and
   **Save**. Enabling a type adds the field to it; the field only surfaces on the node
   form for the types you enable here.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Manage display title field settings** — access the settings form above.
- **Access display title field** — edit the display title on any node form.
- **Access `{bundle}` display title field** — a per‑content‑type version of the
  above, so you can let a role edit display titles for some types but not others.

The **Display title** element appears on a node form only when **both** conditions
are met: the user holds one of the access permissions **and** the node's content type
is enabled on the settings form.

## How the two titles behave

- On the **front end**, a node's display title (when set) replaces the node title
  everywhere rendered nodes appear — including Views and Panels — and it is what core
  search indexes.
- On **admin pages** and on the node's own **edit** and **delete** forms, the real
  admin title is always shown, so editors can still find and manage content by its
  internal name.
- Leaving a node's display title **empty** falls back to the normal title, so
  enabling the module for a content type never forces you to fill one in.

## Notes

- The `display_title` field supports a language code, so display titles can be
  localised per node.
- Uninstalling the module cleanly removes the added field.
