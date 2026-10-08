<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Scorm field type, widget, formatter & extraction pipeline

## Install & enable

```bash
composer require drupal/scorm_field   # pulls drupal/attempt_mgmt (1.0.x-dev)
drush en scorm_field -y               # attempt_mgmt is enabled as a dependency
```

`scorm_field.info.yml` declares `core_version_requirement: ^10.2 || ^11` and
`dependencies: [drupal:attempt_mgmt]`. Enabling runs `scorm_field_update_10200()`-equivalent
install config: the `scorm` attempt type and the `field_score_raw/min/max` + `field_scorm_status`
fields on `attempt_mgmt_attempt` (`config/install/`).

## Add the field

*Structure → (content type) → Manage fields → Add field →* **Scorm field** (listed under the
**Reference** category — the field type annotation sets `category = @Translation("Reference")`).

- Field type id: **`scorm_field_scorm_package`**, class `ScormFieldScormPackage extends FileItem`
  (`src/Plugin/Field/FieldType/ScormFieldScormPackage.php`).
- `defaultFieldSettings()` forces `file_extensions = 'zip'` and `file_directory = 'scorm_field'`.
  `storageSettingsForm()` / `fieldSettingsForm()` return empty (no configurable storage/field UI).
- Default widget is **`file_generic`** (core file widget) — registered for this type by
  `scorm_field_field_widget_info_alter()`. There is no custom widget class.
- Item list class **`ScormFieldScormPackageItemList extends FileFieldItemList`** — this is where
  extraction is triggered (see below).

## Formatters

Set on *Manage display*:

| Formatter id | Class | Field types | Notes |
|---|---|---|---|
| `scorm_field_scorm_formatter` | `ScormFieldScormFormatter` | `scorm_field_scorm_package` | **The one to use.** Label *"Scorm player"*. Default formatter for the field. |
| `scorm_field_field_formatter` | `ScormFieldFieldFormatter` | `scorm_field_package` | Label *"Social Course Scorm player"*. Targets a field type (`scorm_field_package`) that this module does **not** define — effectively dead code. |

Both extend `EntityReferenceFormatterBase`. `viewElements()` loads the referenced file, calls
`ScormFieldScorm::scormLoadByFileEntity($file)`, then `ScormFieldScormPlayer::toRendarableArray($scorm, $nid)`.
Only the **first** delta renders a player; additional deltas render a note that SCORM allows only
one launched SCO at a time.

## Extraction pipeline (the core mechanic)

On node save, `ScormFieldScormPackageItemList::postSave($update)` iterates referenced files and calls
`\Drupal::service('scorm_field.scorm')->scormExtract($file)` for new files (and for updated files
that have no existing `scorm` DB row).

`ScormFieldScorm` (`src/ScormFieldScorm.php`):

1. **`unzipPackage(File $file)`** — `realpath()` the file URI, `(new \ZipArchive)->open()`, then
   `$zip->extractTo('public://scorm_field_extracted/scorm_' . $file->id())`. Errors are logged to
   the `scorm_field` channel with the `ZipArchive::ER_*` name.
2. **`scormExtract(File $file)`** — after unzip, expects `…/imsmanifest.xml`; parses it with
   `scormExtractManifestData()` and persists.
3. **`scormExtractManifestData($manifest_file)`** — `file_get_contents()` the XML, parse via
   **`XML2Array`** (`src/XML2Array.php`, a thin wrapper over PHP's expat `xml_parser_create()` —
   no `DOMDocument`/`simplexml`, so no external-entity/XXE surface), then extract:
   - `scormExtractManifestMetadata()` → manifest `<metadata>` (schemaversion etc., serialized).
   - `scormExtractManifestScos()` / `scormExtractManifestScosItems()` → flat SCO list with
     organization, identifier, parent_identifier, launch, type, scorm_type, title, weight,
     sequencing control modes + objectives (`scormExtractItemSequencing*`).
   - `scormExtractManifestResources()` → resource `HREF`/`TYPE`/`IDENTIFIER`.
   - `scormCombineManifestScoAndResources()` → merges resource `href` into each SCO's `launch`.
4. **`scormSave()` / `scormScoSave()`** — insert/update rows in `scorm_field_scorm_packages`,
   `scorm_field_scorm_package_scos`, `scorm_field_scorm_package_sco_attributes` (all via the
   `@database` connection query builder; attributes serialized when array/object).

`ScormPackageConstraintValidator` (`src/Plugin/Validation/Constraint/`) also calls `unzipPackage()`
during validation and, if the manifest is nested one folder deep, flattens that subfolder up into
the extract dir; it adds `missingManifestFile` if no `imsmanifest.xml` is found. (Note: this
constraint class file declares the wrong namespace — see the module's build-time caveats; it and
`ScormPackageConstraint` do not reliably load.)

## Playback

`ScormFieldScormPlayer` (`src/ScormFieldScormPlayer.php`):

- `toRendarableArray($scorm, $nid)` → `#theme => 'scorm_field_scorm__player'` render array with
  `#iframe_src = base_path . 'scorm-field-scorm/player/sco/' . $start_sco->id`, the SCO `#tree`,
  attempt confirm form, and `#attached` library `scorm_field/scorm-field-scorm-player` +
  `drupalSettings.scormFieldScormUIPlayer` (cmiPaths, cmiData, scoIdentifiers, cmiSuspendItems),
  `scormVersion`, and `playerMode: 'default'`. `#cache max-age: 0`.
- `getScormData()` decides `scorm_version` (`1.2` vs `2004`) from the manifest `schemaversion`,
  builds the SCO tree (`scormFieldScormPlayerScormTree` recursion over `parent_identifier`),
  picks the start SCO (first with a `launch`, or the last-viewed `user.sco`), and pulls CMI paths /
  data via `scorm_field_scorm_add_cmi_paths()` / `scorm_field_scorm_add_cmi_data()` (in
  `scorm_field.module`, invoked as hooks so other modules can extend the CMI model).
- `toRendarableArrayDecoupled()` is the decoupled variant (`…__player__decoupled` theme,
  `playerMode: 'decoupled'`, resets cmiData on forced/new attempts).

The bundled JS runtime (`js/lib/api-1.2.js`, `api-2004.js`, `player.js`, `scorm_field.player.js`)
exposes the SCORM API object the SCO expects and POSTs commits to the commit route; see
[../api/routes-services.md](../api/routes-services.md).
