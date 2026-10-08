<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Distro Filter is a **deprecated** backwards-compatibility bridge that lets legacy Config Filter plugins participate in Config Distro's transform pipeline, running them against the distribution storage when it is built.

---

The submodule registers one event subscriber, `ConfigDistroFilterEventSubscriber` (service `config_distro_filter.event_subscriber`), on Config Distro's `config_distro.transform` event. When the distro storage is transformed, its `onDistroTransform()` takes the event's storage, obtains a filtered storage from `config_filter`'s `ConfigFilterStorageFactory::getFilteredStorage($storage, ['config_distro.storage.distro'])` (i.e. every Config Filter plugin whose `storages` include `config_distro.storage.distro`, such as `config_distro_ignore`), simulates an import by copying the filtered result into a temporary `MemoryStorage`, and writes that back onto the event storage. In effect it makes the Config Filter plugin API work with Config Distro's newer Transform API. It is marked `lifecycle: deprecated` (see the deprecation issue) and kept only for backwards compatibility; new integrations should implement a `config_distro.transform` subscriber directly. It depends on both `config_distro` and `config_filter`, has no configuration, no schema, no UI, no permissions and no Drush of its own. Config Distro's `config_distro_update_8101()` update hook installs it on existing sites; `config_distro_ignore` depends on it.

---

- Let legacy Config Filter plugins run against the Config Distro distribution storage.
- Bridge the older Config Filter plugin API to Config Distro's Transform API for backwards compatibility.
- Apply `config_distro_ignore`'s ignore filter during the distro transform (it depends on this bridge).
- Run any Config Filter plugin bound to `config_distro.storage.distro` when the distro storage is built.
- Keep a pre-Transform-API Config Distro integration working after upgrading.
- Simulate a filtered config import over the distribution storage via the transform event.
- Provide the glue that makes `config_distro_ignore` effective during distribution imports.
- Subscribe to `config_distro.transform` without writing a custom subscriber (legacy path).
- Support sites migrating from Config Filter-based Config Distro workflows.
- Maintain compatibility for distributions that still ship Config Filter plugins.
- Convert filtered-storage output back into the mutable transform storage.
- Serve as a reference for how to subscribe to the `config_distro.transform` event.
- Enable during an upgrade window until integrations are ported to native transform subscribers.
- Avoid breaking existing Config Filter-driven distro setups when adopting Config Distro 2.x.
- Uninstall once your Config Distro integrations no longer rely on Config Filter plugins.
