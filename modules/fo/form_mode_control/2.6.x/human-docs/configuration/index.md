# Configuration

Setting up Form Mode Control is a three‑step story: build the form modes in core,
set the per‑role defaults on the module's form, and (optionally) grant the
permissions that unlock the `?display=` URL switch.

## Step 1 — Build the form modes (core Field UI)

Form Mode Control can only choose between form modes that already exist and are
active on a bundle:

1. **Add a form mode.** Go to **Structure → Display modes → Form modes → Add form
   mode** (`/admin/structure/display-modes/form/add`) and create one — for example
   a `compact` mode for nodes.
2. **Activate it on the bundle.** On the bundle's **Manage form display** page
   (e.g. `/admin/structure/types/manage/article/form-display`), tick the new form
   mode and **Save**, then arrange its fields. This creates an *enabled* form
   display for that bundle.

Form Mode Control only sees form displays that are **enabled** for the bundle — an
inactive form mode is ignored.

## Step 2 — Set the per‑role defaults

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Structure → Display modes → Form modes → Configure form modes**
   (`/admin/structure/display-modes/form/config-form-modes`).
3. The form lists every entity type and bundle that has at least one non‑default
   form mode, organised in vertical tabs. For each **role**, pick the default form
   mode for **Create** and for **Edit**.

Choosing the plain **default** form mode for a role removes its override (the
configuration only stores the non‑default choices).

### How the default is chosen at runtime

- The add form maps to the **Create** operation; the edit form maps to **Edit**.
  (For the user entity, the *register* form is Create and the account form is
  Edit.)
- If the current user has several roles, the one with the **highest weight** (as
  ordered on the roles admin page) decides which default applies.
- The chosen form mode is only used if its form display actually exists and is
  enabled for that bundle.

You can also read or set the defaults from the command line:

```bash
drush config:get form_mode_control.settings defaults
drush config:set form_mode_control.settings defaults.node.article.create.editor compact -y
```

The stored values live in the `form_mode_control.settings` config object, so your
role/bundle defaults are exported and deployed like any other configuration.

## Step 3 — Let users switch form mode by URL (`?display=`)

Anyone with the right permission can open a specific form mode by appending
`?display=<form_mode_id>` to an add or edit URL, for example:

- `/node/add/article?display=compact`
- `/node/1/edit?display=compact`

This overrides the default **only when** the target form display is enabled *and*
the user has permission to use it (see below). It's handy for task‑specific links,
bookmarks, or buttons in your own UI.

## Permissions

Form Mode Control generates its permissions dynamically, and they appear on
**People → Permissions** (`/admin/people/permissions`) under a *Form Mode Control*
section. The configuration form also links there via its **Manage form mode
permissions** button.

- **One permission per activated form mode.** For every form mode enabled on a
  bundle, the module creates a permission whose label reads roughly *"Use the form
  mode `<mode>` linked to `<Entity type>` ( `<Bundle>` )"*. Granting it to a role
  lets that role open the bundle's form via `?display=<form_mode_id>`. (Only form
  modes currently activated on a bundle show up here.)
- **Use all form modes** (`access_all_form_modes`) — a master permission. A role
  with this can switch to **any** form mode by URL, regardless of the individual
  per‑form‑mode permissions.

Important distinction: these permissions gate only the interactive `?display=`
switch. The stored per‑role **defaults** from Step 2 are always applied, whether or
not the user holds any of these permissions.

## Housekeeping

If you later delete a form mode/form display or a role, Form Mode Control
automatically prunes the matching entries from its stored defaults, so no stale
mappings linger in configuration.
