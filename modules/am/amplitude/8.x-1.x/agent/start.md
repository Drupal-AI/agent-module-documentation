<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amplitude (amplitude) — agent index
**Injects the Amplitude JS SDK and fires configurable, path-scoped tracking events.**

- **Version:** 8.x-1.x  •  **Core:** ^9.2 || ^10 || ^11  •  **Requires:** token
- **Config route:** `amplitude.amplitude_config_form` → `/admin/config/system/amplitude`
- **Permission:** `administer amplitude settings`
- **Config entity:** `amplitude_event` (list/add/edit/delete via `AmplitudeEvent*` handlers)
- **Runtime:** `hook_page_attachments` attaches `amplitude/amplitude-events`; settings + matching events published to `drupalSettings.amplitude`.
- **Security:** admin config route is permission-gated; the exposed `api_key` is Amplitude's public client-side key (not a secret), no mutating or anonymous server endpoints.

See [configure/settings.md](configure/settings.md).