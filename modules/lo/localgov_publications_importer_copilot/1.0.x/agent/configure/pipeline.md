<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Copilot import pipeline

## Pipeline
Install config `localgov_publications_importer.localgov_import_pipeline.copilot_pipeline` defines an import pipeline:
`smalot_pdfparser` (extract) → `transform_images` → `transform_line_breaks` → `transform_copilot_aio` → `save_publication` (save).

## Transform plugin config (`transform_copilot_aio`)
Keys read by `CopilotAllInOne`:
- **`token_url`** (required) — URL that returns a Direct Line token. If empty, the plugin logs `Token URL must be configured for the transform plugin.` and aborts.
- **`direct_line_base_url`** — default `https://directline.botframework.com/v3/directline`.
- **`poll_timeout`** — max seconds to poll for the bot's reply (default 240).
- **`trigger_phrase`** — phrase to activate the Copilot topic (default `drupal-pdf-importer`).
- **`prompt`** — instructions to the agent; the default asks for ONLY a JSON array of `{title, content}` page objects, 200–500 words each, using a restricted HTML tag set (h1–h6, p, ul, ol, li, img), with images preserved.

## Runtime flow
1. `GET {token_url}` → Direct Line token.
2. `POST {base}/conversations` with `Authorization: Bearer <token>`.
3. `POST {base}/conversations/{id}/activities` with the content + prompt/trigger phrase.
4. Poll activities until the JSON reply arrives or `poll_timeout` elapses.

All calls are HTTPS via `@http_client` with default TLS verification. Import the bundled *Copilot Studio Agent Solution* zip into Copilot Studio to provision the matching bot. Because extracted document content is sent to Microsoft's endpoint, review data-processing/privacy implications for your publications.
