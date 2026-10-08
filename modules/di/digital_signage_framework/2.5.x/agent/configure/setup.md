<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Digital Signage Framework

## Order of operations
1. Enable the framework plus a concrete platform module (dependency `signageos` or another module that provides a `digital_signage_platform` plugin). The framework alone models entities but has no vendor transport.
2. Global settings: `/admin/config/services/digital_signage_framework` (perm `administer digital signage framework`). Sub-tabs: **Fonts** (`/fonts`, add/edit custom web fonts) and **Schedules** (`/admin/config/services/digital_signage_framework/schedules`, gated by `administer site configuration`).
3. Content settings entity: `/admin/structure/digital-signage-content-setting` (perm `administer digital signage content setting`) — declares which entity bundles are publishable to signage.
4. Device types: `/admin/structure` → Digital signage device types (perm `administer digital signage device types`) — hardware/orientation/resolution profiles.
5. Devices: `/admin/content` → Devices (perm `access digital signage device overview`) — one entity per screen, bound to a platform plugin.

## Operating the estate
- **Sync all:** `/admin/content/digital-signage-device/sync-all` (`access digital signage device overview`).
- **Push schedule:** `/admin/content/digital-signage-device/schedule-push` (`push digital signage schedule`).
- **Push config:** `/admin/content/digital-signage-device/schedule-config` (`push digital signage config`).
- **Emergency mode:** `/admin/content/digital-signage-device/emergency-mode` (`change digital signage emergency mode`) — forces the emergency playlist across screens via the `Emergency` service.

Recommended companion modules (from info.yml `recommends`): `analog_digital_clock`, `expose_actions`.
