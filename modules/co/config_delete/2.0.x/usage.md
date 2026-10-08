Config Delete adds a UI form for **deleting a single configuration object** (simple config or a config entity) directly from the admin, optionally deleting its config dependencies too.

---

The module provides one form at **`/admin/config/development/configuration/delete`** (route
`config_delete.delete`), shown as a **Delete** tab/menu link under core's *Configuration
synchronization*. Access requires the module's own `delete configuration` permission (marked
`restrict access: true`). The form (`ConfigDeleteForm`) extends core's
`ConfigSingleExportForm`, reusing its **Configuration type** and **Configuration name** selects,
but a `hook_form_alter` removes the export textarea and adds a **"Delete config dependencies"**
checkbox plus a **Delete** submit button, with a prominent warning that deleting config can
break the site. On submit it resolves the real config object name (for a config entity it
prepends the entity type's config prefix; `system.simple` uses the raw name) and calls
`\Drupal::configFactory()->getEditable($name)->delete()`. If "Delete config dependencies" is
ticked, it first reads the object's `dependencies.config` list and deletes each of those config
objects too. The module has no settings, no schema, no Drush commands, and no default config;
it only requires core's Configuration Manager (`config`). It is a developer/administrator tool
for removing leftover or unwanted configuration that has no delete button in the normal UI.

---

- Delete a leftover configuration object left behind by an uninstalled module.
- Remove a specific config entity (e.g. a view, image style, or field) from the UI.
- Delete a simple config object (`system.simple`) that has no dedicated delete page.
- Clean up orphaned `field.storage.*` / `field.field.*` config from a botched install.
- Remove a stray filter format, text editor, or date format config.
- Delete a config item along with all its declared config dependencies in one action.
- Tidy up configuration before a config export/sync so exports stay clean.
- Get rid of duplicated or test configuration on a development site.
- Remove config that blocks a module from being reinstalled cleanly.
- Delete an obsolete third-party settings config object.
- Give a trusted admin a UI to delete config without using Drush or Devel.
- Remove a broken config entity that errors in its normal admin form.
- Delete a migration or feeds config that is no longer used.
- Clear out per-environment config that should not exist in a given environment.
- Remove a config object whose provider module is gone (so no UI exists for it).
- Restrict who can delete configuration via the dedicated 'Delete configuration' permission.
- Delete a single block, menu, or contact form config entity by name.
- Cascade-delete a config entity and the sub-configs it depends on.
- Prune configuration during a site audit or cleanup pass.
- Use as a lightweight alternative to writing an update hook just to delete config.
