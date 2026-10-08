# Configuration

Getting this module working has three parts: add the bulk actions to the content
view, grant editors the right permissions, and (if needed) tell the module which
workflow states mean what. There is also a small options form.

## 1. Add the bulk operations to the Content view

The actions won't appear on `/admin/content` until you add them to the underlying
view.

1. Go to **Structure → Views → Content**
   (`/admin/structure/views/view/content`).
2. Add the **"Node operations bulk"** field to the view.
3. In that field's settings, enable the operations you want to offer:
   - **Publish latest revision**
   - **Unpublish current revision**
   - **Archive current revision**
   - **Pin Content**
   - **Unpin content**
4. Save the view.

Now on **Content** (`/admin/content`) you'll get checkboxes on each row and an action
selector; tick some rows, choose an action, and apply it. Views Bulk Operations drives
the selection and runs the batch.

## 2. Grant the permissions

Each bulk action checks its own permission when it runs, so you can give editors just
a subset of the operations. On **People → Permissions**
(`/admin/people/permissions`), grant the ones you need:

| Permission | Allows running |
|------------|----------------|
| **Moderated content bulk publish** | Publish latest revision |
| **Moderated content bulk unpublish** | Unpublish current revision |
| **Moderated content bulk archive** | Archive current revision |
| **Moderated content bulk pin content** | Pin Content |
| **Moderated content bulk unpin content** | Unpin content |

This lets you give editors bulk moderation power without handing them the sweeping
"Administer content" permission. Ordinary entity access still applies on top: an
action only runs on items the user can actually edit (including edit access to the
moderation‑state field). Note that access to the **settings form** below is governed
separately by core's **Administer site configuration** permission, not by any of the
above.

## 3. The settings form

Go to **Configuration → Content authoring → Moderated content bulk publish**
(`/admin/config/content/moderated-content-bulk-publish`). The settings save to the
`moderated_content_bulk_publish.settings` config object (schema provided, so it
exports with `drush config:export`).

### Confirmation and toolbar options

- **Confirmation dialog on the admin content listing** *(on by default)* — shows a
  JavaScript "are you sure?" dialog before a bulk operation runs on `/admin/content`.
  A useful guard against accidental mass changes.
- **Confirmation dialog on the node edit form** *(on by default)* — shows a
  confirmation dialog when publishing directly from a node's edit form.
- **Hide the admin‑toolbar language switcher** *(off by default)* — on multilingual
  sites the module adds a language switcher to the admin toolbar; tick this to hide
  it.
- **Retain original revision authoring info** *(off by default)* — when on, the
  original revision's authoring information is kept and the bulk context is appended to
  the revision log message, rather than the bulk action overwriting the authoring
  info.

### Which states mean "published", "unpublished", "archived"

Because your editorial workflow may use custom state names, the form lets you map them
so the actions transition content correctly:

- **Published state** *(default: `published`)* — the workflow state the *Publish latest
  revision* action targets. The publish action also verifies that a genuine published
  default revision results, and warns if the moderation configuration would prevent
  that.
- **Unpublished states** *(defaults: `archived` and `draft`)* — the states treated as
  "unpublished" for the *Unpublish current revision* action.
- **Archived state** *(default: `archived`)* — the state the *Archive current revision*
  action moves content into.

If your workflow uses the standard Drupal state machine names, the defaults already
match and you can leave these alone.

## Save

Click **Save configuration**. Your changes take effect immediately.

## Handy to know

If a node translation has no pending (latest) revision, the module quietly redirects
to the node instead of throwing a 403 error, so bulk moderation on multilingual sites
behaves gracefully.
