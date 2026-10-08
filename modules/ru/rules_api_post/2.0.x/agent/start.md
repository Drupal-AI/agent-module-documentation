<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules API Post (rules_api_post) — agent index

**Rules action plugin that POSTs entity data (HAL+JSON) to a configured REST API.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Depends:** rules
- **Package:** Rules

**Surface:** one `@RulesAction` `RulesAPI_POST` (`src/Plugin/RulesAction/RulesAPI_POST.php`); demo `api_post` content type + fields in config/install. No routes/permissions.

**Security:** the action runs only when its rule executes — configured by admins (`administer rules`); NO public route, so anon/low-priv cannot trigger arbitrary action execution. Outbound POST uses Guzzle defaults (TLS verify ON); basic-auth creds + token come from rule config. Uses deprecated `drupal_set_message()`/`\Drupal::httpClient()` but no security defect found.
