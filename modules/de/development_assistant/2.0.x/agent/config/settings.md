<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config storage

This release ships a form class and a config-storage helper, but **neither is exposed through a route** — there is no `development_assistant.routing.yml`, no `*.links.menu.yml`, and no `configure:` key in the info file. So there is no admin UI and no user-facing configuration. The classes are documented here for completeness.

## `Drupal\development_assistant\Form\Settings` (`src/Form/Settings.php`)
- `FormBase` subclass; `getFormId()` returns `development_assistant_settings`.
- `buildForm()` renders a single `api_uri` checkbox labelled "Api Url", defaulting from `browser_development`'s `FormsStorage::getStorage('development_assistant_settings')['browser_development_settings']['uri']` when present, otherwise from `$form_state->getValue('api_uri')`.
- `validateForm()` is empty.
- `submitForm()` calls `FormsStorage::setStorage('development_assistant_settings', ['uri' => $form_state->getValue('api_uri')])` and prints the stored value back via `messenger()`.
- **Cross-project import:** it `use`s `Drupal\browser_development\Processing\FormsStorage` (the sibling module's class), so instantiating this form requires `browser_development` to be installed. Because the form is unrouted, this path is never hit in a normal install and the module runs fine without `browser_development`.

## `Drupal\development_assistant\Processing\FormsStorage` (`src/Processing/FormsStorage.php`)
Static helper around the module's own config object `development_assistant.settings`:
- `setStorage($input)` → `storage($input)` → writes `$input` to the `form_input` key via `\Drupal::service('config.factory')->getEditable('development_assistant.settings')->set('form_input', $input)->save()`.
- `getStorage()` returns `\Drupal::config('development_assistant.settings')->get('form_input')`.

Note the signatures diverge from how `Settings::submitForm()` calls them (it passes a name + array; `setStorage()` accepts one `$input`). No config schema (`config/schema/*`) ships for `development_assistant.settings`.

## Config object
- `development_assistant.settings` — key `form_input`. Only written if the (unrouted) settings form is somehow submitted; not created on install. No `config/install` default ships.

## Practical guidance
- There is nothing to configure to use the module — enabling it is sufficient (see [stylesheet-attachment.md](../frontend/stylesheet-attachment.md)).
- To actually expose this form you would need to add a routing entry mapping a path to `Drupal\development_assistant\Form\Settings`; it is not shipped.
