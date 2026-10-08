<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a webform's confirmation JavaScript (webform_ct)

There is **no module settings page** (`configure` is null). All configuration is **per webform**,
stored as a Webform third-party setting, and edited on the webform's Confirmation settings form.

## Where it lives in the UI

- Path: `/admin/structure/webform/manage/{webform}/settings/confirmation`
  (the "Confirmation" tab of a webform's settings — route `entity.webform.settings_confirmation`,
  form `webform_settings_confirmation_form`).
- `webform_ct_form_webform_settings_confirmation_form_alter()` (`webform_ct.module:43`) adds a
  `details` element titled **"Confirmation Javascript Code"** containing a `webform_codemirror`
  field (`#mode => 'javascript'`), machine key `confirmation_custom_javascript`.
- The field is only rendered/editable when the current user holds
  `webform_ct.administer_webform_confirmation_javascript` (`'#access' => $user_has_permission`).
  See [../permissions/permissions.md](../permissions/permissions.md).
- The field is `#states`-hidden unless the **confirmation type** is `page` or `inline`. It is
  hidden for `none`, `message`, `modal`, `url`, and `url_message`
  (`WebformInterface::CONFIRMATION_*` constants). A warning message is shown on the form stating
  this constraint. Only `page`/`inline` are actually supported (see the module `@todo` and issue
  3314878).

## Where the value is stored

- Webform third-party setting, namespace `webform_ct`, key `confirmation_custom_javascript`.
- Config schema: `webform.settings.third_party.webform_ct` →
  `confirmation_custom_javascript` (`string`), in
  `config/schema/webform_ct.settings.schema.yml`.
- It is saved by the extra validate handler `_webform_ct_form_validate()`
  (`webform_ct.module:91`), appended to `$form['#validate']`, which reads the submitted value and
  calls `$webform->setThirdPartySetting('webform_ct', 'confirmation_custom_javascript', $value)`.
  (The webform's own submit handler persists the entity.)
- The stored value is expected to include its own `<script>…</script>` tags (the field placeholder
  and the update hook both reflect this).

## Read / set the value from code

```php
// Read.
$js = $webform->getThirdPartySetting('webform_ct', 'confirmation_custom_javascript');

// Set (persist).
$webform->setThirdPartySetting('webform_ct', 'confirmation_custom_javascript', '<script>/* … */</script>');
$webform->save();
```

The same key can be set in a webform's exported config YAML under:

```yaml
third_party_settings:
  webform_ct:
    confirmation_custom_javascript: "<script>/* … */</script>"
```

## How it reaches the page

`webform_ct_preprocess_webform_confirmation()` (`webform_ct.module:113`) reads the third-party
setting and, when non-empty, appends it to the confirmation message render array. See
[../hooks/hooks.md](../hooks/hooks.md) for the exact mechanism.
