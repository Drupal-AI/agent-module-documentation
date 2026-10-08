# Configuration

Key Save works well with no configuration — this page is only for fine-tuning
*which* forms get the Ctrl-S / Cmd-S shortcut.

## How forms are chosen automatically

For every form, Key Save decides whether to attach the shortcut in this order:

1. If the form's id is in the **Exclude** list → the shortcut is **not** added
   (exclusions always win).
2. Otherwise, if the form's id is in the **Include** list → the shortcut **is**
   added.
3. Otherwise, if the form is an **entity add/edit form** or a **configuration
   form** (one that extends Drupal's `EntityForm` or `ConfigFormBase`) → the
   shortcut is added automatically.

So most config forms and all entity add/edit forms get the shortcut with no setup.
You only need the lists below for the special cases in between.

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → User interface → Key Save**, or navigate directly to
   `/admin/config/user-interface/keysave`.

You'll see two text areas.

### Forms to Include

One form id per line. Use this for admin forms that *don't* extend the entity or
config-form base classes but where you still want Ctrl-S to work — for example
plain administrative forms. The module ships with a handful already included:

- `block_admin_display_form` — the Block layout form
- `system_modules` and `system_modules_uninstall` — the module install/uninstall forms
- `user_admin_permissions` — the Permissions form
- `drupal_upgrade_status_summary_form` and `bpmn_io_modeller`

Add any other form id you like, one per line.

### Forms to Exclude

One form id per line. Use this to *opt a form out* of the shortcut. Exclusions are
checked first and override everything else, so listing a form here guarantees
Ctrl-S won't be hijacked on it.

Click **Save configuration** when done. Both lists are stored in the
`keysave.settings` config object, so they travel with a configuration
export/import — handy for keeping the same behavior across environments.

## Finding a form's id

If you're not sure of a form's id, enable core's Twig debugging or inspect the
form's `<form>` element — its `id` attribute reflects the form id (dashes in the
HTML id map to underscores in the form id, e.g. `node-article-form` →
`node_article_form`).
