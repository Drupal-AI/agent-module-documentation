<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Disable HTML5 validation works

## The whole module

```php
// disable_html5_validation.module
function disable_html5_validation_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['#attributes']['novalidate'] = 'novalidate';
}
```

That is the entire behavior. `hook_form_alter()` runs for **every** form built on the site, and
the handler adds the HTML5 `novalidate` attribute to the top-level form render array. The rendered
markup becomes `<form ... novalidate="novalidate">`, which instructs the browser to skip native
HTML5 constraint validation (`required`, `type=email`, `pattern`, `min`/`max`, `maxlength`, …) on
submit. The form still submits to Drupal, where server-side `#element_validate` and
`::validateForm()` run exactly as before.

## Scope

- **Global and unconditional** — admin forms, node/edit forms, login, registration, Views exposed
  filters, Webform, Contact, and custom forms all receive `novalidate`. There is no allow/deny list.
- **No configuration** — `configure` is null, there is no settings form, no config entity, no
  `config/install` or `config/schema`, no permissions, no Drush.
- **Rendered-attribute only** — it changes nothing about stored values or server-side validation.

## Verifying the effect

Build any form and inspect the attribute:

```php
$form = \Drupal::service('entity.form_builder')->getForm(
  \Drupal\node\Entity\Node::create(['type' => 'article', 'title' => 'x'])
);
$form['#attributes']['novalidate']; // 'novalidate'
```

Or view page source of any form and look for `novalidate` on the `<form>` tag.

## Excluding a single form (re-enable HTML5 validation)

The module offers no opt-out, so add your own module. **Ordering caveat (Drupal 10.3+/11):** alter
listeners are grouped and ordered **per module** (by module weight, then module name), *not* by
hook specificity. So a plain `hook_form_FORM_ID_alter()` that unsets `novalidate` is **not
reliable** — if your module sorts before `disable_html5_validation` (e.g. name `dhv_*` <
`disable_*`), its `hook_form_alter()` re-adds the attribute after yours ran. Two reliable options:

**Option A — `#after_build` (order-independent, recommended):** runs after all alters.

```php
function MYMODULE_form_user_login_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['#after_build'][] = 'MYMODULE_after_build';
}
function MYMODULE_after_build(array $form, FormStateInterface $form_state) {
  unset($form['#attributes']['novalidate']);
  return $form;
}
```

**Option B — make your module heavier:** set your module weight above `disable_html5_validation`
(`module_set_weight('MYMODULE', 100)`), then unset `novalidate` in a normal
`hook_form_FORM_ID_alter()`. Option A avoids depending on weights and is preferred.

## Turning it off everywhere

Uninstall the module (`drush pmu disable_html5_validation -y`). It stores no configuration, so
uninstalling cleanly removes the attribute from all forms with nothing left behind.
