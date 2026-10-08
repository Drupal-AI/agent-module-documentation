AIDmi adds a CKEditor 5 button and sidebar action that generate 508-compliant image alt text (and optional visible figcaptions) with the Drupal AI module's vision providers.

---

AIDmi (AI, describe my image!) integrates with CKEditor 5 to help content editors produce accessible image metadata without leaving the editor. A toolbar button sweeps every image in the body (inline `<img>` uploads and `drupal-media` image embeds), sends each image — optionally with the surrounding article text as context — to a vision-capable AI provider, and returns suggested alt text plus an optional detailed caption. Results open in a review dialog where the editor accepts the AI suggestion, edits it, or marks the image decorative; choices are written back into the content, and captions restructure the asset into an HTML `<figure>`/`<figcaption>`. A second, per-image action appears next to the core Alternative Text field for focused single-image generation. Model selection, the base prompt, a context toggle, and a caption toggle live at `/admin/config/services/aidmi`. All provider and API-key handling is delegated to the Drupal AI and Key modules — AIDmi stores no credentials.

---

- Generate Section 508 / WCAG alt text for images embedded in node/body rich-text fields.
- Add an "AI, describe my image!" button to any CKEditor 5 text format's toolbar (Full HTML, Basic HTML, custom formats).
- Bulk-describe every image in the editor body in one click, then review all suggestions in a single dialog queue.
- Generate alt text for a single image via the AI action button next to the core Alternative Text field.
- Produce alt text for inline `<img>` uploads as well as `drupal-media` image embeds.
- Send the surrounding article text to the model so descriptions match the page's topic and context (toggleable).
- Generate long, descriptive visible captions rendered as `<figcaption>` inside an HTML `<figure>` (toggleable).
- Mark an image as decorative from the dialog (empty alt + `role="presentation"`, caption removed).
- Customize the base AI prompt instructions to fit an organization's alt-text style guide.
- Swap between any vision-capable AI provider/model configured in the Drupal AI module (OpenAI, Anthropic, Azure, etc.) without code changes.
- Fall back to the AI module's default `chat_with_image_vision` provider/model when no model is explicitly chosen.
- Test the configured provider/model live from the settings form before saving ("Test Connection").
- Keep model API keys out of the module by relying on the AI module's Key-backed provider configuration.
- Restrict who can invoke AI generation via the `generate aidmi accessibility` permission.
- Enforce a ~150-character alt-text ceiling and a JSON-structured response contract in the prompt for predictable output.
- Speed up editorial accessibility remediation of image-heavy content.
- Give editors an editable starting point rather than blank alt fields, improving overall alt-text coverage.
- Support graphs/charts and photos of people with tailored prompt guidance for meaningful descriptions.
- Standardize accessibility text across a content team by centralizing the prompt and model in site config.
