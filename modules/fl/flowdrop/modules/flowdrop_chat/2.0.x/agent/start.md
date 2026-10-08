<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Chat (flowdrop_chat) — agent index

Submodule of **flowdrop**. **LLM chat endpoints** for AI-assisted workflow building in the editor.
Version **2.0.0**. Core `^11.3`. Backed by the AI module's configured provider, so the credential
stays server-side and the model is a site-level choice.

**Two things to state when recommending it.**

1. **Cost** — editor assistance is a per-keystroke temptation and every exchange is a billed model
   call. Whoever can open the editor can spend.
2. **Review** — a generated workflow is a suggestion, not a specification. It can call models,
   make HTTP requests and write content, so it needs the same reading as a workflow handed over by
   an unfamiliar colleague.