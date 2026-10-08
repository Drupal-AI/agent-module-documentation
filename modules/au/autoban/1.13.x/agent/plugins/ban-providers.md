<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ban providers (`ban_providers` tagged services)

Autoban does not define a plugin manager. Instead a **ban provider** is a **service** whose
service id ends in `.ban_provider`, tagged `{ name: ban_providers }`, and implementing
`Drupal\autoban\AutobanProviderInterface`. `AutobanController::getBanProvidersList()` discovers
them by scanning the cached container for services whose last dot-segment is `ban_provider`,
then keys them by `getId()`. A rule's `provider` field stores that **id** string.

## The interface (`AutobanProviderInterface`)

```php
public function getId();                 // stored in the rule's `provider` field, e.g. 'ban'
public function getName();               // human label in the provider select, e.g. 'Core Ban'
public function getBanType();            // 'single' | 'range'
public function hasMetadata();           // bool
public function getBanIpManager(\Drupal\Core\Database\Connection $connection); // returns a BanIpManager-like object
```

## Providers shipped by the submodules

| Provider id | Name | Ban type | Submodule / service |
|---|---|---|---|
| `ban` | Core Ban | single | `autoban_ban` → `autoban_ban.ban_provider` (`Drupal\autoban_ban\BanProvider`), wraps core `ban` `BanIpManager` |
| `advban` | Advanced Ban | single | `autoban_advban` → `autoban_advban.ban_provider` (`AdvbanProvider`) |
| `advban_range` | Advanced Ban (range) | range | `autoban_advban` → `autoban_advban_range.ban_provider` (`AdvbanRangeProvider`) — CIDR ranges |

Only providers from **enabled** submodules appear. With just core Ban enabled, `ban` is the
only choice; a rule referencing a provider whose submodule is disabled will have nothing to
execute the ban.

## Writing your own provider

1. Create a service class implementing `AutobanProviderInterface`.
2. Register it in your module's `*.services.yml` with a service id ending `.ban_provider` and
   the `ban_providers` tag:
   ```yaml
   services:
     mymodule.ban_provider:
       class: Drupal\mymodule\MyBanProvider
       tags:
         - { name: ban_providers }
   ```
3. Return a unique `getId()`; that id becomes selectable as a rule's `provider`.

Inspect the live list: `\Drupal::service('autoban')->getBanProvidersList()` returns
`['<id>' => ['name' => ..., 'service' => <provider>]]`.
