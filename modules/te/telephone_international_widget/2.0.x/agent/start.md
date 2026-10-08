<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telephone International Widget (telephone_international_widget) — agent index

One **field widget** for core's Telephone field. `@FieldWidget` id `telephone_international`
(label "International telephone"), extending core `TelephoneDefaultWidget`. It wraps the
`intl-tel-input` JS pattern: a country-flag dropdown with client-side, as-you-type formatting
and validation, normalizing valid input to the library's international form on blur. Depends on
core `telephone`. Version **2.0.0-rc2** (release candidate). Core `^10.1 || ^11`.

- **The widget: how it renders, the attached library, the JS behavior, settings, and how to
  select it on a field** → [fields/widget.md](fields/widget.md)

Key facts:
- Widget plugin: `Drupal\telephone_international_widget\Plugin\Field\FieldWidget\TelephoneInternationalWidget`,
  id `telephone_international`, `field_types = {"telephone"}`. Only overrides `formElement()`.
- `formElement()` renders `#type => textfield`, `#default_value` = stored value,
  `#placeholder` from the (inherited) `placeholder` setting, adds class
  `telephone_international_widget`, a static `#field_suffix` with `.valid-msg` / `.error-msg`
  spans, and attaches library `telephone_international_widget/intl-tel-input-widget`.
- **No custom settings form** — the only setting is `placeholder`, inherited unchanged from
  core `telephone_default`. Config schema `field.widget.settings.telephone_international`
  simply reuses `field.widget.settings.telephone_default`.
- JS (`js/telephone_international_widget.js`): `window.intlTelInput(input)` with **no options**
  (no geolocation / geoIpLookup, no separate `utilsScript`); on `blur`, valid → `iti.getNumber()`
  + "Valid" msg, invalid → `error` class + message from a fixed 5-entry error map.
- Library `intl-tel-input` is expected at `/libraries/intl-tel-input/build/js/intlTelInputWithUtils.js`
  (+ `css/intlTelInput.css`); installed via Composer `jackocnr/intl-tel-input` (type
  `drupal-library`), version unpinned (`VERSION`). Utils are bundled in the `WithUtils` build.
- **No** submodule, route, controller, service, permission, drush command, formatter, or
  `drupalSettings` usage.

**Two things to keep in mind:**
1. **All validation/formatting is client-side JavaScript.** It improves what most users submit
   but is trivially bypassed — anything relying on the stored number's shape must
   **revalidate server-side** (e.g. pair with `telephone_validation`).
2. **The widget adds a country list and JS to every form containing the field.** Cheap, but be
   deliberate on high-traffic public forms.
