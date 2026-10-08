# REST endpoint: signup

REST resource plugin `ik_constant_contact_resource`
(`src/Plugin/rest/resource/ConstantContactResource.php`). Optional — requires the core `rest`
module and that you enable the resource (e.g. via `rest_ui` or a `rest.resource.*` config), which
sets its supported formats, authentication, and the permission that guards POST
(`restful post ik_constant_contact_resource`). Grant that permission to the role that should be
able to sign contacts up (commonly a decoupled client; anonymous only if you intend a public
endpoint).

## Request

```
POST /constant_contact/{list_id}
```

- `{list_id}` — a Constant Contact list UUID (the plugin also accepts an array of UUIDs).
- Body — the contact `$data` (JSON), same shape the service expects: `email_address` (required),
  plus optional `first_name`, `last_name`, `company_name`, address, `custom_fields`, etc.

## Behavior (`post()`)

1. Loads `ik_constant_contact.enabled_lists`. Every requested list id must be present and `=== 1`;
   otherwise throws `AccessDeniedHttpException` ("list is not enabled or does not exist"). This is
   a business check on top of the REST permission — a disabled list can never be posted to.
2. Calls `constantContact->submitContactForm($data, [$list_id])` and returns a
   `ModifiedResourceResponse` with the result.

## Notes

- The endpoint only forwards data to Constant Contact; it does not create Drupal entities.
- Access is governed by the REST resource's configured permission + authentication, plus the
  enabled-list gate above. As with any signup form, add your own spam/abuse controls (CAPTCHA,
  flood) at the site level if the endpoint is reachable anonymously.
