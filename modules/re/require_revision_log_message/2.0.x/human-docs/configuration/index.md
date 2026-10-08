# Configuration

Everything the module does is driven by one small settings form. Until you open
it and choose some content types, nothing is enforced.

## Open the settings form

1. Log in as a user with the **Administer require_revision_log_message**
   permission (see below).
2. Go to **Configuration → Content authoring → Require Revision Log Messages**, or
   navigate directly to `/admin/config/require-revision-log/adminsettings`.

## Choose which content types require a log message

The form lists every content type on your site with a checkbox. Tick the ones on
which a revision log message should be mandatory — for example *Article*, *News*,
and *Policy page*, while leaving *Basic page* untouched. Only the boxes you tick
are stored, so unchecking a type later cleanly removes the requirement from it.

For each content type you enable, the node edit form changes in two ways:

- The **Create new revision** checkbox is forced on and disabled, so every save
  produces a tracked revision and editors cannot opt out.
- The **Revision log message** field becomes required — the form will not save
  until the editor types something into it.

## Require a message on new nodes too

- **Require revision log message for new nodes** — a single checkbox. By default
  it is unticked, which means the requirement only applies when someone *edits* an
  existing node; creating a brand-new node does not demand a log message. Tick this
  box if you also want authors to explain the initial creation of content.

Click **Save configuration** to apply your choices. Changes take effect
immediately on the next node form.

## Permissions

The module defines two permissions, set under **People → Permissions**:

- **Administer require_revision_log_message** — controls who can open the settings
  form and change which content types are affected. This is a security-sensitive
  permission, so grant it only to trusted administrators or lead editors.
- **Bypass require_revision_log_message** — lets a user skip the requirement
  entirely; for them the node form is left unchanged and the log message stays
  optional. Grant it to administrators, migration/import accounts, or any role
  that legitimately needs to save without leaving a note.

Every role *without* the bypass permission automatically has the requirement
enforced on the content types you selected — there is nothing else to switch on.
