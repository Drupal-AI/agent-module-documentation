<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `extension_reference` field type (+ widget, formatter, service)

## Install & enable

```bash
composer require drupal/extension_reference_field
drush en extension_reference_field -y
```

No dependencies beyond Drupal core. No sub-modules, no permissions of its own, no Drush commands, no
install/update hooks, no `config/install`, and no configuration form. `extension_reference_field.module`
implements only `hook_help()`.

## Add the field

UI: *Structure → (bundle) → Manage fields → Add field →* choose **Extension** (the field type
`extension_reference`, category *reference*). Then set the two **storage settings** (from
`ExtensionReferenceItem::storageSettingsForm()`), both required and **locked once the field has data**
(`#disabled = $has_data`):

| Setting | Values | Default | Meaning |
|---|---|---|---|
| `target_type` | `module`, `theme`, `profile` | `''` (must pick) | Which extension type this field references. Options from `ExtensionType::getOptions()`. |
| `status` | `enabled`, `disabled`, `all` | `all` (`ExtensionStatus::ALL`) | Which extensions appear as selectable options. Options from `ExtensionStatus::getOptions()`. |

## Storage & properties

`ExtensionReferenceItem::schema()` defines one column:

- `target_id` — `varchar(255)`, indexed (`indexes: target_id`). Holds the extension **machine name**.

`propertyDefinitions()`:

- `target_id` (string, required) — "The ID of the extension." `mainPropertyName()` returns `target_id`.
- `extension` (computed, read-only, `any`) — resolved to a core `\Drupal\Core\Extension\Extension` by
  `ExtensionComputed` (setting `target_id => 'target_id'`).

`isEmpty()` is true when `target_id` is `NULL` or `''`. `ExtensionReferenceItem::getExtension()` returns
the computed `extension` value.

### Computed `extension` property (`src/ExtensionComputed.php`)

`ExtensionComputed::getValue()` reads the sibling `target_id` and the field's `target_type` setting,
does `ExtensionType::from($target_type)` and calls `->getExtension($target_id)`, which delegates to the
core read-only list service `extension.list.module|theme|profile` `->get($id)`. The constructor throws
`InvalidArgumentException` if the definition lacks the `target_id` setting. This is a lazy, read-only
lookup — it never installs, enables, or changes any extension.

## Option list (`OptionsProviderInterface`)

`ExtensionReferenceItem` implements `getSettableOptions()` / `getSettableValues()` /
`getPossibleOptions()` / `getPossibleValues()`. `getSettableOptions()` builds
`ExtensionType::tryFrom($target_type)?->getExtensionList($status)` and maps each entry to
`['name'] ?? machine_name`. `ExtensionType::getExtensionList()` calls the core list service's
`getList()` and filters by status:

- `enabled` → extensions with truthy `->status`.
- `disabled` → **same body as `enabled`** (returns enabled extensions — see caveat).
- `all` → the full discovered list (enabled + disabled) unfiltered.
- anything else → throws `InvalidArgumentException('Invalid extension status.')`.

`generateSampleValue()` picks a random type and a random **enabled** extension of that type (used by
Devel-generate style tooling).

## Widget: `extension_reference_select`

`src/Plugin/Field/FieldWidget/ExtensionReferenceSelectWidget.php` is an empty subclass of core
`OptionsSelectWidget` with `multiple_values = TRUE`, targeting `field_types = { extension_reference }`.
It renders the settable options as a `<select>` (multiple when the field is multi-value) and relies on
core options validation, so a submitted value must be one of the field's settable options. Set it on
*Manage form display* (it is the default widget).

## Formatter: `extension_reference_label`

`src/Plugin/Field/FieldFormatter/ExtensionReferenceLabelFormatter.php` (default formatter). One setting:

- `link` (checkbox, default `FALSE`) — "Link label to extension on drupal.org if available."

`viewElements()` per item takes `$item->extension` (the computed `Extension`) and renders its name
(`$extension->info['name'] ?? $extension->getName()`):

- If `link` is on **and** a URL is available, it emits an anchor (`#type html_tag`, `#tag a`, href =
  the drupal.org project URL).
- Otherwise it emits `#plain_text` of the name (and attaches the raw `#extension` to the element).

`settingsSummary()` shows "Link to extension on drupal.org if available." or "No link". Set it on
*Manage display* (the default). The formatter injects the
`extension_reference_field.extension_drupal_org_data` service via `create()`.

## Service: `extension_reference_field.extension_drupal_org_data`

`src/ExtensionDrupalOrgData.php` (interface `ExtensionDrupalOrgDataInterface`, registered in
`extension_reference_field.services.yml`):

- `getInfo(Extension $extension): array` — returns `['project','version','datestamp']` from the
  extension's info **only when** the info carries a `project` key (i.e. a packaged drupal.org release).
- `getProjectUrl(Extension $extension): ?string` — returns
  `https://www.drupal.org/project/<project>` when a `project` is present, else `NULL`. A locally-written
  extension without drupal.org packaging metadata therefore yields no link.

## Config schema

`config/schema/extension_reference.schema.yml`:

- `field.storage_settings.extension_reference` → `target_type` (string), `status` (string).
- `field.value.extension_reference` → `target_id` (label), `extension` (label).

There is no config object of the module's own and no `config/install`; all configuration is per-field
(field storage/instance) and per view/form display.

### Example field storage config

```yaml
# field.storage.node.field_related_module (excerpt)
type: extension_reference
settings:
  target_type: module
  status: enabled
```

## Caveats (functional, not security)

- `ExtensionType::getExtensionList()` has the **`disabled` case return enabled extensions** (its body is
  identical to the `enabled` case). Selecting status *Disabled* therefore lists enabled extensions, not
  disabled ones. Use *Enabled and disabled* (`all`) if you need the not-installed extensions in the list.
- Storage settings (`target_type`, `status`) are locked once the field holds data, so choose them at
  creation time.
- Installed release is `1.2.3-beta1` — a pre-release; pin/verify before relying on it in production.
