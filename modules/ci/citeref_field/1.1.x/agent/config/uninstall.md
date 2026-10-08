<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uninstall cleanup

Because a field type cannot be uninstalled while field instances still exist, the module ships an
uninstall validator plus a dedicated "delete all citeref fields" form.

## Uninstall validator (service)

`citeref_field.uninstall_validator` (`citeref_field.services.yml`), class
`src/CiterefFieldUninstallValidator.php`, tagged `module_install.uninstall_validator`, lazy,
constructed with `entity_type.manager` + `entity_field.manager`.

`validate('citeref_field')` iterates **node** bundles (`node` → `node_type`), collects field
definitions of type `citeref_field` (via `EntityFieldManager::getFieldDefinitions()` filtered to
`FieldConfigInterface`), and — if any exist — returns one reason with a link to the deletion
form, blocking uninstall until the fields are removed. (Only node bundles are scanned.)

## Deletion form

`src/Form/CiterefFieldUninstallValidatorForm.php`, route `citeref_field.uninstall_settings` →
**`/admin/modules/uninstall/entity/citeref_field`**, access permission
**`administer citeref_field`**. `hook_form_alter` in `citeref_field.module` relabels the submit
button to *"Delete all citation fields"*.

`buildForm()` lists, per node bundle, every field of type `citeref_field` **and** any
`entity_reference_revisions` field whose machine name contains `citeref` (paragraph-style
references). It renders that list (wrapped with `Markup::create()`), a warning that the action is
irreversible, and a **Cancel** button that redirects back to `/admin/modules/uninstall`.

`submitForm()` loads each listed field with `FieldConfig::loadByName('node', <bundle>, <field>)`
and calls `->delete()`; if anything was deleted it runs cron (`cron->run()`) to purge field data,
shows *"All citation reference fields deleted"*, and redirects to `/admin/modules/uninstall`.
Injected services: `config.factory`, `entity_type.manager`, `entity_field.manager`, `cron`.

## Operate

1. `/admin/modules/uninstall` shows citeref_field blocked with a "Remove fields…" link.
2. Follow it to the deletion form, review the listed fields, submit to delete them (cron runs).
3. Return to the uninstall page and uninstall the module normally.

Caveat: the scan covers **node** bundles only — citeref fields on other entity types are not
listed/auto-removed here and must be deleted manually before uninstall.
