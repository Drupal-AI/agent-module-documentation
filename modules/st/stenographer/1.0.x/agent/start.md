<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stenographer (stenographer) — agent index
**Flexible logging/auditing: YAML-defined recorders bind triggers → capture strategies → data adapters → storage plugins.**

- **Version:** 1.0.x (1.0.0-beta3)
- **Core:** ^10.2 || ^11
- **Depends on:** toolshed
- **Config:** `<module>.stenographer.yml` files (see `example.stenographer.yml`); dev override `$settings['stenographer.dev']`.
- **Managers:** `RecorderManager`, `CaptureStrategyManager`, plugin managers for condition / data_adapter / storage.
- **Triggers (tagged `stenographer_trigger`):** hook, exception, entity, form.
- **Event subscriber:** `RecorderEventSubscriber`.

**Security:** no routes, permissions or admin forms — pure code/YAML configuration and plugin extension. Itself an audit/logging tool; ensure captured payloads don't store sensitive data in an inappropriate backend.

See [extend/recorders.md](extend/recorders.md)
