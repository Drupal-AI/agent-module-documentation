# Configuration

All of Save & Edit's behavior is driven from one settings form. Go to
**Configuration → Save & Edit → Settings** (`/admin/config/save_edit/settings`),
which requires the **Administer save and edit** permission.

## Choose which content types get the button

The most important setting is the list of **content types**. Tick the types that
should show the Save & Edit button; leave the rest unticked. As you add or remove
content types on the site, this list is kept in sync automatically — and if you turn
on **Enable Save & Edit on newly created content types**, brand‑new types are opted
in by default.

Remember that the button also only appears for users who have the **Use save and
edit** permission, so both conditions must be met.

## The button itself

- **Button text** (`button_value`, default **"Save & Edit"**) — relabel the button,
  for example to "Apply".
- **Button weight/position** (`button_weight`, default **-1**) — where the button
  sits among the form's action buttons (a range from -10 to 10; lower is further
  left/earlier).
- **Gin primary action** (`gin_primary`) — when the Gin admin theme is active,
  promote the button to a primary action instead of hiding it inside the "More
  actions" dropdown. This is switched on automatically at install if Gin is already
  your admin theme.

## Auto‑unpublish (draft‑first workflow)

Two options let Save & Edit double as a "keep it a draft" control:

- **Unpublish on save** (`unpublish`) — every time a node is saved with Save & Edit,
  it is set to unpublished. Combined with the button, this enforces a workflow where
  content stays hidden while it is being worked on.
- **Unpublish new content only** (`unpublish_new_only`) — auto‑unpublish only on the
  node's *first* save, so later Save & Edit saves leave the published status alone.

## Tidy up the default action buttons

To simplify the node form's action bar, you can hide or relabel the core buttons:

- **Hide the default Save button** (`hide_default_save`) — forces editors to use Save
  & Edit instead (this also hides the Unpublish button).
- **Save button text** (`save_button_text`) — relabel the default Save button without
  hiding it (leave empty to keep "Save").
- **Hide Publish** (`hide_default_publish`), **Hide Preview** (`hide_default_preview`),
  **Hide Delete** (`hide_default_delete`) — remove those buttons from the form to
  leave only the actions your editors need.

## What happens on save

When an author clicks Save & Edit, the node is saved (optionally forced unpublished
per the settings above) and the editor is redirected straight back to the node's edit
form rather than the default post‑save page. Any incoming `destination` query
parameter is preserved, so the button plays nicely with contextual editing flows.

## Managing settings as configuration

Everything above lives in the `save_edit.settings` configuration object, so you can
export it and deploy consistent button text, enabled content types, and workflow
options across environments. For scripted changes, the settings can also be read and
set with `drush config:get` / `drush config:set` on `save_edit.settings`.
