<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Better Link" field widget

## Install & enable

```bash
composer require drupal/better_links
drush en better_links -y
```

Only dependency is core **`link`** (`better_links.info.yml`: `dependencies: [drupal:link]`). No
sub-modules, no permissions of its own, no Drush commands, no update hooks.

## Enable it on a field

The widget (plugin id **`better_links_field_widget`**, label *"Better Link"*) applies to **core
link fields** (`field_types = { "link" }`). It extends
`Drupal\link\Plugin\Field\FieldWidget\LinkWidget`, so it is a superset of the standard link widget.

UI path: *Structure → (bundle) → Manage form display* → set the link field's widget to **Better
Link** → click the gear to configure the modes below.

Drush / config equivalent (entity **form** display, not view display):

```bash
drush cset core.entity_form_display.node.article.default \
  content.field_link.type better_links_field_widget -y
drush cr
```

## Widget settings

`defaultSettings()` in `BetterLinksFieldWidget.php` adds these on top of `LinkWidget`'s
(`placeholder_url`, `placeholder_title`):

| Setting key | Default | Meaning |
|---|---|---|
| `better_links_class_mode` | `manual` | How the CSS class is set: `force_class`, `select_class`, or `manual`. |
| `better_links_class_force` | `btn btn-primary` | The class string forced on every link (used only in `force_class` mode). |
| `better_links_class_select` | `btn btn-default\|Default`<br>`btn btn-primary\|Primary`<br>`btn btn-link\|Link` | Newline list of selectable classes as `key\|label` (used only in `select_class` mode). |
| `better_links_target_mode` | `manual` | How the target is set: `force_target` or `manual`. |
| `better_links_target_force` | `_self` | The target forced on every link (used only in `force_target` mode). |

`settingsForm()` renders radios for each mode plus conditional inputs shown via `#states` (the
force-class textfield, the select-class textarea, and the force-target select). `settingsSummary()`
prints the active class/target mode and, for force/select modes, the class(es) or target chosen.

### Class modes (`better_links_class_mode`)

`formElement()` sets `$element['options']['attributes']['class']` per mode:

- **`force_class`** — a `#type => value` element whose value is `better_links_class_force`. Editors
  never see or change it; every link in the field gets that class string.
- **`select_class`** — a `select` element whose `#options` are `['' => '- None -'] +
  getClassSelectOptions(better_links_class_select)`. `getClassSelectOptions()` splits the textarea
  on CR/LF, `array_filter`s blanks, and for each line does `list($class, $label) = explode('|',
  …)`, defaulting `$label` to the key. Editors pick one class string from the curated list.
- **`manual`** — a plain `textfield`; the editor types any space-separated class string.

### Target modes (`better_links_target_mode`)

`formElement()` sets `$element['options']['attributes']['target']` per mode:

- **`force_target`** — a `#type => value` fixed to `better_links_target_force`.
- **`manual`** — a `select` with the fixed options from `getTargetSelectOptions()`:
  `_self` (None), `_blank` (New Window), `_parent` (Parent Window), `_top` (Top Window); defaults
  to the item's stored target or `_self`.

There is **no `select_target`** mode — the target has only *force* and *manual*. (Note: two form
labels in `settingsForm()` both read *"Method for adding class"*, including the target-mode radios —
a cosmetic label bug, not a functional one.)

## Where the values live & how they render

The class/target chosen by the editor are written into the link field item's
`options.attributes.class` / `options.attributes.target`. This module does **not** render links
itself — output is produced by core's link field formatter, which passes `options.attributes`
through Drupal's attribute rendering (values are HTML-attribute-escaped). The link URL itself is
still validated by the core link field/`LinkWidget` (this module does not touch URL handling), so
Better Links only governs the class and target attributes.

## Config schema

`config/schema/better_links.schema.yml` defines
`field.widget.settings.better_links_field_widget` (a `mapping`) covering `placeholder_url`,
`placeholder_title`, and the five `better_links_*` keys above — so the widget settings validate
under strict config-schema tooling and export cleanly with the form display.

## Notes / caveats

- Applies to the **form display** (widget), not the view display (formatter). Setting it on a view
  display does nothing.
- `getClassSelectOptions()` assumes each non-blank line is well-formed; a line with no `|` yields
  an undefined `$label` before the `?:` fallback (a benign PHP notice on old configs), and a line
  that is only `|` produces an empty-string class.
- `composer.json` declares `GPL-3.0`, but the Drupal.org package is licensed **GPL-2.0-or-later**
  (used here); the `.info.yml` states no explicit license (Drupal default).
