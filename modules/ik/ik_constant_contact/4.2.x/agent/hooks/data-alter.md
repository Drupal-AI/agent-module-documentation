# Hooks — altering the Constant Contact payload

Declared in `ik_constant_contact.api.php`. All are `invokeAll` hooks fired inside the service just
before the contact body is sent, so you can inject custom fields or extra values.

| Hook | Fired in | When |
|---|---|---|
| `hook_ik_constant_contact_contact_data_alter(array $data, object &$body)` | `createContact`, `putContact`, `updateContact`, `submitContactForm`, `unsubscribeContact` | On every create AND update (the shared hook). |
| `hook_ik_constant_contact_contact_create_data_alter(array $data, object &$body)` | `createContact` | Only on contact creation. |
| `hook_ik_constant_contact_contact_update_data_alter(array $data, object &$body)` | `putContact`, `updateContact` | Only on contact update. |
| `hook_ik_constant_contact_contact_form_submission_alter(array $data, object &$body)` | `submitContactForm` | Only on the sign-up-form submission path. |
| `hook_ik_constant_contact_lists_mergevars_alter(&$mergevars, WebformSubmissionInterface $submission, WebformHandlerInterface $handler)` | Webform handler | Adjust mergevars mapped from a webform submission. |

`$data` is the posted form data; `$body` is the stdClass request body (pass by reference — mutate
it). Constant Contact custom fields go on `$body->custom_fields[]` as
`(object) ['custom_field_id' => '<uuid>', 'value' => …]`.

```php
function mymodule_ik_constant_contact_contact_data_alter(array $data, object &$body) {
  $body->custom_fields[] = (object) [
    'custom_field_id' => '00000000-0000-0000-0000-000000000000',
    'value' => $data['company'] ?? '',
  ];
  $body->company_name = $data['company'] ?? '';
}
```
