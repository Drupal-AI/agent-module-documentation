# ai_chatbot (AI Chatbot) 1.4.x — agent index

Frontend chatbot for the **AI Assistant API**. Provides a placeable block that renders
the third-party **Deep Chat** web component and talks to an `ai_assistant` entity you
built with the `ai_assistant_api` submodule (hard dependency). Configured entirely via
block settings + `drupalSettings`; no admin settings page of its own.

Mental model: place the **`ai_deepchat_block`** block → pick an **AI Assistant** → messages
POST over AJAX (`/api/deepchat`) to the assistant runner → Markdown replies render (install
`league/commonmark`). Look/feel comes from Twig templates + `deepchat_styles/*.yml` + alter hooks.

- **Place & configure a chatbot block** (assistant, placement, streaming, styling) → [configure/ai_chatbot.md](configure/ai_chatbot.md)
- **Theme it** (templates, libraries, style YAML, toolbar button, theme hooks) → [theming/ai_chatbot.md](theming/ai_chatbot.md)
- **Alter Deep Chat rendering** (`hook_deepchat_settings`, buttons, prepend) → [hooks/ai_chatbot.md](hooks/ai_chatbot.md)
- **Permissions** (`access deepchat api`) → [permissions/ai_chatbot.md](permissions/ai_chatbot.md)

Part of the `ai` project. Requires `ai:ai_assistant_api`. No plugin types, no Drush commands.
