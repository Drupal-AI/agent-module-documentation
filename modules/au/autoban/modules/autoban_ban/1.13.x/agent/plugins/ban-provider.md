<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ban` provider (core Ban)

Class `Drupal\autoban_ban\BanProvider` implements `Drupal\autoban\AutobanProviderInterface`
and is registered as a tagged service so Autoban discovers it:

```yaml
# autoban_ban.services.yml
services:
  autoban_ban.ban_provider:
    class: Drupal\autoban_ban\BanProvider
    tags:
      - { name: ban_providers }
```

The service id ends in `.ban_provider`, which is how `AutobanController::getBanProvidersList()`
finds it. Interface return values:

| Method | Returns |
|---|---|
| `getId()` | `'ban'` — the string stored in a rule's `provider` field |
| `getName()` | `'Core Ban'` — label in the provider select |
| `getBanType()` | `'single'` — bans one IP at a time (no CIDR ranges) |
| `hasMetadata()` | `FALSE` |
| `getBanIpManager($connection)` | `new \Drupal\ban\BanIpManager($connection)` — core Ban's IP manager |

## Using it

Set a rule's provider to `ban`:
```php
\Drupal::entityTypeManager()->getStorage('autoban')->create([
  'id' => 'my_rule', 'type' => 'page not found', 'message' => 'phpmyadmin',
  'threshold' => 5, 'window' => '1 hour', 'provider' => 'ban',
  'user_type' => 1, 'rule_type' => 1,
])->save();
```
When the rule fires (cron / `drush autoban:ban` / UI), matched IPs are added to core Ban's
blocked-IP list — visible and manageable at `/admin/config/people/ban`.

Confirm the provider is live:
```bash
drush php:eval '$l=\Drupal::service("autoban")->getBanProvidersList(); print $l["ban"]["name"];'
# => Core Ban
```
`ban` only appears while this submodule is enabled (it requires core `ban`).
