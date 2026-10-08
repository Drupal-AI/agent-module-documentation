<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rabbit Hole href (rabbit_hole_href) — agent index

**Alters entity link/URI generation so links produced for Rabbit-Hole-managed entities point straight at the redirect target rather than the entity's canonical page.**

- **Version:** 2.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Depends on:** rabbit_hole:rabbit_hole (^1.0)
- **Hooks:** `rabbit_hole_href_entity_type_alter()` sets a custom `uri_callback` and drops the `canonical` template; `rabbit_hole_href_entity_bundle_info_alter()` applies it per bundle. Currently scoped to `taxonomy_term`.
- **Service:** `rabbit_hole_href.canonical_link_modifier` (`CanonicalLinkModifier`) computes the target URL via the `plugin.manager.rabbit_hole_behavior_plugin`.
- **Routes/permissions:** none of its own.

**Security:** No routes, endpoints, or permissions; it only changes link/URI generation for already-public entity links. No user input is processed and no access decision is made here — the destination URL still enforces its own access. No security-sensitive surface.