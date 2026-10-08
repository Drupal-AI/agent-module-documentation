<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop AI Provider adds AI-powered nodes to FlowDrop's visual workflows by routing every AI call through the Drupal AI module's provider abstraction.

---

Install it with `composer require drupal/flowdrop_ai_provider` and `drush en flowdrop_ai_provider`, which pulls in the AI, AI Agents and FlowDrop modules and imports 19 ready-made workflow node types (chat, embeddings, moderation, summarize, rerank, translate, text-to-image, image-to-image, image classification, object detection, image/audio-to-video, text-to-speech, speech-to-text/speech, audio-to-audio, plus guardrails and session-history helper nodes) and a reusable `flowdrop` AI-prompt type. The module holds **no credential of its own**: you configure a provider (OpenAI, Anthropic, Ollama, and so on) and its API key — typically as a **Key entity** — once at `/admin/config/ai/providers`, set default models per operation at `/admin/config/ai/settings`, and every workflow then picks a model by configuration, so exported/shared workflow definitions never carry a secret. Node types whose operation type has no configured provider are automatically hidden from the editor sidebar and flagged with a warning that links to compatible provider modules. Each `chat` node's system prompt accepts either literal text or an `ai_prompt:<id>` reference to a reusable prompt entity; a `guardrails` node applies AI Guardrail Sets to text; and the `flowdrop_workflow` chat processor lets the AI chatbot answer through an entire FlowDrop workflow with per-thread conversation memory and human-in-the-loop interrupts. File inputs (images, audio) are fetched through a hardened loader with SSRF and path-traversal protection. Requires Drupal `^11` (composer: `drupal/core:^11.3`) and PHP `>=8.2`.

---

- Add an AI chat node to a FlowDrop workflow.
- Run a workflow as an AI chatbot's backend.
- Generate images from a text prompt in a workflow.
- Transcribe uploaded audio to text (speech-to-text).
- Convert workflow text to speech audio.
- Translate text between languages inside a pipeline.
- Generate vector embeddings for search or RAG.
- Moderate user-supplied text for unsafe content.
- Summarize long content into a short summary.
- Re-rank documents by relevance to a query.
- Classify or detect objects in an image.
- Transform images or turn images/audio into video.
- Apply AI guardrail sets to input or output text.
- Reuse a named AI prompt across many workflows.
- Swap the model or provider without editing a workflow.
- Keep API keys out of exported workflow bundles.
- Give a FlowDrop Reason node a real function-calling backend.
- Feed multi-turn conversation history into a chat node.
- Set provider-side spend limits to control AI cost.
- Audit which workflows call AI models.
- Restrict AI nodes to admins via the `administer flowdrop` permission.
- Configure per-node parameters at /admin/flowdrop/config/node-types.
- Verify the module's behaviour after a Drupal upgrade.
- Document the AI workflow architecture for the team.
