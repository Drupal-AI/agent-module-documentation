<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Voice Navigation Assistant adds an accessibility widget that lets visitors navigate a site by voice, using role-specific command sets defined by the administrator.

---

Commands are stored in module configuration split into `anonymous_commands`, `authenticated_commands` and `admin_commands`, so different audiences get different voice vocabularies, plus initial audio instructions and voice preferences. The front-end assistant listens for these spoken commands and performs the mapped navigation. An admin form at `/admin/config/user-interface/voice-navigation-assistant` (`administer voice navigation assistant`) edits the command sets, and an export controller (`VoiceCommandController::exportCommands`, same permission) downloads all three command groups as a JSON file for backup or sharing.

Setup: enable the module, grant `administer voice navigation assistant` to editors, define the commands and audio instructions per role, and the widget becomes available to matching visitors. Both routes are permission-gated; the export simply serialises stored config to JSON.
---
- Let users navigate the site with voice commands
- Provide accessibility support for motor-impaired visitors
- Define separate command sets for anonymous, authenticated and admin users
- Speak initial audio instructions on page load
- Configure voice preferences (e.g. language/voice)
- Map spoken phrases to navigation actions
- Export all voice commands as a JSON file
- Back up command configuration for reuse
- Share a command set between sites via export
- Restrict command editing to `administer voice navigation assistant`
- Improve WCAG/keyboard-free navigation options
- Offer hands-free browsing
- Customise commands per audience
- Deliver spoken guidance to first-time visitors
- Manage everything from one admin config form
