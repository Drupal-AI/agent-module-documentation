# Email confirmer user — agent index

Applies `email_confirmer` to user accounts: an email change must be confirmed via signed link before
it takes effect; verified addresses are synced on first / one-time login. All logic is procedural in
`email_confirmer_user.module`. Depends on `email_confirmer`.

- **Settings keys, defaults, and the cancel route** → [configure/settings.md](configure/settings.md)
- **The bypass permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Pending new address stored in `user.data`: module `email_confirmer_user`, key
  `email_change_new_address`; confirmation uses realm `email_confirmer_user`, `private`.
- Route `entity.user.cancel_email_change` = `/user/{user}/email-change/cancel`, access check
  `_email_confirmer_user_email_pending_change` (`src/Access/UserEmailPendingChangeAccess.php`).
- Applies the change in `hook_email_confirmer('confirm', …)`; guards duplicate emails and loops.
