<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI + adds an AI chatbot tool to the Navigation Plus Edit Mode toolbar so editors can chat with an assistant that reads and edits the page they are on.

---

AI + (ai_plus) is a thin integration layer for the "+ Suite" page builder. It wires together Navigation Plus (Edit Mode toolbar), AI Chatbot (the DeepChat panel), AI Agents (the agent framework), and Entity Blueprint (JSON entity serialization for AI). It adds an "AI" tool and an always-on chat sidebar to Edit Mode: the assistant is told which entity the user is viewing and which specific blocks/fields they have selected, then acts on the page through AI Agents tools — placing blocks, rewriting fields, and generating images. After the AI changes content, the module surgically re-renders and highlights the affected Layout Builder components. Image fields are filled asynchronously: a placeholder shows immediately, then a deferred processor generates the real image through the configured `text_to_image` AI provider and swaps it into the layout. Provider-specific submodules (`ai_plus_anthropic`, `ai_plus_gemini`) refine how context is phrased and how image dimensions are requested. All model calls go through the `ai` module's provider plugins; ai_plus itself makes no external API calls and stores no API keys.

---

- Add an AI assistant chatbot to the Navigation Plus Edit Mode toolbar (hotkey `A`).
- Give editors an always-on chat panel that survives Edit Mode toggles.
- Let editors ask the AI to edit the page they are currently viewing.
- Select specific blocks or fields on the page as context ("change this heading").
- Show selected elements as numbered badges on the page and chips in the chat.
- Automatically inject the current entity's type, id, bundle and title into the agent prompt.
- Pass the current Layout Builder view mode to the agent so it reads the right schema.
- Have the AI create new pages/entities and get a click-through link back to them.
- Rewrite field text in place through AI Agents tools.
- Generate images for image fields directly from a natural-language prompt.
- Show a placeholder image immediately and swap in the AI-generated image asynchronously.
- Request AI images at a chosen aspect ratio appropriate to the layout role.
- Automatically retry rejected image prompts by having the LLM rephrase them.
- Fall back to a configured placeholder media when image generation is turned off.
- Toggle AI image generation per-user from the Edit Mode toolbar, or site-wide by an admin.
- Auto-refresh the editable page after the AI modifies content (polling or instant).
- Highlight exactly which Layout Builder components the AI changed after a refresh.
- Choose which AI Assistant entity powers the chat on the Navigation Plus settings form.
- Restrict the assistant to trusted editors via the `use ai assistant` permission.
- Restyle the chat panel (colors, fonts, bubbles) via `hook_ai_plus_deepchat_style_alter()`.
- Extend context formatting per LLM family with provider submodules.
- Extend image sizing per provider with image-dimension adapters.
