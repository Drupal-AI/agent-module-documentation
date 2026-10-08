Webform Translation Permissions adds two granular permissions — "translate any webform" and "translate own webform" — so users can translate a webform's configuration without being granted the site-wide "translate configuration" permission.

---

The module solves a specific access problem: Drupal's config translation only offers the broad `translate configuration` permission, which lets a user translate every config entity on the site. This module narrows that for webforms. It defines two permissions, `translate any webform` and `translate own webform` (the "own" check compares the webform's owner uid to the current user). It swaps in its own config-translation mapper for webforms via `hook_config_translation_info_alter()` (`WebformMapper`, extending `ConfigEntityMapper`), which replaces the translation routes' access requirement with a custom `_webform_translation_form_access` check. That check (`WebformTranslationFormAccess`, a service tagged `access_check`, extending core's `ConfigTranslationFormAccess`) grants access when the user has `translate configuration`, or `translate any webform`, or `translate own webform` on a webform they own — combined with the usual mapper checks (has schema, has translatable, source language not locked). It also adds a **Translate** operation link to webforms in admin listings (`hook_entity_operation()`) for users holding the new permissions. There is no configuration UI; you just grant the permissions at `/admin/people/permissions`. It requires `webform` and core `config_translation`.

---

- Let a translator role translate any webform without giving them site-wide config translation.
- Allow webform authors to translate only the webforms they created ("translate own webform").
- Grant a language team access to webform translations while keeping other config locked down.
- Add a **Translate** operation link to webforms for editors with the granular permission.
- Separate "manage webforms" from "translate webforms" as distinct role capabilities.
- Delegate French/German webform translation to regional editors safely.
- Keep the powerful `translate configuration` permission reserved for administrators.
- Enable per-owner webform translation on a multi-author site.
- Comply with least-privilege policies by scoping translation rights to webforms.
- Give a contractor temporary rights to translate a specific set of webforms via a role.
- Support a multilingual contact/registration form workflow without over-permissioning.
- Let content teams translate webform labels, messages, and email text in their language.
- Combine with Webform's access controls so authors manage and translate their own forms.
- Provide translation access that respects locked languages (source language checks).
- Audit who can translate webforms through two clearly named permissions.
- Roll out webform translation capability to a role via exported user.role config.
- Avoid custom access code by reusing the module's `_webform_translation_form_access` check.
- Show translation entry points only to users who actually hold the permission.
- Support editorial workflows where authors draft and translate their own webforms.
- Restrict translation of shared/site webforms to a dedicated "any webform" role.
