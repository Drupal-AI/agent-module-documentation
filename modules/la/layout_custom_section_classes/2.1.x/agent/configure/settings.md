<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings

Form `GlobalSettingsForm` (`layout_custom_section_classes.settings` route) at
**`/admin/config/content/layout-builder-section-attributes`**. Config object:
**`layout_custom_section_classes.settings`** (schema `config_object`). Access: permission
`administer layout builder section classes module settings`.

## Config keys

```yaml
# layout_custom_section_classes.settings
allowed_section_attributes:          # which attributes editors may set on a SECTION
  id: true
  class_list: true
  class: true
  style: true
  data: true
allowed_section_region_attributes:   # same set, for REGIONS within a section
  id: true
  class_list: true
  class: true
  style: true
  data: true
class_list: []                       # predefined classes (sequence of strings)
relax_css_validation: false          # (bool) accept class/id as-is if true
```

- **`allowed_section_attributes.*`** / **`allowed_section_region_attributes.*`** — booleans that
  turn each attribute field on/off in the Configure-section form:
  `id`, `class` (free-text classes), `class_list` (checkbox list from `class_list`),
  `style` (inline CSS), `data` (`data-*`). Defaults: all `true`.
- **`class_list`** — the predefined classes editors can pick via checkboxes. One per line in the
  form (stored as a sequence). Optional friendly-name syntax `class-name|Friendly name`; the part
  before `|` is the actual class.
- **`relax_css_validation`** — when `true`, class names/IDs are accepted as-is (underscores,
  uppercase, etc.; HTML tags still stripped). When `false` (default), they must be valid CSS
  identifiers (`Html::cleanCssIdentifier()`), so `my!#class_1` is normalised to `my-class-1`.

## Read / set with drush

```bash
drush cget layout_custom_section_classes.settings
# turn OFF inline styles for sections:
drush cset layout_custom_section_classes.settings allowed_section_attributes.style false -y
# add predefined classes:
drush cset layout_custom_section_classes.settings class_list.0 'bg-dark|Dark background' -y
drush cset layout_custom_section_classes.settings class_list.1 'py-5' -y
```

(Or edit the config in `drush php:eval` via `\Drupal::configFactory()->getEditable(...)`.)

## Validation notes

- Inline styles are validated with the bundled **`neilime/php-css-lint`** linter (invalid CSS is
  rejected). `data-*` names must begin with `data-`. IDs must be valid CSS identifiers (unless
  `relax_css_validation`). Token patterns (`[...]`) skip CSS-identifier validation.
