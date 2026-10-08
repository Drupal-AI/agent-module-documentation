<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure signageOS

## Connection settings
Route `signageos.settings` → `/admin/config/services/digital_signage_framework/signageos`
(permission `administer site configuration`). Enter the signageOS API connection details
(`Form/Settings`). Stored in module config.

## Power actions
Route `signageos.poweraction` → `/admin/content/digital-signage-device/sos-power-action`
(permission `execute signageos power action`). Send power/reboot commands to devices (`Form/PowerAction`).

## Event integration
`EventSubscriber\SignageOs` (service `signageos.event_subscriber`) listens to Digital Signage
Framework events to provision/push content to signageOS.

## Prerequisite
Devices and scheduling are managed by `digital_signage_framework`; this module is the signageOS backend connector.
