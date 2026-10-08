<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
signageOS connects Drupal's Digital Signage Framework to the signageOS platform, so Drupal-managed content and device actions drive real signageOS-powered screens.

---


It provides a settings form (`/admin/config/services/digital_signage_framework/signageos`, permission `administer site configuration`) for the signageOS connection, and a power-action form (`/admin/content/digital-signage-device/sos-power-action`, permission `execute signageos power action`) to send power/reboot commands to devices. An event subscriber reacts to Digital Signage Framework events to push provisioning/content to signageOS. It is a connector on top of `digital_signage_framework`, which owns the device entities and scheduling.

Setup: configure signageOS API credentials on the settings form, register devices through the Digital Signage Framework, then manage/power them from the framework's device screens.
---
- Connect Drupal to the signageOS device platform.
- Configure signageOS connection/credentials.
- Push digital-signage content to signageOS screens.
- Send a power action (e.g. reboot) to a device.
- Restrict power actions with a dedicated permission.
- React to Digital Signage Framework events.
- Provision devices to signageOS.
- Drive kiosk/display screens from Drupal.
- Manage signage devices via the framework.
- Restrict connection settings to site administrators.
- Schedule content through the signage framework.
- Integrate content updates with signageOS timings.
- Trigger device commands from the admin UI.
- Keep signage content in sync with Drupal changes.
- Operate multiple signage displays centrally.
- Extend the Digital Signage Framework with a real backend.
