<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chatbot Lite

## What it is / when to use

- A lightweight, fully self-contained chatbot: no external AI/3rd-party platform.
- Answers from admin-configured question/answer pairs and from matching titles of selected content types.
- Use for simple FAQ-style conversational help.

---

## Install & configure

- Configure at `/admin/config/system/chatbot_lite` (route `chatbot_lite.settings`, permission `administer site configuration`).
- Define Q&A pairs (`question|answer` per line), searchable content types, fallback ("nothing found") answers, and words to ignore.
- A chat form is exposed at `/chatbot_lite_form` (route `chatbot_lite.chatbot_lite_form`, permission `access content`).
- Styling via the module's CSS/SCSS/JS libraries.

---

## Usage & API notes

- `ChatbotLiteAnswers::getAnswer()` normalises the question, then tries: configured Q&A pairs, then node-title search, then a fallback answer.
- Node-title search uses `\Drupal::entityQuery('node')` with a CONTAINS OR-group on `title`, limited to 5 results.
- Entity queries honour the node access grants system, so only nodes the user may see are matched.
- Matched node titles are rendered as links in the answer HTML.
- All answer content originates from admin configuration and node titles the user can already access — no third-party calls.
- The `access content` chat form is read-only Q&A; it performs no writes.
- Question text is tokenised and filtered against an ignore-word list.
- Randomised (`shuffle`) selection varies answers when several match.
- Config object is `chatbot_lite.settings` (bot_answer_questions, bot_searchable_entities, bot_answer_titles, bot_answer_nothing_found, bot_answer_words_to_ignore).
- A diacritics-normalisation table maps accented characters to ASCII.
- No external network calls, cron, or webhooks.
- No credentials or API keys are involved.
- Suited to small sites wanting a private, dependency-free chatbot.
- Extend the answer logic by subclassing/altering the controller.
- The bot answers only from data on your own site.
- Uninstall removes the `chatbot_lite.settings` config.
