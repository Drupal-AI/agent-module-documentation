<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Bootstrap-Select Widget" field widget

## Install & enable

```bash
composer require drupal/bootstrap_select
drush en bootstrap_select -y
```

No Drupal module dependencies, no sub-modules, no permissions of its own, no Drush commands, no
install hook. The widget expects **Bootstrap v4** assets in the active theme (bootstrap-select is a
Bootstrap plugin).

## Enable it on a field

Plugin id **`bootstrap_select_widget`**, label *"Bootstrap-Select Widget"* (class
`BootstrapSelectWidget` extending core `OptionsWidgetBase`). It applies to these field types only:

- `entity_reference`
- `list_integer`
- `list_float`
- `list_string`

UI path: *Structure → (bundle) → Manage form display* (e.g.
`/admin/structure/types/manage/article/form-display`) → set the field's widget to **Bootstrap-Select
Widget** → click the gear to set the options below.

Config equivalent (form display):

```bash
drush cset core.entity_form_display.node.article.default \
  content.field_options.type bootstrap_select_widget -y
drush cr
```

## Widget settings

From `defaultSettings()`:

| Setting key | Default | Meaning / effect |
|---|---|---|
| `live_search` | `FALSE` | Adds a search box to the top of the dropdown → `data-live-search="true"`. |
| `actions_box` | `FALSE` | Adds *Select All* / *Deselect All* buttons → `data-actions-box="true"`. |
| `placeholder` | `''` | Text hint; rendered as the select's `title` attribute (escaped). |
| `header` | `''` | Label with a close button at the top of the menu → `data-header` (escaped). |
| `selected_text_format` | `value` | `value` = list the selected options; `count` = show a count. |
| `count_selected_text` | `{0} items selected` | Count template (only used when format is `count`) → `data-count-selected-text` (escaped). `{0}` = selected amount, `{1}` = total available. |

`settingsForm()` exposes all six as checkboxes/textfields/select; `settingsSummary()` prints the
active choices on the Manage-display summary line. Note the summary label for the count template is
localized in German ("Count Auswahltext") in the source.

There is **no config schema** shipped for these settings (no `config/schema/` directory), so strict
config-schema validation tooling may flag the widget settings in `core.entity_form_display.*`; the
settings still save and work.

### Example form-display config

```yaml
# core.entity_form_display.node.article.default
content:
  field_options:
    type: bootstrap_select_widget
    settings:
      live_search: true
      actions_box: true
      placeholder: 'Choose one or more'
      header: 'Options'
      selected_text_format: count
      count_selected_text: '{0} of {1} selected'
    third_party_settings: {  }
```

## How it renders (from source)

1. `formElement()` returns a core `#type => 'select'` element carrying `#bootstrap_select => TRUE`,
   `#options` from `getOptions($entity)`, `#default_value` from `getSelectedOptions($items)`,
   `#multiple` = the field is multi-valued **and** there is more than one option, and
   `#attributes` from `getAttributes()`.
2. `getAttributes()` translates each setting into a bootstrap-select `data-*` attribute (see table).
   Free-text settings (`header`, `placeholder`, `count_selected_text`) are run through
   `Html::escape()` before being placed in the attribute array.
3. `hook_theme_suggestions_select_alter()` sees `#bootstrap_select` and appends the suggestion
   `select__bootstrap_select`, so Drupal picks `templates/select--bootstrap-select.html.twig`.
4. That template adds classes `form-control bootstrap-select`, attaches
   `bootstrap_select/package` (the vendor CSS/JS) and `bootstrap_select/init`, and prints
   `<option>` children with Twig auto-escaping (`option.value`, `option.label`).
5. `assets/js/bootstrapSelectInit.js` (`Drupal.behaviors.bootstrapSelectInit`) calls
   `.selectpicker()` on every `select.bootstrap-select` in the render context, turning the plain
   select into the styled picker.

Option label handling comes from core `OptionsWidgetBase`; this widget overrides `sanitizeLabel()`
to `Html::decodeEntities(strip_tags($label))` (select options allow entities but not tags),
`supportsGroups()` → TRUE (so `<optgroup>` grouping works), and `getEmptyLabel()` to add a
"- None -" / "- Select a value -" empty option for single-value optional/required fields.

## Asset loading (CDN vs local)

Declared in `bootstrap_select.libraries.yml`:

- `package` library: **bootstrap-select 1.13.18** JS
  (`cdn.jsdelivr.net/npm/bootstrap-select@1.13.18/dist/js/bootstrap-select.min.js`) and CSS
  (`.../dist/css/bootstrap-select.min.css`), both `type: external`.
- `init` library: the local `assets/js/bootstrapSelectInit.js`.

`hook_library_info_alter()` (in `bootstrap_select.module`) checks for
`libraries/bootstrap-select/dist/js/bootstrap-select.min.js` and
`libraries/bootstrap-select/dist/css/bootstrap-select.min.css`; if present it **unsets the CDN
entries** and points the library at `/libraries/bootstrap-select/dist/...` instead. To self-host:
install the library into `web/libraries/bootstrap-select` (README documents the asset-packagist /
`npm-asset/bootstrap-select` composer route) and clear caches.

## Help page

`hook_help` for `help.page.bootstrap_select` returns `README.txt`. If the **markdown** module is
enabled it is rendered through the `markdown` filter plugin; otherwise it is returned as
`Html::escape()`d text inside `<pre>`. This is the only "page" the module adds — there is no
settings route.
