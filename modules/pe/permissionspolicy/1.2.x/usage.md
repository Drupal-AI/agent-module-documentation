<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions Policy sends a `Permissions-Policy` HTTP response header that tells browsers which powerful features (camera, microphone, geolocation, fullscreen, autoplay, etc.) your site and its embedded frames are allowed to use.

---

The module adds a response event subscriber that, on each main request, reads the config object `permissionspolicy.settings` and, if the `enforce` policy is enabled, builds a `Permissions-Policy` header from the configured features. Each feature is a browser capability (the full W3C allowlist — `geolocation`, `camera`, `microphone`, `payment`, `fullscreen`, `usb`, `clipboard-read`, and dozens more) with a `base` keyword of `self` (only your origin), `none` (nobody), `any`/`*` (everyone), or empty, plus an optional list of extra allowed `sources` (origins). The header string is assembled as an RFC 8941 structured-fields dictionary via the `gapple/structured-fields` library — e.g. `geolocation=(self), camera=(), autoplay=*`. A `PolicyAlterEvent` lets other modules programmatically adjust the policy before it is serialized. It is configured at `/admin/config/system/permissionspolicy` (permission `administer permissions policy configuration`), ships enabled with an empty feature set (so no header until you add features), and adds a cache tag so responses invalidate when the policy changes. There are no Drush commands and no field or entity integration — it is purely a site-wide security header.

---

- Disable geolocation for the whole site by setting the `geolocation` feature to `none`.
- Restrict `camera` and `microphone` access to your own origin only (`self`).
- Turn off `autoplay` so embedded media cannot start playing automatically.
- Block `usb`, `serial`, `hid`, and `bluetooth` device access from the browser.
- Prevent third-party iframes from requesting `payment` or `publickey-credentials-get`.
- Allow `fullscreen` only for your origin and one trusted embed provider (via `sources`).
- Opt out of Google's `interest-cohort` (FLoC) by setting it to `none`.
- Lock down `clipboard-read` / `clipboard-write` to same-origin scripts.
- Disable `display-capture` (screen sharing) across the site.
- Harden a site against feature abuse by embedded ad or widget iframes.
- Meet a security-audit requirement to emit a `Permissions-Policy` header.
- Allow `encrypted-media` (DRM playback) only on your video pages' origin.
- Set a strict default (`none`) for sensors like `accelerometer`, `gyroscope`, `magnetometer`.
- Permit `web-share` only from your own origin.
- Explicitly allow `fullscreen` for a video-hosting partner domain.
- Disable `idle-detection` and `screen-wake-lock` for privacy.
- Combine several features into one policy managed from a single admin form.
- Let a custom module tweak the policy per-response via the `PolicyAlterEvent`.
- Deploy a consistent Permissions-Policy across environments via exported config.
- Remove a previously emitted header by clearing the feature (empty header → header removed).
- Restrict `browsing-topics` / `attribution-reporting` advertising APIs.
