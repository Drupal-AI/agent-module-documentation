<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Distro Filter — agent index

**Deprecated** (`lifecycle: deprecated`) submodule of **config_distro**. A backwards-compat
bridge: one event subscriber that runs Config Filter plugins against the distro storage during
`config_distro.transform`. No config, no schema, no UI, no permissions, no Drush. Requires
`config_distro` + `config_filter`.

- **How the bridge works (the subscriber, `ConfigFilterStorageFactory`, the transform) and the
  deprecation** → [api/bridge.md](api/bridge.md)

Parent: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md).

Key fact: `ConfigDistroFilterEventSubscriber::onDistroTransform()` (service
`config_distro_filter.event_subscriber`) subscribes to `ConfigDistroEvents::TRANSFORM` and
applies `config_filter` plugins whose `storages` include `config_distro.storage.distro` (e.g.
`config_distro_ignore`). New code should implement a `config_distro.transform` subscriber
directly instead.
