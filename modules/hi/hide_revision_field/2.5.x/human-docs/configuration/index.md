# Configuration

Hide Revision Field has no settings page of its own. You configure it on each
bundle's **Manage form display** page, where it has taken over the widget for the
**Revision log message** field. Everything you set is saved in that bundle's
normal form-display config, so it exports and deploys like any other form-display
change.

## Open the settings

1. Make sure the core **Field UI** module is enabled.
2. Go to the **Manage form display** tab for the bundle you want, for example:
   - Content type: **Structure → Content types → Article → Manage form display**
     (`/admin/structure/types/manage/article/form-display`)
   - Media, taxonomy terms, and custom revisionable entity types have equivalent
     "Manage form display" tabs.
3. Find the **Revision log message** row and click its settings gear on the
   right.

## The widget settings, field by field

- **Show the revision log message field** (`show`, default **on**) — the master
  switch. Turn it **off** to hide the field on this bundle's add/edit form.
  Revisions are still created; only the message box disappears.
- **Hide the revision tab** (`hide_revision`, default off) — only meaningful when
  the field is hidden. When ticked, it also hides the entire "Revision
  information" fieldset/tab, including the "Create new revision" checkbox, for an
  even cleaner form.
- **Permission based** (`permission_based`, default off) — when ticked, the
  "Show" setting is ignored and the field appears only for users who hold the
  **Access revision field** permission. Use this to keep the field for trusted
  editors while hiding it from everyone else.
- **Allow user settings** (`allow_user_settings`, default **on**) — lets users
  who hold the **Administer revision field personalization** permission override
  the field's visibility for this bundle from their own profile page.
- **Default value** (`default`, default empty) — pre-fills the revision log
  textarea with this text for every new revision (for example "Edited via
  editorial workflow").
- **Rows** and **Placeholder** — inherited from the standard textarea widget;
  set the number of rows and placeholder text if you keep the field visible.

Click **Update**, then **Save** the form display.

How the settings interact: **Permission based** (if on) overrides **Show**; then
a per-user personalized value (if **Allow user settings** is on, the user has the
personalization permission, and they've saved an override) overrides both.

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|------------|----------------|
| **Access revision field** | See the revision log field on bundles configured with **Permission based** display. Grant to trusted editors. |
| **Administer revision field personalization** | Override revision-field visibility per bundle from one's own profile page (works together with **Allow user settings**). |

## Configuring in code

If Field UI is disabled, or you want to script the change, edit the form-display
config directly. For the Article content type:

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("revision_log");
  $c["settings"]["show"] = FALSE;              // hide the field
  // $c["settings"]["hide_revision"] = TRUE;   // also hide the whole revision tab
  $fd->setComponent("revision_log", $c)->save();
'
drush cr
```

Set `show` back to `TRUE` to show the field again. The same settings live in the
exported `core.entity_form_display.*.default.yml` files, so you can also manage
them through the normal config-sync workflow.
