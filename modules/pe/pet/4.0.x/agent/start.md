# Previewable Email Templates (PET) — agent index

`pet` content entity = a token-enabled email template you can preview then send interactively,
from code, or from (legacy) Rules. Depends on `options` + `token`. Config route `pet.settings`.

- **The `pet` entity, its fields, template management, the settings form, MimeMail** →
  [configure/templates.md](configure/templates.md)
- **Sending: `pet_send_mail()` / `pet_send_one_mail()`, the `/pet/{pet}` preview flow, tokens** →
  [api/sending.md](api/sending.md)
- **Permissions and what each gates (note the send-permission mismatch)** →
  [permissions/permissions.md](permissions/permissions.md)
- **`hook_pet_substitutions_alter()` and `hook_default_pet()`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Manage templates at `/admin/structure/pets`; send interactively at `/pet/{pet}`
  (permission `view PET entity`); settings at `/admin/config/system/pet/settings`.
- Programmatic API: `pet_send_mail($pet_id, $recipients, $options)` and
  `pet_send_one_mail($pet, $params)`; message assembled by `pet_mail()` (`hook_mail`).
- `pet.rules.inc` is D7-era Rules API (`hook_rules_action_info`, `url()`) — legacy, not
  functional with current Rules. No Drush commands ship despite a `composer.json` `extra.drush`
  stanza (no `drush.services.yml` present).
