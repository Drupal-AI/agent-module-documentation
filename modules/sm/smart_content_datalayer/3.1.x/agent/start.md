<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content Data Layer - agent index

dataLayer (GTM) integration for Smart Content. Version **3.1.1** (3.1.x), core `^9.1 || ^10`. Depends on `smart_content`.

- Service `smart_contenet_datalayer.decision_settings_subscriber` (`DecisionSettingsSubscriber`, event_subscriber) injects dataLayer condition config into the Smart Content decision JS settings (constructed with the decision_storage plugin manager).
- Provides dataLayer-backed Smart Content condition plugins; segmentation values are read client-side from `window.dataLayer`.
- No routes or permissions of its own.

Security: client-side condition data only; adds no server endpoints. No verified finding.
