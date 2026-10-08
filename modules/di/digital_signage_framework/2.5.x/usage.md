<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generic framework to publish Drupal content entities to physical digital-signage screens through pluggable platform integrations.

---

Digital Signage Framework models a signage estate as three content entity types — Device (a physical screen), Device type (a hardware/orientation profile) and Schedule (an ordered playlist of content) — plus a Content setting entity that marks which bundles are publishable to signage. A pluggable `digital_signage_platform` plugin type adapts the generic model to a concrete vendor platform (signageos and similar) and a `digital_signage_schedule_generator` plugin type builds the per-device playlist. A schedule manager pushes generated schedules and configuration to devices, and an Emergency service can force an emergency playlist across all screens.

Devices render their content by calling the framework's own HTTP API (`/api/digital_signage`). That route is not permission-gated for normal users: it is authorized by a per-device HMAC fingerprint (`Crypt::hmacBase64(extId, hashSalt . deviceId)`) supplied in the `x-digsig-fingerprint` header, with an alternate path for editors holding `digital signage framework access preview`. The `mode`/`type`/`entityType`/`entityId` query parameters select what is returned, and access() confirms the requested entity is actually on that device's schedule (or emergency list) before allowing it. A companion `/api/digital_signage/block/{id}` route renders an arbitrary block config entity and is gated only by `access content`. Admin configuration lives at `/admin/config/services/digital_signage_framework` behind `administer digital signage framework`; device/schedule push actions have their own dedicated permissions. Setup means enabling a platform submodule, creating device types and devices, marking bundles as signage content, and pushing a schedule.

---
- Enable the framework and a concrete platform integration (e.g. signageos) that provides a `digital_signage_platform` plugin.
- Create a device type describing hardware, orientation (landscape/portrait) and resolution.
- Register a physical screen as a Device entity and bind it to a platform plugin.
- Mark which content entity bundles are publishable via a Digital signage content setting.
- Build an ordered Schedule (playlist) of content entities for a device.
- Push a generated schedule to one or many devices from the device overview.
- Push device configuration to screens with the "Push configuration" action.
- Synchronize all devices at once via `/admin/content/digital-signage-device/sync-all`.
- Enable or disable estate-wide emergency mode to force an emergency playlist.
- Grant editors the preview permission so they can preview signage output in the admin UI.
- Preview a single content entity as it will appear on a given device.
- Render device CSS, schedule, diagram, screenshot or log output through the API modes.
- Configure custom web fonts for signage output under the Fonts tab.
- Adjust schedule-generation settings under the Schedules settings form.
- Add analog/digital clock or expose-actions helper modules recommended by the framework.
- Use the QR code permission to expose device pairing/identification codes.
- Extend the estate with a custom `digital_signage_platform` plugin for a new vendor.
- Implement a custom `digital_signage_schedule_generator` to change playlist logic.
- React to signage render events (Libraries, Overlays, Underlays, Rendered) via event subscribers.
- Attach blocks to signage output rendered through the block API endpoint.
- Use the provided image styles/view modes (portrait, landscape) for signage media.
- Restrict who can change emergency mode, push schedules or push config via granular permissions.
