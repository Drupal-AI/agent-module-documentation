# Twig Field permissions

## `access twig fields` (restricted)

Defined in `twig_field.permissions.yml`:
```yaml
access twig fields:
  title: 'Create and edit templates stored in Twig fields'
  restrict access: true
```
`restrict access: true` makes Drupal show the "grant to trusted roles only" warning on the permissions
page. Grant it only to fully-trusted administrators.

## What it gates

`twig_field_entity_field_access()` (in `twig_field.module`) implements `hook_entity_field_access()`:
for the **`edit`** operation on any field of type `twig`, access is **forbidden** unless the account has
`access twig fields` (cache context `user.permissions`). So without the permission a user cannot set or
change a Twig template value, even if they can otherwise edit the entity. Viewing/rendering the field is
not gated by this permission (the compiled output is shown as part of normal entity display).

## Why this is a security boundary (by design — not a separate finding)

`TwigFormatter` renders the stored value with core `inline_template`
(`'#template' => $item->value`), i.e. **the field value is executed as Twig**. Twig templates can call
functions/filters and are effectively code, so an attacker who can set a template value can achieve
server-side template injection / RCE. The module deliberately confines that power to holders of the
restricted `access twig fields` permission and the README warns: *"Do not allow untrusted users to edit
Twig templates"* (see https://www.drupal.org/node/2860607).

Operational guidance:
- Never grant `access twig fields` to low-trust content roles.
- The field's `#element_validate` compiles the template on save only with the **global** context, so a
  syntactically valid template that references entity variables still saves; treat the value as trusted
  code, not as untrusted content.
