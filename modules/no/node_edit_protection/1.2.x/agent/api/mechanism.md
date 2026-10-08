<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

Two files: `node_edit_protection.module` (one hook) and `node-edit-protection.js` (one
behavior), plus `node_edit_protection.libraries.yml`. No config, no PHP class, no plugin.

## Attaching the library (PHP)

`node_edit_protection_form_alter(&$form, $form_state, $form_id)` attaches the library only when
the form is a node form:

```php
$class = $form['#attributes']['class'] ?? NULL;
if (is_array($class) && !empty($class) && array_search('node-form', $class)) {
  $form['#attached']['library'][] = 'node_edit_protection/node_edit_protection';
}
```

So the trigger is entirely the presence of the **`node-form`** class on the form's attributes —
which core sets on node add/edit forms. It does not target by form id.

## The library

`node_edit_protection.libraries.yml`:

```yaml
node_edit_protection:
  version: 1.x
  js:
    node-edit-protection.js: {}
  dependencies:
    - core/jquery
    - core/drupal
```

## The behavior (JS)

`Drupal.behaviors.nodeEditProtection` (in `node-edit-protection.js`) keeps two flags, `edit`
(dirty) and `click` (a real submit is happening):

- On blur of any `.node-form :input`, set `edit = true` (form considered changed).
- Every `.node-form` submit button/input is tagged `node-edit-protection-processed` and, on
  click, sets `click = true` so saving does not trigger the warning.
- All other `a`, `button`, and non-processed submit clicks return early for `href="#"` links so
  in-page anchors don't fire the guard.
- `window.onbeforeunload` returns `Drupal.t("You will lose all unsaved work.")` when
  `edit && !click`. Before that check it loops `CKEDITOR.instances` and calls `checkDirty()` so
  unsaved rich-text edits also count as dirty.

The returned string is what the browser shows in its native "Leave site?" confirmation (modern
browsers may show their own generic wording but still gate on a truthy return).

## Extending to non-node forms

There is no config to point it elsewhere. To protect another form, either:

- attach the library in your own `hook_form_alter`:
  `$form['#attached']['library'][] = 'node_edit_protection/node_edit_protection';`, **and**
- ensure the form markup carries the `node-form` class (the JS selectors are hard-coded to
  `.node-form`), e.g. `$form['#attributes']['class'][] = 'node-form';`.
