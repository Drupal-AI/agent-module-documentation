<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `advban` and `advban_range` providers (Advanced Ban)

Two services registered in `autoban_advban.services.yml`, both tagged `ban_providers`, both
constructed with `@advban.ip_manager`, both implementing
`Drupal\autoban\AutobanProviderInterface`:

```yaml
services:
  autoban_advban.ban_provider:
    class: Drupal\autoban_advban\AdvbanProvider
    arguments: ['@advban.ip_manager']
    tags: [{ name: ban_providers }]
  autoban_advban_range.ban_provider:
    class: Drupal\autoban_advban\AdvbanRangeProvider
    arguments: ['@advban.ip_manager']
    tags: [{ name: ban_providers }]
```

| Class | Service id | `getId()` | `getName()` | `getBanType()` | `hasMetadata()` |
|---|---|---|---|---|---|
| `AdvbanProvider` | `autoban_advban.ban_provider` | `advban` | Advanced Ban | `single` | `TRUE` |
| `AdvbanRangeProvider` | `autoban_advban_range.ban_provider` | `advban_range` | Advanced Ban (range) | `range` | `TRUE` |

Both service ids end in `.ban_provider`, so `AutobanController::getBanProvidersList()` discovers
them. `getBanIpManager()` returns Advanced Ban's IP manager (injected `advban.ip_manager`).

## Using them

Set a rule's `provider` to `advban` (single) or `advban_range` (CIDR/range):
```php
\Drupal::entityTypeManager()->getStorage('autoban')->create([
  'id' => 'range_rule', 'type' => 'access denied', 'message' => 'node',
  'threshold' => 3, 'window' => '1 hour', 'provider' => 'advban_range',
  'user_type' => 1, 'rule_type' => 1,
])->save();
```
When the rule fires, the range provider bans a whole CIDR block through Advanced Ban instead of
a single IP.

## Requirement

These providers require the contrib **advban** module (`advban.ip_manager` service). Without
`advban` installed, `autoban_advban` cannot be enabled and neither `advban` nor `advban_range`
appears in the provider list. The rule config itself still validates as a string, so a
`provider: advban_range` value can be stored in config even before the provider is active — but
no ban executes until `autoban_advban` (and `advban`) are enabled.
