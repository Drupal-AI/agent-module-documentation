<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chat:LiveHelperChat

## What it is / when to use

- Integrates a self-hosted Live Helper Chat (LHC) server: injects the chat widget and optionally FAQ into Drupal pages.
- Use to add live-support chat backed by your own LHC installation.
- Provides visibility controls over which pages show the widget.

---

## Install & configure

- Configure at `/admin/config/chat_livehelperchat/livehelperchatformsettings` (route `chat_livehelperchat.live_helper_chat_form_settings`, permission `administer chat_livehelperchat`).
- Enter your LHC server URL/embed snippet and visibility rules.
- Grant `use php for livehelperchat visibility` only to trusted admins (it allows PHP visibility conditions).
- Grant `use injectjs server config for chat_livehelperchat` to allow header JS injection from the chat server.

---

## Usage & API notes

- Settings persist to `chat_livehelperchat.livehelperchatformsettings` config.
- The widget/embed is injected into pages based on the configured visibility rules.
- The `use php for livehelperchat visibility` permission enables PHP-snippet visibility evaluation — like core PHP filter, this is dangerous and is `restrict access: TRUE` (admin-only).
- The `.module` reads its own `README.md` via `file_get_contents` for the help page (a static local file, not user input).
- FAQ integration surfaces LHC FAQ content within Drupal.
- All three permissions are declared `restrict access: TRUE`.
- Chat traffic goes to your LHC server; this module mainly injects the embed markup/JS.
- No anonymous mutation or callback endpoints are exposed by the module.
- Visibility can target specific pages/paths.
- Header JS injection is opt-in and permission-gated.
- Review any PHP visibility snippets you add — they execute with site privileges.
- The embed snippet/URL is entered by an administrator.
- Suited to organisations self-hosting Live Helper Chat.
- Styling via the module's CSS/JS libraries.
- Ensure the LHC server is served over HTTPS for secure chat.
- Uninstall removes the module config.
