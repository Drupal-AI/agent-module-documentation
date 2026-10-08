<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — hide the revision log field per bundle

There is no settings page. Configuration is the `revision_log` component of each bundle's
default form-display config entity: `core.entity_form_display.{entity_type}.{bundle}.default`.
The module assigns its widget `hide_revision_field_log_widget` to that component on every
revisionable entity type (nodes, media, terms, custom types).

## Where (UI)

Manage form display for the bundle, e.g. for the Article node type:
`/admin/structure/types/manage/article/form-display` (route
`entity.entity_form_display.node.default`). Open the gear/settings for the
**Revision log message** row. Requires the core **Field UI** (`field_ui`) module for the
page to exist; otherwise edit the config directly (below).

## Widget settings keys (component `settings`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `show` | bool | `true` | `false` hides the revision log field on the form. |
| `hide_revision` | bool | `false` | When the field is hidden (`show=false`), also hide the whole revision fieldset/tab and force the "Create new revision" checkbox. Only meaningful when `show=false`. |
| `permission_based` | bool | `false` | Ignore `show` and instead show the field only to users with the `access revision field` permission. |
| `allow_user_settings` | bool | `true` | Let users with `administer revision field personalization` override visibility for this bundle on their profile page. |
| `default` | string | `''` | Pre-fills the revision log textarea with this default value. |
| `rows` | int | `5` | Textarea rows (inherited from StringTextareaWidget). |
| `placeholder` | string | `''` | Textarea placeholder (inherited). |

## Hide the field via Drush (Article node type)

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("revision_log");
  $c["settings"]["show"] = FALSE;
  $fd->setComponent("revision_log", $c)->save();
'
drush cr
```

Set `$c["settings"]["hide_revision"] = TRUE;` as well to also hide the whole revision tab.
To show it again, set `show` back to `TRUE`. Reading the current value:

```bash
drush php:eval '
  $c = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default")->getComponent("revision_log");
  print var_export($c["settings"], TRUE) . "\n";
'
```

## Notes

- The `revision_log` component key is the entity type's `revision_log_message` revision
  metadata key (it is literally `revision_log` for nodes and media).
- Precedence in the widget: `permission_based` (if true) overrides `show`; then a per-user
  personalized value (if `allow_user_settings` is true and the user has the personalization
  permission and has saved an override) overrides both.
- Configure in code by editing/exporting the `core.entity_form_display.*.default.yml` files
  through the normal config-sync workflow.
