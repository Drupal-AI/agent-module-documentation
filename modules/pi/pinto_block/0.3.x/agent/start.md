<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pinto Block (pinto_block) — agent index

**Associates Pinto theme objects with block_content bundle classes so Layout Builder blocks render through the Pinto object/component system.**

- **Version:** 0.3.x
- **Core:** ^10.2 || ^11 (PHP 8.2)
- **Dependencies:** drupal:layout_builder (Pinto object system + optionally bca/hux at code level)

## Surface
- No routes, permissions, or config entities — developer API only.
- `Attribute\PintoBlock(objectClassName:)` — links a `block_content` bundle class to a Pinto object.
- `BlockBundleObjectInterface` / `BlockBundleInterface` — implemented by your theme object / bundle class.
- `LayoutBuilderEventSubscriber` (autowired, `event_subscriber`) — routes matching LB block builds to the Pinto object.
- `ObjectContext` — carries block/entity/view-mode context into the object.

**Security:** no request-facing surface; no routes/permissions/mutating endpoints. Rendering access is governed entirely by Layout Builder and block_content core. No security findings.

See [api/objects.md](api/objects.md)
