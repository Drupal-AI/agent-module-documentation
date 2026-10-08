# Configuration

Config Ignore Webform works sensibly out of the box: as soon as it's enabled, all
`webform.webform.*` and `webform.webform_options.*` configuration is ignored during
config import and export, **except** webforms marked as templates, which always
sync. The settings form is where you carve out further exceptions — the specific
non-template webforms and option lists you *do* want to keep under configuration
management.

## Open the settings form

1. Log in as an administrator.
2. Go to either location — they open the same form:
   - **Structure → Webforms → Config ignore**
     (`/admin/structure/webform/config/ignore`), or
   - **Configuration → Development → Configuration synchronization → Webforms**
     (`/admin/config/development/configuration/webform-ignore`).

## Choose what should still sync

The form presents two sets of checkboxes:

- **Webforms** — a list of your non-template webforms. Tick any that should still be
  imported and exported normally (i.e. *not* ignored). Leave a form unchecked to let
  its production edits stay untouched by config import.
- **Option lists** — the same idea for `webform_options` configuration: tick the
  option lists that should keep syncing.

Templates aren't in these lists to worry about — they always sync regardless.

## Save

Click **Save**. From then on, config import/export ignores webform and option-list
config *except* for templates and the items you ticked here.

## Remember the trade-off

Any webform or option list you leave ignored lives only in the site's database — it
won't be written out by `drush config:export`, so it isn't captured in version
control. That's exactly what protects editor-managed forms from being overwritten,
but make sure your database backups cover those forms.
