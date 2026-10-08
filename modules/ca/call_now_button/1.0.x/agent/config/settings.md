<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Call Now Button — settings, route, permission, attach mechanism

Everything this module does, grounded in source. No entities/plugins/services; just a config form,
a page attachment, a template, and a CSS/JS library.

## Install / enable

`drush en call_now_button`. No dependencies beyond core. The button does **not** appear until you
enable it and set a phone number in the settings form.

## Settings form

- Class: `Drupal\call_now_button\Form\CallNowButtonConfigForm` (`src/Form/CallNowButtonConfigForm.php`),
  extends `ConfigFormBase`; form id `call_now_button_config_form`.
- Route: `call_now_button.settings_form` → **`/admin/config/user-interface/call-now-button`**
  (`call_now_button.routing.yml`); `configure` link in `.info.yml` points here. Menu link
  `call_now_button.settings_form` under parent `system.admin_config_ui` (*Configuration → User interface*).
- `getEditableConfigNames()` → edits the single config object **`call_now_button.settings`**.
- `submitForm()` writes the four values below and calls `parent::submitForm()`. `buildForm()` also
  attaches the `call_now_button/global-styling` library to the form page.

### Config object `call_now_button.settings` (keys + form element)

| Key | Form element | Notes |
|-----|--------------|-------|
| `call_now_button_status` | checkbox | Master on/off. Button renders only when truthy. |
| `call_now_button_phone_number` | `number` (required) | Numeric only; becomes the `tel:` target. |
| `call_now_button_text` | textfield | Optional label shown beside the icon. |
| `call_now_button_popup_position` | radios | One of `right_corner`, `left_corner`, `center_bottom`, `full_bottom`. |

There is **no `config/schema/`** shipped, so these keys are untyped (config export still works; typed-data
validation and translation of the schema are absent).

## Permission & access

- One permission, `administer call now button` (`call_now_button.permissions.yml`), used as the route
  requirement `_permission: 'administer call now button'`. It is the only access control; grant it only to
  trusted admins.

## Attach / render mechanism (`call_now_button.module`)

`hook_page_attachments(&$attachments)`:
1. Returns early if `\Drupal::service('router.admin_context')->isAdminRoute()` — so the button never shows
   on admin pages.
2. Loads `call_now_button.settings`. If `call_now_button_status` is set, it reads phone number, text, and
   position (defaulting position to `right_corner`), builds a `#theme => 'call_now_button_theme'` render
   array, and renders it to a string with `\Drupal::service('renderer')->renderRoot(...)->__toString()`.
3. Stores that string in `$attachments['#attached']['drupalSettings']['call_now_button']` and attaches
   library `call_now_button/global-styling`.

`hook_theme()` declares template `call_now_button_theme` with variables `phone_number`, `button_text`,
`button_color` (declared but never populated or used), `position`.

`templates/call-now-button-theme.html.twig` outputs:

```
<div class="call-now-button-wrapper">
  {% if button_text|render is not empty %}
  <div class="call-now-button-text">{{ button_text }}</div>
  {% endif %}
  <a href="tel:{{ phone_number }}" class="call-now-button-phone-number"></a>
</div>
```

`js/call_now_button.js` (`Drupal.behaviors.callNowButton`): reads `settings.call_now_button` and does
`$("body").once().append(call_now_button)` to inject the wrapper into the page.

`css/call_now_button.css`: `.call-now-button-wrapper` is `display:none` by default and only becomes a
`position:fixed` flex element under `@media screen and (max-width: 767px)` (bottom-right, `z-index:999`,
phone-icon background from `image/call-now-button.png`). This is what makes it "mobile only."

## Operating notes / caveats (functional, not security)

- **Visibility gate quirk:** `hook_page_attachments()` only emits the button when the *current user* also
  has the `administer call now button` permission (`Drupal::currentUser()->hasPermission('administer call now button')`).
  In practice this means anonymous mobile visitors will **not** see the button unless that permission is
  granted to their role — arguably contrary to the module's stated purpose. Grant the permission to the
  desired audience, or patch this check, if the button must appear for the public.
- The `position` value is passed to the template but the shipped CSS/JS only implement the default
  bottom-right placement; `left_corner` / `center_bottom` / `full_bottom` have no corresponding styling.
- `phone_number` is a `number` field, so `+`, spaces, and country-code formatting cannot be entered through
  the UI; the `tel:` target is the bare digits saved.
- The library still declares a dependency on `core/jquery.once`, which is deprecated/removed in newer core;
  and `.once()` with no id is legacy jQuery-once usage.
