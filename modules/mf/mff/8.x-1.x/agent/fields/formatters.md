<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The mff file-field formatters

## Install & enable

```bash
composer require drupal/mff
drush en mff -y
```

No dependencies beyond core **`file`**. No sub-modules, no permissions, no Drush commands, no
routes, no services. `mff.module` implements only `hook_help` (help.page.mff).

## What they attach to

Both formatters declare `field_types = { "file" }`, so they apply to **core file fields only**
(the "Add file" field type). Despite the project name "Media File Formatters" and the `Media`
package, they do **not** target media-reference (`entity_reference` to media) fields.

UI path: *Structure → (bundle) → Manage display* → set a **File** field's format to one of the two
below → click the gear for its settings.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_attachment.type mff_name_link_formatter -y
drush cr
```

## Formatter 1 — "Name field link text" (`mff_name_link_formatter`)

Class `MffNameLinkFormatter` extends core `FileFormatterBase`
(`src/Plugin/Field/FieldFormatter/MffNameLinkFormatter.php`).

- `viewElements()` builds, per file, a `#theme => 'file_link'` render element with
  `#description` = **the parent entity's label** (`$item->getEntity()->label()`) — i.e. the link
  text is the node/entity title, not the filename or the file description.
- `#link_options` gets `attributes.target = '_blank'` when the `open_in_new_window` setting is on.
- Attaches `#cache.tags` = `$file->getCacheTags()`; forwards `$item->_attributes` then unsets them.

Settings (`defaultSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `open_in_new_window` | `FALSE` | Adds `target="_blank"` to the link (`settingsSummary()` shows "Open in a new window."). |

Config schema: `field.formatter.settings.mff_name_link_formatter` (mapping with boolean
`open_in_new_window`) in `config/schema/mff.schema.yml`.

Example view-display config:

```yaml
# core.entity_view_display.node.article.default
content:
  field_attachment:
    type: mff_name_link_formatter
    label: above
    settings:
      open_in_new_window: true
```

Tip (from the project notes): to show the file's own description **alongside** the name-as-link,
print it in the field template with `{{ file._referringItem.description }}`.

## Formatter 2 — "File field description text" (`mff_description_formatter`)

Class `MffDescriptionFormatter` extends core `DescriptionAwareFileFormatterBase`
(`src/Plugin/Field/FieldFormatter/MffDescriptionFormatter.php`).

- When `use_description_as_link_text` is **on**: emits `#theme => 'file_link'` with
  `#description` = `$item->description` (the file item's description becomes the link text).
- When **off**: emits `#type => 'processed_text'`, `#text` = `$item->description`,
  `#langcode` = `$item->getLangcode()` — the description is rendered as text with **no link**.
  This is the "show the file field's description in Views without adding a new field" use case.
- Attaches `#cache.tags` = `$file->getCacheTags()`; forwards `$item->_attributes` then unsets them.

Settings (`defaultSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `use_description_as_link_text` | `FALSE` | On: link the description to the file. Off: render the description as standalone processed text (no link). |

No config schema is defined for this formatter's `use_description_as_link_text` key, so strict
config-schema tooling may flag the view-display config; the setting still saves and works.

Example view-display config:

```yaml
content:
  field_attachment:
    type: mff_description_formatter
    label: hidden
    settings:
      use_description_as_link_text: false
```

## Access & caching

Both formatters iterate `getEntitiesToView($items, $langcode)`, so files the current user cannot
access (per core file access) are excluded, and per-item display flags are honored. Each element
carries the file's cache tags, so rendered output invalidates when the file entity changes.
