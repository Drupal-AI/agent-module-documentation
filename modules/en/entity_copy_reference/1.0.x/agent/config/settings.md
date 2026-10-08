<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — the copy settings wizard

Enable the module (`drush en entity_copy_reference`), then visit
**`/admin/config/development/entity-copy-reference/config`** (route `entity_copy_reference.form`,
menu link under *Configuration → Development*, perm `administer entity_copy_reference`, which is
`restrict access: TRUE`).

## Config form — `EntityCopyReferenceConfigForm`

`src/Form/EntityCopyReferenceConfigForm.php` is a plain `FormBase` (not `ConfigFormBase`) that
writes the config object `entity_copy_reference.settings`. It is a two-step wizard driven by the
protected `$step` property and `$form_state->setRebuild()`:

- **Step 1 — Content Type Selection.** Loads every `node_type` and renders a checkbox per type
  (`content_types[<type>]`). Submit ("Next") collects the checked type ids into
  `$this->selectedContentTypes` (`array_keys(..., 1)`) and rebuilds at step 2.
- **Step 2 — Reference Field Selection.** For each selected type it renders:
  - `prefix` and `suffix` text fields (title decoration applied to copies of that type);
  - a `<select>` for every field of type `entity_reference` **or** `entity_reference_revisions`
    on that bundle, except the ignore list `['type','revision_uid','author','uid']`. Options come
    from the `FIELD_OPTIONS` constant:
    - `0` — **Keep Reference** (copy points at the same target)
    - `1` — **Clone Referenced Entity** (target is recursively duplicated)
    - `2` — **Clear Reference** (field emptied on the copy)

  Submit ("Submit") builds `content_types[<type>]` with `prefix`, `suffix`, and a
  `reference_fields[<field>] = <option>` entry **only for fields whose option > 0** (option `0`
  is omitted, so "keep" is the effective default for any field not stored). It clears a legacy
  top-level `reference_fields` key if present, saves, shows a status message, and resets `$step`
  to 1.

## Config object — `entity_copy_reference.settings`

No config schema and no `config/install` default ship with the module, so the object is created
on first save. Shape:

```yaml
content_types:
  <node_type>:
    prefix: 'Copy of '
    suffix: ''
    reference_fields:
      field_paragraphs: 1   # clone
      field_related: 2      # clear
```

`EntityCopyReference::getConfig()` reads this object; if `content_types` is empty it logs
`"No copy settings were found"` and returns `[]`. A content type appears in the Copy UI only when
it has a key under `content_types` (see [../copy/mechanism.md](../copy/mechanism.md) for how
`isCopyEnabled()` uses this).

## Tests

`tests/src/Functional/ConfigFormTest.php` covers the config form.
