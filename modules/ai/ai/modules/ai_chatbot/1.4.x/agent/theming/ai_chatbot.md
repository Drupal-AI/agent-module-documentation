# theming — templates, libraries, style files

The chat UI is the third-party **Deep Chat** web component (`deepchat/deepchat.bundle.js`,
loaded as an ES module). The block builds a `#theme => 'ai_deepchat'` render array with
`#deepchat_settings` (each value JSON-encoded) plus `drupalSettings.ai_deepchat.*`, and
attaches the `ai_chatbot/deepchat` library.

## Theme hooks (`ai_chatbot_theme()`)

| Hook | Template | Notes |
|---|---|---|
| `ai_deepchat` | `ai-deepchat.html.twig` | main widget; vars: `settings`, `deepchat_settings`, `current_theme` |
| `ai_deepchat__toolbar` | `ai-deepchat--toolbar.html.twig` | toolbar-placement variant |
| `block__ai_deepchat_block` | `templates/block/block--ai-deepchat-block.html.twig` | block wrapper (base hook `block`) |
| `ai_chatbot` | `ai-chatbot.html.twig` | legacy form-based block |
| `ai_chatbot_message` | `ai-chatbot-message.html.twig` | legacy single message |

Template suggestion: `hook_theme_suggestions_ai_deepchat_alter` adds
`ai_deepchat__<placement>` (placement `-` → `_`), so create
`ai-deepchat--bottom-right.html.twig` etc. in your theme to override per placement.
`current_theme` is set to `chatbot-<active_theme>` for theme-scoped CSS.

## Libraries (`ai_chatbot.libraries.yml`)

- `ai_chatbot/deepchat` — the Deep Chat bundle + `js/deepchat-init.js` (main runtime).
- `ai_chatbot/chat` — `css/chat.css` (+ `chat-print` for print).
- `ai_chatbot/form-stream` — `showdown.min.js` + `form-stream.js` (legacy streaming form).
- `ai_chatbot/sticky-chatbot` — sticky bottom-corner placement CSS/JS.
- `ai_chatbot/toolbar-chatbot`, `ai_chatbot/toolbar-fullscreen` — toolbar button + fullscreen CSS/JS.
- `ai_chatbot/ai_chatbot` — admin block-form styling (attached via `hook_form_block_form_alter`).

## Toolbar / top-bar button

When an enabled `ai_deepchat_block` exists and the user has `access deepchat api`,
`ChatbotHooks` (`hook_toolbar`, `hook_preprocess_top_bar`) injects a hidden
`button--ai-chatbot` toggle (JS reveals it) so the assistant opens from the admin toolbar.

## Deep Chat style presets (`deepchat_styles/*.yml`)

Visual styles are YAML files with `name` + `parameters` keys. Bundled presets:
`toolbar.yml`, `chatgpt.yml`, `bing.yaml`, `bard.yml`. The block scans
`deepchat_styles/` in the `ai_chatbot` module (extendable via the
`hook_ai_chatbot_style_modules` alter) **and** in every installed theme, keying options as
`module:<name>:<file>` / `theme:<name>:<file>`. To add your own style, drop a
`deepchat_styles/mystyle.yml` (with `name:` and `parameters:`) into your theme — it then
appears in the block's "Style" select. `parameters` map onto Deep Chat component attributes
(e.g. `style`, `messageStyles`, `avatars`, `auxiliaryStyle`).

Programmatic overrides of these parameters/buttons/messages are done with alter hooks —
see [hooks/ai_chatbot.md](../hooks/ai_chatbot.md).
