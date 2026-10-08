<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ChatGPT Content Assistance integrates OpenAI (GPT chat-completion and DALL·E) into Drupal so editors can generate article text, translate nodes, create images, and extract SEO keywords without leaving the admin UI.

---

The module adds three OpenAI-backed editorial features. On node add/edit forms it injects a "ChatGPT Content Generator" modal link above each long-text field; an editor types a prompt, the module asks the configured GPT model to "Write an article on this topic", and a JS helper copies the result straight into the CKEditor 5 (or plain text) field. On a node's Translate tab it overrides core's content-translation overview to add a "Translate using ChatGPT" link per language, which round-trips each text field through GPT and saves a new translation. A separate "OpenAI Content Assistance Tool" tab under admin/content offers three operations: generate images from a prompt with DALL·E, extract SEO keywords from text, or generate a full article and save it directly as an `article` node. All calls go to endpoints you set on the OpenAI configuration page (default `api.openai.com`) using a Bearer access token, over Drupal's Guzzle `http_client`. GPT responses are also passed through OpenAI's moderation endpoint, and flagged content is replaced with a policy-violation notice. The module needs an OpenAI API key and content sent for generation/translation leaves your infrastructure to OpenAI — a governance and cost consideration for confidential content, since generation and image calls are billed per use.

---

- Generate draft article body text from a prompt directly on a node edit form.
- Insert AI-generated content into a CKEditor 5 rich-text field with one click.
- Insert AI-generated content into a plain text/textfield when no editor is present.
- Enable the generator only on selected content types (bundles) via configuration.
- Add a "Translate using ChatGPT" action per language on a node's Translate tab.
- Auto-populate a new node translation for languages that lack one.
- Translate title and text/string fields of a node into a target language via GPT.
- Generate images from a text prompt using OpenAI DALL·E.
- Choose the number of DALL·E images (n) and the image size (256/512/1024 px).
- Extract SEO keywords from a block of text using the GPT model.
- Create a complete `article` node from a title, word limit, and prompt in one step.
- Choose the GPT model version label (GPT-3.5 / GPT-4 / GPT-4o-mini) and exact model name.
- Point the module at custom OpenAI-compatible completion / DALL·E / moderation endpoints.
- Tune `max_tokens` to cap output length and cost.
- Tune `temperature` for more or less creative output.
- Run generated text through OpenAI's moderation endpoint and block flagged output.
- Gate content generation behind the "Access ChatGPT search form" permission.
- Gate translation behind the "Access ChatGPT Translation" permission.
- Gate the settings page behind the "Administer ChatGPT plugin configuration" permission.
- Speed up multilingual editorial workflows with machine-drafted translations.
- Give editors an in-context AI writing assistant without a separate tool.
- Prototype AI content workflows on Drupal 9, 10, or 11.
