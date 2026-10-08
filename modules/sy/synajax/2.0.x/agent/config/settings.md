<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynAjax configuration & behavior (2.0.x)

## Install / enable
`drush en synajax`. Core `^11 || ^12`. No composer requirements beyond core; `contact` is not a hard
dependency (the settings form degrades gracefully when it is absent), but the feature only applies to core
Contact forms, so enable `contact` to use it.

## Settings form
- Route `synajax.config` (`synajax.routing.yml`): path `/admin/config/content/synajax`,
  `_form: \Drupal\synajax\Form\SynajaxSettingsController`, requirement `_permission: 'administer site configuration'`.
- Menu link `synajax.config` (`synajax.links.menu.yml`) under `system.admin_config_content`
  ("Configuration > Content authoring").
- `SynajaxSettingsController` (`src/Form/SynajaxSettingsController.php`) extends `ConfigFormBase`, form id
  `synajax_settings_form`, editable config `synajax.settings`. It injects `entity_type.bundle.info` and
  `module_handler`.
- `buildForm()` renders a `details` group for the `contact_message` entity type. If `contact` is not enabled it
  shows a "Module does not enabled" notice; otherwise it renders:
  - `contact_message-mode` — radios: `disable`, `all`, `custom` (default from config).
  - `contact_message-bundles` — checkboxes of contact-form bundles (from `bundleInfo->getBundleInfo('contact_message')`),
    used only when mode is `custom`.
- `submitForm()` saves `contact_message-mode` and `contact_message-bundles` into `synajax.settings`.

## Config object
`synajax.settings` (default install value in `config/install/synajax.settings.yml`: `contact_message-mode: all`).
Keys:
- `contact_message-mode`: `disable` | `all` | `custom`.
- `contact_message-bundles`: map of `bundle => 0|bundle_id` (checkbox values); consulted only in `custom` mode.

No `config/schema/*.yml` is shipped, so these keys are untyped config.

## Enforcement logic
`synajax.module`'s `synajax_form_contact_message_form_alter()` delegates to
`FormContactMessageFormAlter::hook()` (`src/Hook/FormContactMessageFormAlter.php`):
1. Acts only when `$form['actions']['submit']['#ajax']` is set (the form already submits via AJAX).
2. Reads `synajax.settings`. If `contact_message-mode == 'all'`, enforcement is on. If `== 'custom'`, it derives
   the bundle key as `substr($form_id, 16, -5)` (strips the `contact_message_` prefix and `_form` suffix) and
   enforces only when that bundle is checked in `contact_message-bundles`.
3. When enabled, appends `FormContactMessageFormAlter::formValidate` to `$form['#validate']`.

`formValidate()` sets a form error ("Submit error, reload page and try again") when
`\Drupal::request()->request->get('_drupal_ajax')` is empty — i.e. the POST did not come through Drupal's AJAX
submission path. A direct (non-JS) POST therefore fails validation.

## Operate
- Set mode to `all` to require AJAX on every AJAX-enabled contact form; `custom` to scope to selected bundles;
  `disable` to turn it off.
- The requirement only takes effect on forms whose submit button already carries `#ajax`; a plain non-AJAX
  contact form is unaffected.
- Provides no permissions, services, plugins, hooks beyond the form alter, or Drush commands.

## Caveats
JS-requirement spam control blocks naive scripts that skip JavaScript, not headless/determined bots; and it can
break no-JS/accessibility clients. Treat it as one layer alongside CAPTCHA/honeypot/flood control.
