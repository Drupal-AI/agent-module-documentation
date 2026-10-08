# Configuration

Autosave Form has one settings form at **Configuration → Content authoring →
Autosave Form** (`/admin/config/content/autosave_form`, route
`autosave_form.admin_settings`). It writes to the `autosave_form.settings` config
object. You need the **Administer site configuration** permission.

## Timing

- **Interval** *(default: 60000 ms / 60 seconds)* — how often the autosave fires,
  in milliseconds. A shorter interval saves work more often but puts more load on
  the server; a longer one is lighter but risks losing more between saves.
- **Only on form change** *(off by default, experimental)* — when on, an autosave
  only happens if the form has actually changed since the last save, avoiding
  redundant writes.

## Which forms are covered

- **Content entity forms** *(on by default)* — autosave node, media, and other
  content entity edit forms.
- **Config entity forms** *(off by default)* — also autosave configuration entity
  forms.
- **Allowed content entity types and bundles** *(default: all covered types)* — an
  optional per‑entity‑type map limiting autosave to specific bundles. Leave it
  empty to cover all applicable types, or list, say, only the *Article* content
  type.
- **Autosave new (create) forms** *(on by default)* — also autosave forms for
  brand‑new entities, not just edits.

## Notification

- **Show notification** *(on by default)* — display a small toast each time an
  autosave runs.
- **Message** *(default: "Saving draft...")* — the toast text.
- **Delay** *(default: 1000 ms)* — how long the toast stays visible, in
  milliseconds.

## Conflict message

A separate config object, `autosave_form.messages`, holds the alert text shown when
the entity was saved by someone else while the current user was editing it (the
"entity saved in the background" alert). This warns the editor that their view is
now stale before they overwrite someone else's changes.

## Saving and the command line

Save the form when done. Whenever you change these settings, the module
automatically purges any stored autosave states so nothing stale lingers. You can
also set values from Drush, for example:

```bash
drush config:set autosave_form.settings interval 30000 -y
```
