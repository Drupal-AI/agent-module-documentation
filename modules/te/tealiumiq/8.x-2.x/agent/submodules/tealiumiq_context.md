<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: tealiumiq_context

**Tealium iQ Context** — sets data-layer values conditionally via the contrib **Context** module
("if this condition, then these Tealium tags"). Ships in `modules/tealiumiq_context/`.

- **Dependencies:** `tealiumiq:tealiumiq`, `context:context`, `token:token` (composer: `drupal/context ^1.0`).
- **Context reaction plugin** `TealiumiqContext` (`@ContextReaction id = "tealiumiq_context"`,
  `src/Plugin/ContextReaction/TealiumiqContext.php`): its config form reuses `Tealiumiq::form()` so an
  editor fills in the same tag fields per context; `submitConfigurationForm()` stores `{tag_id: value}`;
  `execute()` returns that configuration.
- **Event subscriber** `AlterUdoProperties` (`src/EventSubscriber/AlterUdoProperties.php`, injected with
  `@context.manager`): subscribes to the main module's `AlterUdoPropertiesEvent`. On each active
  `tealiumiq_context` reaction it calls `getActiveReactions()->execute()`, drops the `id` key, and
  `array_merge`es the reaction's tags onto the current data-layer properties (additive, does not replace).

So values flow: **defaults → context reactions (this submodule, via the alter event) → per-entity field
tags → final alter event.** Because it hooks the same `AlterUdoPropertiesEvent`, context values are
subject to the same token replacement and plain-text reduction as everything else.

Enable with `drush en tealiumiq_context -y` (requires the Context module). Configure per Context
definition at `/admin/structure/context`, adding the "Tealium iQ Tags" reaction.
