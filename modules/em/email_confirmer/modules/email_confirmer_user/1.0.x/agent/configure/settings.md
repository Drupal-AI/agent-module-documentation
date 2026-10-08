# Email confirmer user — settings

Route `email_confirmer_user.settings` → `/admin/config/system/email-confirmer/user`
(permission `administer site configuration`). Config `email_confirmer_user.settings`
(defaults in `config/install/email_confirmer_user.settings.yml`; form
`src/Form/EmailConfirmerUserSettingsForm.php`).

```yaml
user_email_change:
  enabled: true            # require confirmation when a user changes their email
  notify_current: true     # email the OLD address that a change was requested
  consider_existent: true  # accept immediately if the new address was already confirmed
  limit_user_realm: false  # when checking "already confirmed", restrict to realm 'email_confirmer_user'
user_login:
  sync_core_confirmation: true      # on a new account's first login, record a confirmed confirmation
  sync_core_onetimeloginlinks: true # also record one when logging in via a one-time (reset) link
```

## Cancel route
`entity.user.cancel_email_change` → `/user/{user}/email-change/cancel` (form
`UserEmailChangeCancelForm`). Access check `_email_confirmer_user_email_pending_change`
(`src/Access/UserEmailPendingChangeAccess.php`): forbidden unless the target user is authenticated,
`user_email_change.enabled` is true, the user actually has a pending change in `user.data`, AND the
current user has `update` access to that account. Cache per user.

## Flow reference (`email_confirmer_user.module`)
- `hook_user_presave` — starts the confirmation, reverts to old email, stashes new email in
  `user.data`. Skipped for holders of `email confirmer user bypass email change`.
- `hook_email_confirmer('confirm')` — sets the user email to the pending address (rejects if the
  address is already taken; sets a `drupal_static` flag to avoid re-triggering).
- `hook_form_user_form_alter` — adds the pending-change notice with resend/cancel links.
- `hook_user_login` — records confirmed confirmations per the `user_login` settings.
