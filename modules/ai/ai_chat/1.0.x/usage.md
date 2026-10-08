<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Chat adds a floating, role-aware AI chat widget to the bottom-right of every page, backed by the AI Assistant API.

---

AI Chat places a draggable chat bubble on the bottom-right corner of the site for users whose roles have been mapped to one or more AI Assistant entities. Clicking the bubble opens a panel where the user types a message; the widget POSTs it to the `ai_chat.send_message` controller, which runs the selected `ai_assistant` entity through the `ai_assistant_api.runner` service and returns the assistant's reply as JSON. Administrators configure everything from a single settings form at `/admin/config/ai/ai-chat`: which assistants each role may use, a per-role default assistant, the chat title, and the widget's primary colour. Conversation continuity is kept with a per-assistant thread id stored in the browser's `localStorage` (client side) and a per-user private tempstore (server side). The module itself defines no entities, plugins, permissions or Drush commands — all conversational behaviour, tools and agents come from the `ai_assistant` entity you build in the AI Agents / AI Assistant API modules. It depends on `ai_agents`, `ai_assistant_api` and core `user`, and lives in the "AI Tools" package.

---

- Add a floating AI chatbot to the bottom-right of every page of a Drupal site.
- Show the chat only to users in roles that an administrator has mapped to an assistant.
- Assign one or more AI Assistant entities to a role and let users switch between them from a dropdown in the chat header.
- Set a default assistant per role, used when the user has not chosen another.
- Give administrators access to every configured assistant regardless of role mapping.
- Customise the chat panel title (defaults to "AI Assistant" when left blank).
- Set the widget's primary colour, with automatic black/white contrast for the text on it.
- Let users drag the chat panel around the viewport; its position is remembered per assistant.
- Remember whether the panel was left open or closed, per assistant, across page loads.
- Continue a conversation across pages and reloads via a thread id kept in `localStorage`.
- Send messages over AJAX (`fetch`) without a full page reload, showing a loading indicator.
- Submit with Enter and insert newlines with Shift+Enter in the message box.
- Turn plain URLs in the assistant's reply into clickable links that open in a new tab.
- Provide a keyboard- and screen-reader-friendly toggle button with ARIA attributes.
- Front a customer-support or FAQ assistant for authenticated users.
- Offer an internal editorial helper assistant to content-editor roles only.
- Expose a site-search or navigation assistant that can call the assistant's configured tools/agents.
- Run different assistants for different audiences (e.g. staff vs. members) from one widget.
- Reuse any assistant already built for the AI Assistant API without extra glue code.
- Rebrand the widget's colour to match a site theme.
- Give administrators a quick way to test every configured assistant on any page.
