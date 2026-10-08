<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension Reference Field (extension_reference_field) — agent index

One new **field type** that references a Drupal **extension** (module / theme / profile) by machine
name, plus its **select widget** and **label formatter**. Package `Field types`. **No dependencies**
(core only). Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 1.2.3-beta1
(version-dir `1.2.x`). No submodules, no routes, no permissions, no Drush, no install hooks, no
settings form.

- **The field type, widget, formatter, storage settings, computed property, and how to add/operate it** →
  [fields/extension_reference.md](fields/extension_reference.md)

## What it actually is (from source)

- **Field type** `extension_reference` (label *"Extension"*, category `reference`) —
  `src/Plugin/Field/FieldType/ExtensionReferenceItem.php`, extends core `FieldItemBase`, implements
  `OptionsProviderInterface`. Stores `target_id` `varchar(255)` (indexed); `mainPropertyName()` =
  `target_id`. Default widget `extension_reference_select`, default formatter
  `extension_reference_label`.
- **Storage settings** (`defaultStorageSettings()` / `storageSettingsForm()`): `target_type`
  (`module`/`theme`/`profile`, required, locked once data exists) and `status`
  (`enabled`/`disabled`/`all`, default `all`). These drive `getSettableOptions()`.
- **Computed property** `extension` — `src/ExtensionComputed.php` (a `TypedData`), resolves the stored
  `target_id` + the field's `target_type` to a core `\Drupal\Core\Extension\Extension` object on read.
- **Widget** `extension_reference_select` — `src/Plugin/Field/FieldWidget/ExtensionReferenceSelectWidget.php`,
  a trivial subclass of core `OptionsSelectWidget` with `multiple_values = TRUE`.
- **Formatter** `extension_reference_label` — `src/Plugin/Field/FieldFormatter/ExtensionReferenceLabelFormatter.php`,
  renders each item's extension name; setting `link` (default FALSE) optionally links to the drupal.org
  project page.
- **Service** `extension_reference_field.extension_drupal_org_data` (`src/ExtensionDrupalOrgData.php`,
  interface `ExtensionDrupalOrgDataInterface`) — reads an extension's drupal.org packaging metadata
  (`project`/`version`/`datestamp` from its info) and builds `https://www.drupal.org/project/<project>`.
- **Enums** — `src/Enum/ExtensionType.php` (`module`/`theme`/`profile`; maps to the read-only core
  `extension.list.module|theme|profile` services) and `src/Enum/ExtensionStatus.php`
  (`enabled`/`disabled`/`all`).
- **Config schema** — `config/schema/extension_reference.schema.yml`
  (`field.storage_settings.extension_reference`, `field.value.extension_reference`). No `config/install`.
- **hook_help()** only (`extension_reference_field.module`); one-line About text.

## How to use in one line

Add a field of type **Extension** on any bundle (*Manage fields*), pick the extension **type** and
**status** in field storage settings, edit content with the select widget, display with the label
formatter (optionally linked to drupal.org). Details and a config example: the fields doc above.
