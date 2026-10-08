# permissions

ai_chatbot defines a single permission (`ai_chatbot.permissions.yml`):

| Permission | Gates |
|---|---|
| `access deepchat api` | The runtime AJAX endpoints the widget calls: `ai_chatbot.api` (`/api/deepchat`, CSRF-protected POST), `ai_chatbot.session` (`/api/deepchat/session`), and `ai_chatbot.reset_conversation` (`/ajax/chatbot/reset-session/...`). Also required for the toolbar/top-bar chat button to appear. |

Notes:
- Grant this to whichever roles should be able to *use* a chatbot. The block form itself
  warns you to also set the block's role/visibility so anonymous users don't reach a
  restricted assistant.
- One route is looser: `ai_chatbot.message_skeleton` (`/ajax/chatbot/message-skeleton/...`)
  requires only core `access content`.
- Actual access to a placed block additionally depends on the block plugin's own
  `blockAccess()`, which checks that the chosen `ai_assistant` exists, is enabled, is set up,
  and that the current user passes the assistant's own access check (per-user cached).
- Placing/editing the block requires core `administer blocks`. There is no
  `administer`-style permission of its own — configuration lives in the Block layout UI.
