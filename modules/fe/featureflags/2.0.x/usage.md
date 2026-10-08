<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feature flags provides a `featureflag` configuration entity plus the plumbing that makes flags usable in Drupal: a manager service to read/write a flag's on/off state, a cache context so flagged output caches correctly, and a condition plugin so flags can gate blocks.

---

A flag is a named switch you can flip without a code deployment, which is how teams ship unfinished work behind a toggle, run a staged rollout, or quickly kill a misbehaving feature. In Drupal that needs more than a boolean in settings: the flag has to be defined somewhere reviewable, code has to query it, the render cache has to vary on it, and site builders should be able to use it without writing PHP. This module supplies all four. The flag is *defined* as a config entity (machine name, human name, description), but its *active/inactive state* is stored separately in Drupal's State/key-value store (collection `featureflags`) via the `FlagManager` service — the config entity holds the definition, not the state. Code checks a flag with `FeatureFlag::isActive('id')` or the `featureflags.manager` service; `FeatureFlagContext` provides the `featureflags:{id}` cache context; and `Plugin/Condition/FeatureFlagStatus` exposes flags to block visibility and anywhere Drupal collects conditions, with AND/OR combination of several flags.

Flags are administered at `/admin/structure/feature-flags` (a config-entity collection under *Structure*), with add/edit/delete forms provided by core's entity route provider. Everything there is gated by the single permission `administer featureflag entities`. Because the flag *definition* is a config entity it exports, deploys and diffs like any other config; the *state* is not exported, so each environment carries its own on/off value — which is exactly what you want when production and staging should differ.

The cache context is the piece most often forgotten. If flagged output is rendered without declaring the `featureflags:{id}` context, the first request's variant is cached and served to everyone regardless of the flag — the bug looks like "flipping the flag does nothing".

---

- Ship an unfinished feature behind a switch and enable it when ready.
- Turn a feature on in one environment only (state is not exported, so each site sets its own).
- Kill a misbehaving feature immediately without a deployment.
- Gate a block's visibility on one or more feature flags.
- Combine several flags with AND (all active) or OR (any active) in the condition plugin.
- Check a flag from custom PHP with `FeatureFlag::isActive('my_flag')`.
- Read/write flag state programmatically through the `featureflags.manager` service.
- Vary render caching correctly on a flag with the `featureflags:{id}` cache context.
- Stage a rollout by flipping flags in sequence.
- Keep the flag catalog in exported configuration rather than scattered `settings.php` booleans.
- Review a new flag's definition in a config diff before deploy.
- Give a release manager the `administer featureflag entities` permission to control switches.
- List which flags a site currently defines and whether each is active, from the admin collection.
- Retire a flag by deleting the entity (its stored state is cleaned up on delete).
- Diagnose a flag that appears to have no effect (usually a missing cache context).
- Replace ad-hoc environment `if` checks with a single reviewable flag definition.
- Toggle a flag from the edit form's *Active* checkbox without touching code.
- Expose a flag to a custom block or page as a visibility condition.
- Coordinate a front-end and back-end change behind one shared flag.
- Set an initial flag state at deploy time via the entity form, then flip it later in production.
