<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Chat supplies the LLM endpoints behind AI assistance in the workflow editor — describing what you want and getting a workflow, or asking why one is not doing what you expected.

---

Building a workflow visually is easier than writing one in code and still requires knowing what nodes exist and how they connect. An assistant inside the editor closes that gap: describe the outcome, get a starting graph; select a node, ask what it does; describe a failure, get a suggestion.

This submodule is the server side of that — the chat endpoints the editor calls, backed by the AI module's configured provider so the credential stays server-side and the model is a site-level choice.

Two things worth stating when recommending it. **Cost**: editor assistance is a per-keystroke temptation, and every exchange is a billed model call; whoever can open the editor can spend. And **review**: a generated workflow is a suggestion, not a specification — it can call models, make HTTP requests and write content, so it needs the same reading before it runs as any workflow an unfamiliar colleague handed you.

---

- Describe a workflow and get a starting graph.
- Ask what a node does inside the editor.
- Get a suggestion for a failing workflow.
- Speed up authoring for a new user.
- Learn the node vocabulary interactively.
- Refactor a workflow with AI assistance.
- Explain an inherited workflow.
- Keep AI credentials server-side.
- Choose the model at site level.
- Reduce onboarding time for workflow authors.
- Draft a workflow before refining it by hand.
- Review generated workflows before running them.
- Track model spend from editor assistance.
- Restrict who may use editor assistance.
- Compare a generated workflow against intent.