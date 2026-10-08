<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the custom 500 page

## The settings form

- Route `custom_500_error.custom_error_config_form` → `/admin/config/custom_500_error/customerrorconfig`.
- Permission: `access administration pages`. `options._admin_route: TRUE`.
- Form class `Drupal\custom_500_error\Form\CustomErrorConfigForm` (extends `ConfigFormBase`), form id
  `custom_error_config_form`.
- One field: `custom_error_markup`, `#type => 'text_format'` (`CustomErrorConfigForm.php:51`). The
  title/description ask for "custom text and html/css".
- `submitForm()` (`CustomErrorConfigForm.php:64`) calls `parent::submitForm()` then saves
  `$form_state->getValue('custom_error_markup')['value']` into
  `custom_500_error.customerrorconfig:custom_error_markup`. Only the `['value']` sub-key is stored —
  the text-format machine name the user picked is discarded and never applied on output.

## The config object

- Name: `custom_500_error.customerrorconfig`. Key: `custom_error_markup` (a raw string).
- There is **no `config/schema/`** for this module, so the key is untyped (typed-config reports no
  schema). Set it in code with the config factory, e.g.:

  ```php
  \Drupal::configFactory()
    ->getEditable('custom_500_error.customerrorconfig')
    ->set('custom_error_markup', '<h1>We\'ll be right back</h1>')
    ->save();
  ```

- Drush: `drush cset custom_500_error.customerrorconfig custom_error_markup '<h1>…</h1>'`.
- Install caveat: `config/install/custom_500_error.customerrorconfig.yml` contains only
  `custom_500_error:` (a null top-level key), so a fresh install has `custom_error_markup` unset.

## How it is rendered (the mechanism)

- `ExceptionSubscriber` extends core `HttpExceptionSubscriberBase`; `getHandledFormats()` returns
  `['html']`; `getPriority()` returns `4` (intentionally very low so any custom handler fires first).
- `on500(ExceptionEvent $event)` (`ExceptionSubscriber.php:59`) reads
  `custom_500_error.customerrorconfig:custom_error_markup` via the injected `config.manager`
  (`getConfigFactory()->get(...)`), then `$event->setResponse(new Response($content, 500))`.
- The stored string becomes the **entire** HTTP body verbatim — there is no template, no theme layer,
  no token replacement, and no `check_markup()`/filtering step. Whatever string is stored is what all
  users (including anonymous) receive on a 500 for an HTML request.
- Only 500 responses in the `html` format are affected; other status codes and formats (JSON, etc.)
  are untouched.
