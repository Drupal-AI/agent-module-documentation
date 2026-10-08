<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Session provides the entities and services for interactive workflow runs — a session, and the messages exchanged within it.

---

An interactive workflow is a conversation: a person says something, the workflow responds, and both sides need a record of what has been said. This submodule supplies that record — a session entity representing the exchange and message entities within it — plus the services for managing them.

Modelling it as entities rather than as scratch state has consequences worth wanting. The conversation survives a page reload and a server restart; it can be listed, searched and reported on; access to it follows Drupal's entity access rather than a bespoke check; and it can be deleted, which matters because a conversation with a user is personal data.

It underpins `flowdrop_chat` and `flowdrop_playground`, both of which are conversational surfaces, and pairs with `flowdrop_memory` — the session is the transcript, memory is what the agent retains from it.

---

- Model an interactive workflow as a session.
- Record messages exchanged in a run.
- Survive a page reload mid-conversation.
- List a user's past sessions.
- Resume an earlier conversation.
- Apply entity access to conversations.
- Delete a user's conversation history.
- Report on conversation volume.
- Search message content.
- Underpin a chat interface.
- Separate transcript from agent memory.
- Correlate a session with its workflow run.
- Audit what an agent said to a user.
- Export a conversation.
- Keep conversation data governable.