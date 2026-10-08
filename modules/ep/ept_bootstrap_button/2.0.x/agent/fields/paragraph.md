<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ept_bootstrap_button` paragraph type

## Install & enable

```bash
composer require drupal/ept_bootstrap_button
drush en ept_bootstrap_button -y
drush cr
```

Pulls in `ept_core` (`^2.0`) and `paragraphs` (`^1.0`); the installed config also depends on core
`link` and `text`. Enabling imports the bundle and its four fields from `config/install/`. There is
**no settings route** — nothing to configure globally in this module (shared design defaults, e.g.
Bootstrap primary/secondary colors and breakpoints, live on `ept_core`'s EPT settings form).

## The bundle and its fields

Bundle id **`ept_bootstrap_button`** (`paragraphs.paragraphs_type.ept_bootstrap_button.yml`), label
"EPT Bootstrap Button", no behavior plugins. Fields (each `field.field.paragraph.ept_bootstrap_button.*.yml`):

| Field | Type | Required | Notes |
|---|---|---|---|
| `field_ept_bootstrap_button_link` | core `link` | yes | The button. Storage cardinality 1, `link_type: 17` (external + internal), `title: 2` (title required). |
| `field_ept_settings` | `ept_settings` (ept_core) | no | Holds button options + `ept_core` design options. |
| `field_ept_title` | `text_long` | no | Optional heading rendered in an `<h2>` above the button. |
| `field_ept_text` | `text_long` | no | Optional text; the default template suppresses it via `without()`. |

**Form display** (`core.entity_form_display…default.yml`): `field_ept_title` (`text_textarea`,
2 rows), `field_ept_text` (`text_textarea`, 5 rows), `field_ept_bootstrap_button_link`
(`link_default`), `field_ept_settings` (**`ept_settings_bootstrap_button`** widget). `created` and
`status` are hidden.

**View display** (`core.entity_view_display…default.yml`): link uses `link` formatter
(`trim_length: 800`), settings use `ept_settings_default`, title/text use `text_default`; all labels
hidden.

## The settings widget

`EptSettingsBootstrapButtonWidget` (`src/Plugin/Field/FieldWidget/EptSettingsBootstrapButtonWidget.php`,
id **`ept_settings_bootstrap_button`**, `field_types = { ept_settings }`) extends
`ept_core`'s `EptSettingsDefaultWidget`. `formElement()` calls `parent::formElement()` (which adds
the shared "Design options" — CSS box, background, container width) and then adds a **"Button
options"** `details` group with these elements, each stored under `ept_settings[...]`:

| Key | Element | Default | Effect at render |
|---|---|---|---|
| `open_in_new_tab` | checkbox | — | adds `target="_blank"` |
| `add_nofollow` | checkbox | — | adds `rel="nofollow"` |
| `alignment` | radios left/center/right | `left` | wrapper class `ept-align-{left,center,right}` |
| `button_type` | radios (9 options) | `primary` | class `btn-{type}` (required) |
| `outline_button` | checkbox | — | switches to `btn-outline-{type}` |
| `active_button` | checkbox | — | adds `active` |
| `disable_button` | checkbox | — | adds `disabled` (links can't use the `disabled` attr) |
| `size` | radios default/`btn-sm`/`btn-lg` | `size-default` | adds the size class |
| `stetched` | checkbox | — | wrapper class `ept-stretched` (note the misspelled key) |
| `custom_class_name` | textfield | `''` | appended to the button classes |

`button_type` options: `primary, secondary, success, danger, warning, info, light, dark, link`.

`custom_class_name` has an `#element_validate` of
`\Drupal\ept_core\Helper\EptGenericValidator::validateClassElement` — it splits on spaces and
rejects the value unless **every** token matches `^[a-zA-Z][a-zA-Z0-9_-]*$` (so no spaces within a
class, no quotes, no special characters).

`massageFormValues()` flattens the nested `ept_settings['button_options'][$key]` values back up to
`ept_settings[$key]` on save (it only processes `$values[0]`, i.e. the single delta).

## How the button is rendered

Template `templates/paragraph--ept-bootstrap-button--default.html.twig`:

1. Builds a wrapper `classes` array (`paragraph`, `ept-paragraph`, `ept-bootstrap-button`,
   type/view-mode classes, alignment, `ept-stretched`).
2. Builds `button_classes = ['btn']`, then merges `btn-{type}` or `btn-outline-{type}`, plus
   `active` / `disabled` / size / the `custom_class_name`.
3. Sets `nofollow` and `target` to the literal strings ` rel="nofollow"` / ` target="_blank"`
   depending on the checkboxes.
4. Attaches `ept_bootstrap_button/ept_bootstrap_button_view`.
5. Emits (heading optional):

```twig
<a href="{{ content.field_ept_bootstrap_button_link.0['#url'] }}"
   class="{{ button_classes|join(' ') }}" {{ nofollow|raw }} {{ target|raw }}>{{ content.field_ept_bootstrap_button_link.0['#title'] }}</a>
```

then prints the remaining fields with `content|without('field_ept_settings',
'field_ept_bootstrap_button_link', 'field_ept_title')`, and finally `{{ styles|raw }}` — the
per-paragraph CSS string that `ept_core`'s `GenerateCSS` service produces from the design options
(set as the `styles` variable by `ept_core`'s paragraph preprocess).

The button href/title come from the resolved core `link` field element (`#url` Url object,
`#title` string); the class list and attributes come from the settings above.

## Overriding

- Theme override: copy the Twig template into your theme and adjust markup/classes.
- The CSS library only styles alignment/stretch helpers (`css/ept_bootstrap_button_view.css`); the
  `btn*` look comes from your Bootstrap theme, not from this module.
- To change field widgets/formatters, edit the paragraph's form/view display like any other bundle.
