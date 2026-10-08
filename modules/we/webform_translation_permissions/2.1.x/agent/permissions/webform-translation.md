# Webform translation permissions

## The two permissions (`webform_translation_permissions.permissions.yml`)

| Permission | Grants |
|---|---|
| `translate any webform` | Translate the configuration of **any** webform. |
| `translate own webform` | Translate only webforms whose owner is the current (authenticated) user. |

Grant them at *People » Permissions*
(`/admin/people/permissions/module/webform_translation_permissions`) or per role:

```bash
drush role:perm:add translator 'translate any webform'
drush role:perm:add webform_author 'translate own webform'
```

The point of the module: without it, translating a webform requires core's site-wide
`translate configuration` permission (which grants translation of **every** config entity).
These permissions scope that down to webforms.

## How access is enforced

1. `hook_config_translation_info_alter()` sets the webform config-translation mapper class to
   `Drupal\webform_translation_permissions\ConfigTranslation\WebformMapper` (extends
   `ConfigEntityMapper`).
2. `WebformMapper::processRoute()` replaces the translation routes' requirement with
   `_webform_translation_form_access: 'TRUE'`.
3. The service `webform.translation_form_access`
   (`WebformTranslationFormAccess`, tagged `access_check` with
   `applies_to: _webform_translation_form_access`, extends core
   `ConfigTranslationFormAccess`) grants access when **all** hold:
   - the user has `translate configuration` **or** `translate any webform` **or**
     (`translate own webform` **and** is the webform owner);
   - the mapper `hasSchema()` and `hasTranslatable()`;
   - the source language (if any) is not locked.
   Result is cached per permissions.

## Translate operation link

`hook_entity_operation()` adds a **Translate** operation (weight 50, linking to the
`config-translation-overview` route) to a webform in admin listings, but only for users who
have `translate any webform`, or `translate own webform` on a webform they own.

## Notes

- The module has **no** settings form or config object of its own — behaviour is entirely
  permission-driven.
- Requires the `webform` and core `config_translation` modules; the site must have
  translatable webform config (i.e. multilingual / config translation configured) for the
  Translate links to be actionable.
