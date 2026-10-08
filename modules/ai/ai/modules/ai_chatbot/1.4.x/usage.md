AI Chatbot is a ready-made frontend for the AI Assistant API: it provides a placeable Drupal block that renders a conversational chat widget and wires user messages to a configured AI Assistant, streaming or displaying the LLM responses back to the visitor.

---

AI Chatbot ships a "AI DeepChat Chatbot" block plugin (`ai_deepchat_block`) that you place through the normal Block layout UI and point at one of the AI Assistants you created with the `ai_assistant_api` submodule (it is a hard dependency). The chat UI itself is the third-party Deep Chat web component (bundled in the module as `deepchat/deepchat.bundle.js`), configured entirely from PHP via a `#deepchat_settings` render array and `drupalSettings`. The block form exposes bot name/image, user name/avatar, a first (intro) message, streaming, placement (toolbar, bottom-right, bottom-left), a YAML-defined visual style, width/height, expansion/fullscreen behaviour, and a copy-to-clipboard icon. When placement is "toolbar" the module adds a toolbar/top-bar button (via `hook_toolbar` / `hook_preprocess_top_bar`) that opens the chat, and forces the bundled `toolbar.yml` style. Messages are exchanged over CSRF-protected AJAX routes (`/api/deepchat`, `/api/deepchat/session`) gated by the `access deepchat api` permission, and short-term conversation history is replayed from the assistant's session. Responses are Markdown, so the module strongly recommends installing `league/commonmark` (otherwise raw Markdown is shown). Look and feel is customisable through Twig templates, per-theme/per-module `deepchat_styles/*.yml` style files, and three alter hooks (`hook_deepchat_settings`, `hook_deepchat_buttons_alter`, `hook_deepchat_prepend_message`). A legacy form-based block (`ai_chatbot_block`) also exists but DeepChat is the current frontend.

---

- Add a floating "chat with us" assistant to your site by placing the AI DeepChat Chatbot block in a region.
- Put an AI assistant button in the admin toolbar / top bar for logged-in editors (toolbar placement).
- Front a support/FAQ AI Assistant so anonymous visitors can ask questions in natural language.
- Choose which AI Assistant (created in `ai_assistant_api`) a given chatbot block talks to.
- Run different chatbots on different sections of the site by placing multiple blocks with different assistants and visibility rules.
- Stream LLM responses token-by-token for a live "typing" feel (legacy, non-agent assistants only).
- Show verbose step-by-step progress messages while an agent-backed assistant works.
- Seed the conversation with a custom first/intro message written in Markdown.
- Brand the widget with a custom bot name and bot avatar image.
- Show the logged-in user's username and profile picture as their chat avatar.
- Dock the chat window bottom-right or bottom-left, or embed it inline, with a custom width and height.
- Let users expand the chat to a larger panel or full screen for readability.
- Add a one-click copy icon under each assistant reply.
- Restrict who can use the chatbot with the `access deepchat api` permission (e.g. authenticated users only).
- Persist and replay a visitor's recent conversation history within their session.
- Reset a conversation/thread via the built-in reset-session AJAX endpoint.
- Apply a ChatGPT-, Bing-, or Bard-like visual style using the bundled `deepchat_styles` YAML presets.
- Ship your own theme-provided chat style by adding a `deepchat_styles/*.yml` file to a theme.
- Restyle the widget with per-placement Twig templates (`ai-deepchat--toolbar.html.twig`, etc.).
- Inject custom Deep Chat parameters (colours, layout, avatars) with `hook_deepchat_settings`.
- Add custom action buttons (like/dislike, links) beneath assistant messages with `hook_deepchat_buttons_alter`.
- Prepend extra text to outgoing assistant messages with `hook_deepchat_prepend_message`.
- Render assistant Markdown as clean HTML by installing the optional `league/commonmark` library.
- Prototype and test an AI Assistant quickly by dropping its chatbot block on a page.
- Give agent-based assistants (with connected AI Agents / tools) a conversational UI without writing frontend code.
