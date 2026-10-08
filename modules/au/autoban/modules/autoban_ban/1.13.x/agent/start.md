<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoban Core Ban Provider (autoban_ban) — agent index

Autoban submodule that registers a **ban provider** wrapping Drupal core's **Ban** module.
Depends on `ban` + `autoban`. No config, settings, permissions, Drush, or config schema.

- **The `ban` provider (class, service, id/name/type, how a rule uses it)** →
  [plugins/ban-provider.md](plugins/ban-provider.md)

Key facts:
- Service `autoban_ban.ban_provider` = `Drupal\autoban_ban\BanProvider`, tagged
  `ban_providers`, implements `Drupal\autoban\AutobanProviderInterface`.
- `getId()='ban'`, `getName()='Core Ban'`, `getBanType()='single'`, `hasMetadata()=FALSE`.
- Set an Autoban rule's `provider` field to `ban` to ban single IPs via core Ban's
  `BanIpManager` (the list at `/admin/config/people/ban`).
- Provider discovery: `\Drupal::service('autoban')->getBanProvidersList()` includes
  `ban => ['name' => 'Core Ban', ...]` when this submodule is enabled.

See the parent for the provider system overview: [../../../../1.13.x/agent/plugins/ban-providers.md](../../../../1.13.x/agent/plugins/ban-providers.md).
