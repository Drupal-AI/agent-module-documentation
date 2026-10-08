<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Publications Importer Copilot (localgov_publications_importer_copilot) — agent index

**A Publications Importer transform plugin that sends extracted PDF content to a Microsoft Copilot Studio bot (Direct Line) and formats the reply into paginated JSON pages.**

- **Version:** 1.0.x (1.0.0-alpha1) · **Core:** ^10 || ^11 · **Depends:** localgov_publications_importer · **Package:** LocalGov Drupal
- **Plugin:** `CopilotAllInOne` (id `transform_copilot_aio`, `LocalGovImporter/Transform`), ctor `@http_client`.
- **Pipeline config:** `copilot_pipeline` — extract `smalot_pdfparser` → `transform_images` → `transform_line_breaks` → `transform_copilot_aio` → `save_publication`.
- **Runtime:** GET `token_url` for a Direct Line token → POST `{direct_line_base_url}/conversations` (default `https://directline.botframework.com/v3/directline`) with `Authorization: Bearer <token>` → post content + `prompt`/`trigger_phrase` → poll (`poll_timeout`) for a JSON array of `{title, content}`.
- **Bundled:** "Copilot Studio Agent Solution" zip (companion bot to import).
- **Security:** no routes/permissions/public endpoints; runs only inside an operator-triggered import. HTTPS with Guzzle default TLS verification (no `verify=>false`); token via `Authorization: Bearer`. `token_url`/base URL/prompt are admin config, not request input. Privacy note: extracted document content is sent to the external Copilot endpoint. No security findings.

See [configure/pipeline.md](configure/pipeline.md)
