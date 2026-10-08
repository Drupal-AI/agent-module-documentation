<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# "Label as Bulma tag" field formatter

`src/Plugin/Field/FieldFormatter/LabelsAsBulmaTagsFormatter.php` — formatter id
**`drulma_entity_reference_label_tags`**, label *"Label as Bulma tag"*, for **`entity_reference`**
fields. Extends core `EntityReferenceLabelFormatter`, so it inherits the linked-label behavior
(labels optionally link to the referenced entity) and wraps each label in Bulma `tag` markup.

Typical use: render a taxonomy-term reference (e.g. `field_tags`) as a row of Bulma tags on the
entity display.

## Enable it

*Structure → (entity type/bundle) → Manage display* → set the entity-reference field's format to
**Label as Bulma tag** → gear for options. Config equivalent:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_tags.type drulma_entity_reference_label_tags -y
drush cr
```

## Settings

`defaultSettings()` (plus the parent's `link` setting); schema
`field.formatter.settings.drulma_entity_reference_label_tags`:

| Key | Default | Meaning |
|---|---|---|
| `size` | `''` | `normal` / `medium` / `large` → Bulma `is-<size>` class. |
| `color` | `''` | Bulma color → `is-<color>` (`black`,`dark`,`light`,`white`,`primary`,`link`,`info`,`success`,`warning`,`danger`). |
| `rounded` | FALSE | Adds `is-rounded`. |
| `inline` | TRUE | Wrap all tags in a `#type => container` with class `tags` (Bulma tag group). |

`settingsSummary()` reports color, size, rounded, and inline on the Manage-display line.

## How it renders

`viewElements()` calls `parent::viewElements()` then, per delta, builds a class list starting
`['tag']` and appends `is-<size>`, `is-<color>`, `is-rounded` from settings. For a link item
(`#type === 'link'`) it adds those classes to `#options['attributes']['class']`; otherwise it wraps
the item with a `#prefix`/`#suffix` `<span class="tag …">`. When `inline` is on, the whole set is
nested inside a `.tags` container element. The tag/color/size CSS classes are fixed values chosen
from the settings selects; the referenced label text is produced (and escaped) by the parent
formatter.
