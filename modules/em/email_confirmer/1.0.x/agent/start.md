# Email confirmer — agent index

Developer suite for confirming email addresses: the `email_confirmer` service + the
`email_confirmer_confirmation` content entity. Sends an HMAC-signed link, records the result, and
remembers confirmed addresses. Base module has no end-user UI (only settings). Submodule
`email_confirmer_user` applies it to user email changes.

- **Call the service, work with the confirmation entity, the routes & hash flow** →
  [api/service.md](api/service.md)
- **Settings form keys, defaults, config schema, cron cleanup** → [configure/settings.md](configure/settings.md)
- **`hook_email_confirmer()` — react to confirm/cancel** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Submodule:
- `email_confirmer_user` → [../../modules/email_confirmer_user/1.0.x/agent/start.md](../../modules/email_confirmer_user/1.0.x/agent/start.md)

Key facts:
- Service id `email_confirmer` = `EmailConfirmerManager`; entity type `email_confirmer_confirmation`.
- Response route `/email-confirmer/reply/{uuid}/{hash}` (hash `^[a-zA-Z0-9\-_]{43}$`); resend route
  `/email-confirmer/resend/{id}` needs `access email confirmation` + CSRF.
- Hash = `Crypt::hmacBase64(email . created . ip, private_key)` (see `src/Entity/EmailConfirmation.php`).
