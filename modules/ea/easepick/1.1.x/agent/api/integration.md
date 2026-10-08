<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easepick — integration & libraries

How to attach the easepick date picker to a form, the shipped libraries, and how to extend it. All behavior lives in `easepick.module`, `easepick.libraries.yml`, `assets/js/easepick.js`, `easepick.routing.yml`, and `src/Form/ExampleForm.php`. No settings, no config, no permissions to grant.

## Install / enable
`drush en easepick`. No dependencies, no Composer packages, no configuration step. Because all front-end assets are loaded from a CDN (`cdn.jsdelivr.net`), client browsers must be able to reach jsDelivr; nothing is stored locally except the small initializer.

## Enabling the picker on a form
The trigger is a value flag on the form array. In your form's `buildForm()` or in a `hook_form_alter()`:

```php
$form['easepick'] = [
  '#value' => TRUE,
  '#type'  => 'value',
];
```

`easepick_form_alter()` (in `easepick.module`) checks `isset($form['easepick']) && $form['easepick']['#value'] == TRUE` and, if so, attaches:

- `easepick/easepick.core`  — easepick core JS/CSS (from CDN)
- `easepick/drupal.easepick` — the local initializer `assets/js/easepick.js`

Attaching `easepick/easepick.bundle` is present but commented out because it breaks Olivero and some themes (drupal.org issue 3411027). Other plugin libraries are also listed commented-out as attach options.

## The initializer
`assets/js/easepick.js` runs in `Drupal.behaviors.easepick.attach` and does:

```js
const picker = new easepick.create({
  element: document.getElementById('edit-checkin'),
  css: ['https://cdn.jsdelivr.net/npm/@easepick/bundle@1.2.1/dist/index.css'],
});
```

It is hard-coded to the element whose HTML id is `edit-checkin` (i.e. a form field named `checkin`). To bind easepick to a different field, or to enable range/time/lock/preset behavior, write your own JS behavior, target your field id, pass the relevant easepick plugin options, and attach the matching library instead of relying on `drupal.easepick`. The initializer declares `core/drupal` and `core/once` as dependencies (behavior-safe on AJAX), though the shipped version does not itself call `once()`.

## Libraries (all CDN-sourced, `@easepick/*@1.2.1`)
Defined in `easepick.libraries.yml`; every JS/CSS entry is `type: external` pointing at `https://cdn.jsdelivr.net/npm/@easepick/...`:

- `easepick.bundle` — all packages (bundle JS + CSS).
- `easepick.core` — datetime + core JS, core CSS.
- `easepick.datetime` — datetime package JS only.
- `easepick.amp-plugin` — core + base-plugin + amp-plugin (extra options).
- `easepick.kbd-plugin` — keyboard navigation.
- `easepick.lock-plugin` — disable/lock days for selection.
- `easepick.range-plugin` — date-range selection.
- `easepick.preset-plugin` — predefined ranges (builds on range-plugin).
- `easepick.time-plugin` — time picker.
- `drupal.easepick` — local `assets/js/easepick.js`; deps `core/drupal`, `core/once`.

Each remote library declares `remote: https://github.com/easepick/easepick/`, `version: 1.2.1`, GPL license. Note the Drupal module release is `1.1.0` while the wrapped easepick JS library is `1.2.1`.

## Demo route & form
- Route `easepick.easepick_example` → path `/easepick/example`, `_title: 'Easepick Example'`, `_form: Drupal\easepick\Form\ExampleForm`, requirement `_permission: 'access content'`.
- `ExampleForm` (form id `easepick_example`, extends `FormBase`) builds: a required `checkin` textfield (weight -1000, the field the initializer binds to), a required `guests` select (1–3 guests), a `submit` button (`#type => button`), and the `easepick` value flag. `validateForm()` and `submitForm()` are empty — the form is a demo and does not persist or process any input. It exists only to render the picker.

## Operating notes
- Nothing to configure; behavior is entirely in code you write plus the form flag.
- To uninstall: `drush pmu easepick`. No config or content is left behind.
- The README's "Configuration" section is boilerplate (mentions "prevent the links from appearing") and does not describe this module's behavior.
