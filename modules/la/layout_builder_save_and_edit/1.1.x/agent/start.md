# layout_builder_save_and_edit — agent start

Adds a second action button, **"Save and edit layout"**, to core Layout Builder forms. Unlike
the stock "Save layout" (which exits Layout Builder), this button saves and redirects back to the
same layout-editing page so editors keep working. Entirely a single `hook_form_alter`; **no config,
no routes, no permissions, no settings, no plugins, no schema, no Drush**. Depends on
`drupal:layout_builder`. Just `drush en layout_builder_save_and_edit` and it applies site-wide.

- Which forms get the button, the redirect targets, the validate/submit flow, and the permission
  gate on content forms → [extend/behavior.md](extend/behavior.md)

There is nothing to configure. The only access control is core Layout Builder's per-bundle
`configure editable {bundle} {entity_type} layout overrides` permission (see behavior.md).
