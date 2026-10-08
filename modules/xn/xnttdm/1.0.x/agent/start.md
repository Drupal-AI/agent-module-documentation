<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Model Aggregator (xnttdm) — agent index

**Adds a "model" data aggregator to External Entities so multiple content-entity storage groups can serve as data inputs/outputs for transfer or conversion.**

- **Version:** 1.0.x (dev checkout of the `1.0.x` / `1.0.x-dev` branch; no `version:` in info.yml)
- **Core requirement:** ^10 || ^11
- **Package:** External Entities
- **Dependency:** `external_entities:external_entities` (>= 3.0.x-dev)
- **Project note:** composer/homepage reference the `xnttdb` project URL, but the module machine name is `xnttdm`.

**Provides:**
- DataAggregator plugin `model` (`ModelDataAggregator`, extends `GroupAggregator`).
- StorageClient plugin `content` (`ContentEntityClient`).
- PropertyMapper `ModelPropertyMapper`.
- Service `Drupal\xnttdm\Hook\XnttdmHooks` (autowired) implementing `hook_entity_presave`.
- Config schema `config/schema/external_entities.data_aggregator.schema.yml`.

**Routes / permissions:** none. **HTTP endpoints:** none. Configuration is done entirely through the External Entities type form.

**Security:** No routes, permissions, HTTP endpoints, external network calls or credential handling. Purely config-driven behaviour attached to the External Entities type form; only runtime hook is `entity_presave` (lock cleanup). No security findings.
