<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoban Advanced Ban Provider (autoban_advban) — agent index

Autoban submodule that registers **two ban providers** wrapping the contrib **Advanced Ban
(advban)** module. Depends on `advban` + `autoban`. No config, settings, permissions, Drush, or
config schema.

- **The `advban` and `advban_range` providers (classes, services, ids/names/types)** →
  [plugins/ban-providers.md](plugins/ban-providers.md)

Key facts:
- Two services tagged `ban_providers`, both implement `Drupal\autoban\AutobanProviderInterface`,
  both take `@advban.ip_manager`:
  - `autoban_advban.ban_provider` = `AdvbanProvider` → id `advban`, name "Advanced Ban", type `single`.
  - `autoban_advban_range.ban_provider` = `AdvbanRangeProvider` → id `advban_range`,
    name "Advanced Ban (range)", type `range` (CIDR/IP ranges).
- Set an Autoban rule's `provider` field to `advban` or `advban_range` to ban via Advanced Ban.
- Requires the contrib `advban` module; if it is not installed, this submodule cannot be enabled
  and its providers do not appear in `\Drupal::service('autoban')->getBanProvidersList()`.

Parent provider-system overview: [../../../../1.13.x/agent/plugins/ban-providers.md](../../../../1.13.x/agent/plugins/ban-providers.md).
