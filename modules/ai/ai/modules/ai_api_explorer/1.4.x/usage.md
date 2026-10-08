AI API Explorer is a development-only submodule of AI Core that adds a set of admin "explorer" forms where a site builder can interactively test AI operations (chat, embeddings, moderation, image generation, and more) against the configured provider and model, and copy generated boilerplate code to reproduce each call in a module.

---

The module ships an `AiApiExplorer` plugin type: each plugin is one explorer form for a specific AI operation type (Chat Generation, Embeddings, Summarize, Moderation, Text-to-Image, Speech-to-Text, Translation, Rerank, Object Detection, Tools, and others). A landing page at `/admin/config/ai/explorers` (route `ai_api_explorer.list_page`) lists the explorers that are actually usable given your installed providers, and a route subscriber dynamically registers one form route per plugin at `/admin/config/ai/explorers/<plugin_id>`. All of it is gated by the single `access ai prompt` permission, and each explorer can additionally veto itself through `isActive()` (e.g. when no provider supports its operation) and refine access through `hasAccess()`. Because these forms let a user pick a provider, model and prompt and then spend real API credits, the README stresses the module is intended for development sandboxes only, not production. Each explorer renders a two- or three-column AJAX form, runs the call through AI Core's provider services, shows the normalized response inline, and offers a "Code Example" details element with copy-pasteable PHP. The module also alters the AI tools library select form to add a "Test this tool" link into the Tools Explorer. It has no configuration of its own — behavior is entirely driven by which AI providers and operation types are available. Other modules can add their own explorer forms simply by supplying a new `AiApiExplorer` plugin.

---

- Test a chat prompt against your configured LLM before wiring it into code (Chat Generation Explorer).
- Compare how different providers/models answer the same prompt by switching the provider select in the form.
- Generate an embeddings vector for a snippet of text and inspect the raw output (Embeddings Explorer).
- Try text summarization settings interactively (Summarize Text Explorer).
- Check whether a piece of user text trips content moderation (Moderation Explorer).
- Generate an image from a text prompt and preview it (Text-To-Image Explorer).
- Transcribe an uploaded audio file to text (Speech-To-Text Explorer).
- Synthesize speech from text and listen to the result (Text-To-Speech Explorer).
- Convert one audio clip to another voice/style (Speech-To-Speech and Audio-To-Audio Explorers).
- Transform an existing image with an image-to-image model (Image-To-Image Explorer).
- Classify an uploaded image or detect objects in it (Image Classification and Object Detection Explorers).
- Classify text into categories (Text Classification Explorer).
- Translate text between languages via the translate operation (Translate Text Explorer).
- Re-rank a set of candidate documents against a query (Rerank Explorer).
- Combine an image and audio track into a video (Image-and-Audio-to-Video Explorer).
- Invoke and debug a function-calling tool (FunctionCall plugin) from the UI (Tools Explorer), reachable via the "Test this tool" link on the AI tools library form.
- Grab ready-made PHP boilerplate for any call from its "Code Example" panel to paste into a custom module.
- Confirm a newly installed provider/model actually works end-to-end before building on it.
- Show teammates or clients a live demo of an AI capability without writing any code.
- Verify that provider configuration and the selected Key are correct by making a real call.
- Discover which AI operations your current provider set actually supports (the list page hides explorers with no active provider).
- Add a bespoke explorer for a custom operation by writing a new `AiApiExplorer` plugin.
- Reproduce and inspect a failing AI request while debugging integration issues.
