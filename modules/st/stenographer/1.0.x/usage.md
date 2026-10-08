<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stenographer is an extensible logging/auditing engine: you declare "recorders" in YAML that listen for triggers, capture data, and write the resulting events to a storage backend.
---
Recorders are defined in `<module>.stenographer.yml` files. Each recorder wires a trigger (hook, exception, entity, or form events), a capture strategy and data adapters that shape the payload, and a storage plugin that persists it. The module resolves these through pluggable managers (`plugin.manager.stenographer.condition`, `.data_adapter`, `.storage`) and a `RecorderEventSubscriber`, with a `TriggerCollection` service_collector aggregating the built-in trigger handlers (HookTriggers, ExceptionTriggers, EntityTriggers, FormTriggers). It ships an `example.stenographer.yml` demonstrating security/audit recorders (e.g. detecting suspicious activity or breach notifications).

There is no admin UI — configuration is code/YAML plus optional settings overrides. For local development you can redirect all recorders to one storage target (e.g. the `watchdog`) via `$settings['stenographer.dev']`. New triggers, capture strategies, data adapters and storage backends are added as plugins/strategy implementations. Setup: require the module (depends on Toolshed), copy/adapt the example YAML into your module, define the recorders you need, and clear caches.
---
- Capture audit events for security-relevant activity.
- Define recorders in a `<module>.stenographer.yml` file.
- Log entity create/update/delete events.
- Record form submissions as audit entries.
- Trap and record exceptions as events.
- Fire a recorder from an arbitrary Drupal hook.
- Route captured events to a chosen storage backend.
- Send all dev-environment logs to watchdog via `$settings['stenographer.dev']`.
- Shape event payloads with data adapters.
- Gate recorders with condition plugins.
- Detect suspicious user activity for breach notifications.
- Add a custom storage plugin for an external log sink.
- Add a custom trigger type as a tagged service.
- Add a custom capture strategy.
- Reuse the shipped `example.stenographer.yml` as a starting template.
- Build a compliance audit trail without a UI.
- Aggregate multiple event sources into one recorder.
- Override storage for all recorders in one place during development.
- Capture data via data adapters without editing core code.
- Report on captured events from the chosen storage.
