<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Digital Signage Framework (digital_signage_framework) — agent index

**Publishes Drupal content entities to physical signage screens via pluggable platform + schedule-generator plugins.**

- **Version:** 2.6.x (2.6.1)
- **Core:** ^10.3 || ^11
- **Package:** Digital Signage
- **Configure:** `digital_signage_framework.settings` → `/admin/config/services/digital_signage_framework`
- **Depends on:** dimension, options, taxonomy, text, dynamic_entity_reference, inline_entity_form

**Entities:** `digital_signage_device`, `digital_signage_device_type`, `digital_signage_schedule`, `digital_signage_content_setting`.

**Plugin types:** `digital_signage_platform` (PlatformPluginManager), `digital_signage_schedule_generator` (ScheduleGeneratorPluginManager).

**Key services:** `schedule.manager.digital_signage_platform` (ScheduleManager), `digital_signage_content_setting.emergency` (Emergency), `digital_signage_framework.renderer`, `digital_signage_framework.middleware` (http_middleware, language-file fallback).

**Drush commands:** `src/Drush/Commands/` — `DeviceCommands`, `ScheduleCommands`, `FrameworkCommands`.

**Bundled submodules (optional):** `digital_signage_example` (demo platform), `digital_signage_custom_platform` (API-less platform), `digital_signage_computed_content` (computed/Views slides), `digital_signage_crowdsec` (Security package — CrowdSec integration for the device API).

**Key routes:**
- `/admin/config/services/digital_signage_framework` — settings (perm `administer digital signage framework`)
- `/api/digital_signage` — device rendering API (`_custom_access` = per-device HMAC fingerprint header)
- `/api/digital_signage/block/{id}` — refresh a signage block (`_custom_access` = device fingerprint or preview permission)
- `/admin/content/digital-signage-device/{sync-all,emergency-mode,schedule-push,schedule-config}` — dedicated push/emergency permissions

**Permissions:** `administer digital signage framework` (restricted), `administer digital signage content setting` (restricted), `administer digital signage device types` (restricted), `access digital signage device overview`, `view digital signage device`, `edit digital signage device`, `administer digital signage schedule` (restricted), `push digital signage schedule`, `push digital signage config`, `change digital signage emergency mode`, `digital signage framework access preview`, `access qr code`.

**Security posture:** Admin/config, schedule and push routes are permission-gated. The device API (`/api/digital_signage`) is not tied to a user permission: it is authorized by a per-device HMAC fingerprint derived from the site hash salt (`Api::fingerprint()`), sent in the `x-digsig-fingerprint` header, and `access()` also verifies the requested entity is actually scheduled on that device (or on the emergency list) before serving it. The block-refresh endpoint (`/api/digital_signage/block/{id}`) is authorized the same way — preview permission or a known device fingerprint — and only serves blocks that signage marks as refreshable in the default theme's signage regions, returning an identical 404 for anything else so block configuration cannot be enumerated.

See [configure/setup.md](configure/setup.md) and [api/device-api.md](api/device-api.md).
