<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# chatbot_lite — agent orientation

- Self-contained keyword/FAQ chatbot (no 3rd-party service). Admin `/admin/config/system/chatbot_lite`; chat form `/chatbot_lite_form` (`access content`).
- Answer engine `src/Controller/ChatbotLiteAnswers.php`: config Q&A pairs → node-title CONTAINS search (entityQuery, respects node grants, range 5) → fallback.
- Answers built from admin config + accessible node titles only; No external calls, no writes, no keys.
- Node search honours access grants.
