# Redirect After Logout — agent index

Redirects a user to a configured URL after logout, with an optional one-time message. One
admin form, one permission, no Drush, no plugins. Depends on core `filter`; soft deps on
`token` and `masquerade`.

- **Settings keys, destination formats (internal/external/`<front>`/tokens), the message,
  the permission, and the logout→redirect flow** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `redirect_after_logout.settings`: `destination`, `message`, `message_type`.
- Settings form: route `redirect_after_logout.settings` at
  `admin/config/system/redirect_after_logout`, permission `administer site configuration`.
- Permission `redirect user after logout` decides which accounts are redirected.
- Redirect fires from `hook_user_logout()` + a response `EventSubscriber`
  (`src/EventSubscriber/RedirectAfterLogoutSubscriber.php`); skipped during a Masquerade session.
