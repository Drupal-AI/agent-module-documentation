# Field Label — configuration

## Global settings (`field_label.settings`)

Route `field_label.module_config_form` → `/admin/config/content/field-label`
(permission `administer site configuration`). Config object `field_label.settings`:

| Key | Type | Default | Effect |
|---|---|---|---|
| `label_value_enabled` | bool | `true` | Enables the "Label value" override field |
| `plural_label_enabled` | bool | `false` | Enables the "Plural label" field (multi-value fields only) |
| `label_tag_enabled` | bool | `true` | Enables the "Label wrapper" tag select |
| `label_class_enabled` | bool | `true` | Enables the free-form "Extra label classes" field |
| `label_class_select_enabled` | bool | `false` | Enables the "Label class" select list |
| `allowed_tags` | sequence(string) | `[div, span, h2, h3, h4, h5, h6]` | Tags offered in the wrapper select |
| `class_list` | string | `''` | Newline list of `.selector\|Label` lines powering the class select |

`class_list` lines must match `^(\.[a-zA-Z0-9_-]+)+\| *.+$`, e.g.:

```
.text-uppercase|Uppercase
.visually-hidden|Hidden (screen-reader only)
```

A feature only appears on formatter forms if its `*_enabled` flag is `true` **and** the user
holds the matching permission (see permissions doc).

Set via drush, e.g.:

```bash
drush config:set field_label.settings label_class_select_enabled true -y
drush config:set field_label.settings class_list ".text-uppercase|Uppercase" -y
```

## Per-field overrides (where the actual customizations live)

On any *Manage display* form, open a field's formatter cog → **Label settings** and fill in
the enabled options. These are saved as third-party settings on that formatter component:

```
core.entity_view_display.<entity>.<bundle>.<mode>:
  content:
    <field>:
      third_party_settings:
        field_label:
          label_value: 'Article text'      # overrides variables['label']
          plural_label: 'Authors'          # used when multiple items render
          label_class: 'text-uppercase'    # space-separated free-form classes
          label_class_select: '.visually-hidden'  # a selector from class_list
          label_tag: 'h3'                  # a tag from allowed_tags
```

Read/write programmatically with the formatter component API:

```php
$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$component = $display->getComponent('body');
$component['third_party_settings']['field_label']['label_value'] = 'Article text';
$display->setComponent('body', $component)->save();
```

Config schema key for these: `field.formatter.third_party.field_label`.

## Render + theming requirement

`hook_preprocess_field()` applies the settings: it replaces `variables['label']` (and the
plural variant), appends cleaned classes to `title_attributes.class`, and sets a
`label_tag` variable. Core's `field.html.twig` is overridden by the module's own template so
the tag works out of the box, **but a theme that ships its own `field*.html.twig` must use**:

```twig
<{{ label_tag|default('div') }}{{ title_attributes }}>{{ label }}</{{ label_tag|default('div') }}>
```

Otherwise `label_value`, classes and plural label still apply, but the custom wrapper tag is
ignored (the theme template wins — the module only overrides the *core* field template).
