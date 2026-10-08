<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable form-term visibility

tac_lite_create has **no settings page of its own**. It adds one checkbox to each tac_lite
**scheme** configuration tab (`/admin/config/people/tac_lite/scheme_<n>`):

- **"Visibility on create and edit forms"** — "Show terms when creating content. This does not
  control which users can create a given content type. This does control which terms appear on
  the node edit forms."

## Where the flag is stored

Inside the parent `tac_lite.settings` config, on the scheme config:

```
tac_lite_config_scheme_<n>:
  name: '…'
  perms: { … }
  tac_lite_create: true      # <- this submodule's flag
```

```bash
drush cget tac_lite.settings tac_lite_config_scheme_1
# look for tac_lite_create: true
```

Set it in code:

```php
$c = \Drupal::configFactory()->getEditable('tac_lite.settings');
$scheme = $c->get('tac_lite_config_scheme_1') ?: [];
$scheme['tac_lite_create'] = TRUE;
$c->set('tac_lite_config_scheme_1', $scheme)->save();
```

## Behavior

On a node add/edit form, for each scheme where `tac_lite_create` is true **or** the scheme
grants `update`, the module computes the user's allowed term ids (`_tac_lite_user_tids()`) and
unsets any term option the user may not use from taxonomy `select`/`radios`/`checkboxes`
widgets that reference a controlled vocabulary. `administer tac_lite` users are exempt; the
field's current default value is preserved. No node access rebuild is involved — this is a
pure form alteration.
