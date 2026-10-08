<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduler for ECK bridges the Scheduler and Entity Construction Kit (ECK) modules so ECK entities support timed publishing and unpublishing.

---

The module ships a Scheduler plugin (`@SchedulerPlugin` id `scheduler_eck`, dependency `eck`) with a derivative (`SchedulerEckDeriver`) that produces a plugin instance per ECK entity type, and an event class (`SchedulerEckEvents`). By extending Scheduler's `SchedulerPluginBase`, it lets ECK entity types opt into Scheduler's publish-on/unpublish-on date fields and cron-driven processing, the same way Scheduler natively supports nodes and media. There is no routing, permissions, service or config of its own — it is pure glue that registers ECK entity types with Scheduler.

Because it defines only a plugin and derivative, the module has no HTTP surface, no anonymous endpoints and no mutating routes; scheduling actions run through Scheduler's cron and existing entity access. Setup is enabling the module alongside Scheduler and ECK, then turning on Scheduler for the desired ECK entity types/bundles in their Scheduler settings. It requires Scheduler 2.0.0-rc4+.

---

- Enable scheduled publishing for ECK entity types
- Schedule an ECK entity to publish at a future time
- Schedule an ECK entity to unpublish at a set time
- Process ECK schedule dates via Scheduler cron
- Register each ECK entity type as a Scheduler plugin
- Reuse Scheduler's publish-on/unpublish-on fields for ECK
- Add timed content workflows to custom ECK entities
- Integrate ECK bundles with Scheduler settings
- Extend Scheduler beyond nodes and media
- Drive ECK publishing from Scheduler's event system
- Apply Scheduler rules to ECK content
- Avoid custom code for ECK scheduling
- Support multiple ECK entity types via the deriver
- Coordinate embargoed ECK content release
- Automatically unpublish expired ECK entities
- Keep ECK scheduling consistent with node scheduling
- Configure Scheduler per ECK bundle
- Rely on Scheduler cron for timed state changes
- Pair ECK with editorial publishing windows
- Provide scheduled content for ECK-based structures
