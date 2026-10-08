<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Toggle (bootstrap_toggle) — agent index

Renders a core **boolean** field's checkbox as a **Bootstrap Toggle on/off switch**, using the
third-party `minhur/bootstrap-toggle` JavaScript library (2.2.2, MIT). Provides a **field widget**
and a matching read-only **field formatter**, both id `bootstrap_toggle_switch`, both restricted to
the `boolean` field type. Version **2.1.1**. Core `^8.9 || ^9 || ^10 || ^11`.

## What it actually is
- **NOT a `#type` render element.** There is no custom Form API element. The widget builds a plain
  `#type => checkbox` and tags it with `data-toggle="toggle"` plus `data-*` attributes; a JS
  behavior (`js/bootstrap_toggle_reattach.js`) calls `.bootstrapToggle()` on those checkboxes.
- **A boolean field widget** (`src/Plugin/Field/FieldWidget/BootstrapToggle.php`) — the primary
  feature. Set it on **Manage form display** for a boolean field.
- **A boolean field formatter** (`src/Plugin/Field/FieldFormatter/BootstrapToggleFormatter.php`) —
  extends core `BooleanFormatter`, internally instantiates the widget, and renders the switch
  `disabled` + `checked` on entity display (read-only; the workaround uses `#attributes`, not
  `#default_value`, because a disabled non-form checkbox ignores the latter).

## The library is not bundled
- `bootstrap_toggle.libraries.yml` points at `/libraries/bootstrap_toggle/js/bootstrap-toggle.min.js`
  and `.../css/bootstrap-toggle.min.css` — the site's libraries directory, not the module.
- Install the library there (manual download of
  `https://github.com/minhur/bootstrap-toggle/archive/master.zip`, folder renamed to
  `bootstrap_toggle`, or a `drupal-library` composer package).
- `bootstrap_toggle.install` → `hook_requirements()` raises `REQUIREMENT_ERROR` ("Missing
  bootstrap_toggle library!") on the status report until both files are found.
- Library is attached lazily: the widget sets `$form_state->set('attached_toggle', TRUE)`, and
  `bootstrap_toggle_form_alter()` attaches `bootstrap_toggle/bootstrap_toggle` only when that flag
  is set. Library deps: `core/drupal`, `core/jquery` (jQuery-dependent).

## Settings (widget defaultSettings / config schema `field.widget.settings.bootstrap_toggle_switch`)
- `display_label` — 0 = show field label, 1 = show no label (default 1). Drives `data-on`/`data-off`
  and the element `#title`.
- `bootstraptoggle_data_on` / `_data_off` — custom On/Off text (default "On"/"Off") → `data-on` /
  `data-off`.
- `bootstraptoggle_box_size` — 0 Large / 1 Normal / 2 Small / 3 Mini (default 1) → `data-size`.
- `bootstraptoggle_on_style` / `_off_style` — 0 primary / 1 success / 2 info / 3 warning / 4 danger /
  5 default → `data-onstyle` / `data-offstyle` (defaults on=0 primary, off=5 default).
- `bootstraptoggle_box_height` / `_box_width` — optional; only emitted when **numeric**
  (`is_numeric` guard) → `data-height` / `data-width`.

## Theming
- `hook_theme()` registers `form_element_label__toggle` (template
  `templates/form-element-label--toggle.html.twig`, base hook `form-element-label`).
- `hook_theme_suggestions_form_element_alter()` adds a `form_element__toggle` suggestion for
  checkboxes carrying `data-toggle="toggle"`; `preprocess_form_element__toggle` swaps the label theme.
- The switch only *looks* right where a **Bootstrap-based theme** renders the form/display.

## Gotchas
- Widget targets the `boolean` field type ONLY. Not a general checkbox replacement, not a settings-form
  element.
- Templates use Bootstrap 3/4 class names (`control-label`, `help-block`, `sr-only`); expects a
  Bootstrap theme.
- No permissions, no routes, no services, no Drush, no update hooks. Config lives in the field's
  form-display / display config.

## Files
- `bootstrap_toggle.module` — help, form_alter (library attach), theme hooks.
- `bootstrap_toggle.libraries.yml` — library definition (library dir paths).
- `bootstrap_toggle.install` — hook_requirements (library presence check).
- `bootstrap_toggle.info.yml`, `composer.json` — no runtime deps beyond core.
- `src/Plugin/Field/FieldWidget/BootstrapToggle.php` — the widget (see `agent/fields/`).
- `src/Plugin/Field/FieldFormatter/BootstrapToggleFormatter.php` — the formatter.
- `config/schema/bootstrap_toggle.schema.yml` — widget settings schema.
- `js/bootstrap_toggle_reattach.js` — behavior that calls `.bootstrapToggle()`.
- `templates/form-element-label--toggle.html.twig` — Bootstrap label markup.

See `agent/fields/bootstrap-toggle-widget.md` for the widget/formatter integration detail.
