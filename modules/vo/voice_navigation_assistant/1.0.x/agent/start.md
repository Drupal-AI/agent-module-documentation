<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voice Navigation Assistant (voice_navigation_assistant) — agent index

**Accessibility voice-navigation widget with role-specific spoken command sets and audio instructions.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Configure:** `/admin/config/user-interface/voice-navigation-assistant` (`administer voice navigation assistant`)
- **Export:** `/voice-navigation-assistant/export` → JSON download (same permission)
- **Config:** `anonymous_commands`, `authenticated_commands`, `admin_commands` + audio/voice prefs
- **Permission:** `administer voice navigation assistant`
- **Security:** Both routes require `administer voice navigation assistant`; the export controller only serialises stored config to JSON. No anonymous mutation, no external calls. No security findings.
