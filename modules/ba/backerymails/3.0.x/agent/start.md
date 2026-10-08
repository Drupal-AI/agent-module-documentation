<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backery Mails - agent index

**Backery Mails** archives every outgoing Drupal email as an entity and provides a Views admin UI. Version **3.0.1** (`3.0.x`). Core `^9.5 || ^10`.

## Key files
- `src/Entity/BackerymailsEntity.php` - the stored-mail content entity.
- `src/BackerymailsEntityAccessControlHandler.php` - per-entity view access.
- `src/Form/SettingsForm.php`, `src/Form/ClearForm.php` - settings and purge.
- `inc/hooks.php` - mail-capture hooks.

## Routes / permissions
- `/admin/config/backerymails/*` require `administer backerymails`.
- Mail detail uses `_entity_access: backerymails_entity.view`.

Depends on `views` + `mailsystem`. Observes mail, does not alter delivery.