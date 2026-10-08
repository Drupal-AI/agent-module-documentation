<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Publications Importer Copilot adds an AI-powered transform step to the LocalGov Publications Importer pipeline: it hands the text/HTML extracted from an imported PDF to a Microsoft Copilot Studio agent and uses the agent's response to split and format the content into paginated JSON pages.

---

The module contributes one `LocalGovImporter` transform plugin, `CopilotAllInOne` (id `transform_copilot_aio`), plus a ready-made import pipeline config (`copilot_pipeline`) that chains `smalot_pdfparser` extraction, image and line-break transforms, then the Copilot transform, then a `save_publication` step. At runtime the plugin (constructed with `@http_client`) obtains a Direct Line token from a configured `token_url`, opens a conversation against the Direct Line base URL (default `https://directline.botframework.com/v3/directline`), posts the content with a configurable `prompt` and `trigger_phrase`, and polls (up to `poll_timeout`) for the bot's reply, which it expects to be a JSON array of `{title, content}` page objects. The bundled "Copilot Studio Agent Solution" zip is the companion bot definition to import into Copilot Studio.

Security review: the plugin talks to Microsoft's Direct Line API over HTTPS using Guzzle defaults (TLS verification enabled; no `verify => false`). The Direct Line token is sent as a standard `Authorization: Bearer <token>` header. The `token_url`, base URL and prompt are administrator-supplied pipeline configuration, not request input, and the plugin has no routes, permissions, or public endpoints of its own — it runs only as part of an operator-triggered import. Operational notes: the `token_url` must be configured (the plugin logs an error and aborts otherwise); the endpoint receives your extracted document content, so treat imported documents and the configured bot as a data-processing/third-party consideration for privacy review.

---
- Format imported PDF content into paginated JSON via Copilot.
- Add an AI transform step to a Publications Importer pipeline.
- Use the ready-made `copilot_pipeline` config as a starting point.
- Configure the Direct Line `token_url` for your Copilot bot.
- Override the Direct Line base URL if needed.
- Customise the prompt sent to the Copilot agent.
- Set a trigger phrase to route to the right topic.
- Tune the polling timeout for long generations.
- Split long publications into evenly sized pages automatically.
- Preserve permitted HTML tags (headings, lists, images) during formatting.
- Import the companion Copilot Studio bot from the bundled zip.
- Chain PDF extraction, image, and line-break transforms before the AI step.
- Save the AI-formatted pages as publication content.
- Generate descriptive per-page titles from content.
- Keep img tags and attributes intact through the transform.
- Process council publications into structured web pages.
- Log and abort cleanly when the token URL is unconfigured.
- Point the pipeline at a different Copilot agent per environment.
