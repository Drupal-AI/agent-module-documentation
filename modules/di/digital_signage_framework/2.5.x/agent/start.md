<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Digital Signage Framework (digital_signage_framework) — agent index

**Publishes Drupal content entities to physical signage screens via pluggable platform + schedule-generator plugins.**

- **Version:** 2.5.x (2.5.6)
- **Core:** ^10 || ^11
- **Package:** Digital Signage
- **Configure:** `digital_signage_framework.settings` → `/admin/config/services/digital_signage_framework`
- **Depends on:** dimension, options, taxonomy, text, dynamic_entity_reference, inline_entity_form

**Entities:** `digital_signage_device`, `digital_signage_device_type`, `digital_signage_schedule`, `digital_signage_content_setting`.

**Plugin types:** `digital_signage_platform` (PlatformPluginManager), `digital_signage_schedule_generator` (ScheduleGeneratorPluginManager).

**Key services:** `schedule.manager.digital_signage_platform` (ScheduleManager), `digital_signage_content_setting.emergency` (Emergency), `digital_signage_framework.renderer`, `digital_signage_framework.middleware` (http_middleware, language-file fallback).

**Key routes:**
- `/admin/config/services/digital_signage_framework` — settings (perm `administer digital signage framework`)
- `/api/digital_signage` — device rendering API (`_custom_access` = per-device HMAC fingerprint header)
- `/api/digital_signage/block/{id}` — render a block (perm `access content`)
- `/admin/content/digital-signage-device/{sync-all,emergency-mode,schedule-push,schedule-config}` — dedicated push/emergency permissions

**Permissions:** `administer digital signage framework` (restricted), `administer digital signage content setting`, `administer digital signage device types`, `access digital signage device overview`, `push digital signage schedule`, `push digital signage config`, `change digital signage emergency mode`, `digital signage framework access preview`, `access qr code`.

**Security:** Admin/config and push routes are permission-gated. The device API (`/api/digital_signage`) is authenticated by a per-device HMAC fingerprint (hash-salt derived) rather than a user permission, and access() verifies the requested entity is actually scheduled on the device; the HMAC compare uses `!==` not `hash_equals()`. The `/api/digital_signage/block/{id}` endpoint renders any block config entity gated only by `access content`, bypassing the block's own visibility conditions.

See [configure/setup.md](configure/setup.md) and [api/device-api.md](api/device-api.md).
