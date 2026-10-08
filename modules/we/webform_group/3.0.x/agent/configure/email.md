# Email integration (group-role recipient tokens)

Webform Group lets a Webform **email handler** send to group members by group role, via tokens
resolved from the current webform node's group.

## Tokens (`webform_group.tokens.inc`)
Token type `webform_group` — **only available in a Webform email handler's To/CC/BCC**:
- `[webform_group:role:GROUP_ROLE_ID]` — comma-separated emails of members holding that group
  role in the current webform node's group. Both fully-qualified ids (`group_type-role`) and bare
  role names are offered.
- `[webform_group:owner:mail]` and chained `[webform_group:owner:*]` user tokens — the group
  owner (only if enabled).

Resolution (`webform_group_tokens()`): loads the submission's group relationship, then the group,
then the members for the role, and joins their emails. A role is only resolvable if it is on the
allowlist (below).

## Site-wide allowlist (`webform_group.settings`)
Which group roles/owner may be used as email recipients is controlled globally on the **Webform
admin handlers settings** form (`webform_admin_config_handlers_form`), altered by
`webform_group_form_webform_admin_config_handlers_form_alter()`:
- `mail.group_roles` (sequence) — allowlisted group roles (a `webform_group_roles` selector,
  excluding anonymous/outsider).
- `mail.group_owner` (bool) — allow emailing the group owner.

Default config (`config/install/webform_group.settings.yml`):
```yaml
mail:
  group_owner: false
  group_roles: {  }
```
Saving the form also resets the token cache. `WebformGroupManager::isGroupRoleTokenEnabled()` /
`isGroupOwnerTokenEnable()` read this allowlist; the email-handler form
(`webform_group_form_webform_handler_form_alter`) only exposes allowlisted roles as recipient
options, and shows a hint (to admins) linking to the settings form when none are enabled.

Set via drush:
```
drush config:set webform_group.settings mail.group_owner true -y
```
