AI Image Alt Text adds a "Generate with AI" button to image field widgets that fills the alt text from a vision-capable AI model, using the AI (AI Core) module as its backend.

---

The module hooks into every image field widget (`hook_field_widget_single_element_form_alter`) and, when the field has alt text enabled and the user holds the `generate ai alt tags` permission, injects a "Generate with AI" button next to the uploaded image. Clicking it (JS in `js/ai_image_alt_text.js`) calls the `ai_image_alt_text.generate` controller route, which builds a `ChatInput` containing a Twig-rendered prompt plus the image as an `ImageFile` and sends it through AI Core's `ai.provider` service. Provider/model resolution lives in the `ai_image_alt_text.provider` service (`ProviderHelper`): it uses the model chosen on the settings form, or falls back to the site's default provider for the `chat_with_image_vision` operation type. Before sending, the image is downscaled and reformatted through a configurable image style (the module ships an `ai_image_alt_text` image style) to cut token cost. The prompt is configurable and supports `{{ entity_lang_name }}` and `{{ filename }}` Twig tokens, and the entity's language is passed through so alt text is generated in the content's language. Because it is widget-based it keeps a human in the loop — the editor reviews the suggestion before saving — but an "autogenerate on upload" option can trigger generation automatically. Settings live at `/admin/config/ai/ai_image_alt_text`. A bundled submodule, `ai_image_bulk_alt_text`, adds a batch UI to fill missing alt text across many images at once.

---

- Add a one-click "Generate with AI" button to any image field's alt text on content edit forms.
- Auto-write descriptive alt text for uploaded images using an AI vision model.
- Improve accessibility (a11y) by ensuring images ship with meaningful alt text.
- Improve image SEO with accurate, descriptive alt attributes.
- Keep a human in the loop: editors review and edit the AI suggestion before saving.
- Generate alt text in the content entity's language rather than always English.
- Customize the generation prompt with accessibility best-practice instructions.
- Use `{{ entity_lang_name }}` and `{{ filename }}` tokens in the prompt via Twig rendering.
- Downscale and reformat images through an image style before sending, to reduce AI cost.
- Send the original image (no image style) when a provider needs full resolution.
- Automatically generate alt text on upload without editor action (autogenerate option).
- Hide the manual button when autogenerate is on to streamline the widget.
- Restrict who can trigger AI generation via the `generate ai alt tags` permission.
- Pin a specific provider/model for alt text, independent of other AI features.
- Fall back to the site's default `chat_with_image_vision` provider/model automatically.
- Reuse an existing AI Core provider (OpenAI, Anthropic, Fireworks, …) already configured on the site.
- Warn admins when no AI provider is configured so alt text generation can be enabled.
- Generate alt text for images embedded in nodes, media entities, paragraphs, or any image field.
- Bulk-generate alt text for many images at once (via the `ai_image_bulk_alt_text` submodule).
- Fill in missing alt text across an existing image library after installing the module.
- Standardize alt text quality and tone site-wide through a single shared prompt.
- Support multilingual sites by producing per-language alt text from the same image.
- Reduce manual editorial effort on large media libraries.
- Preview the generated alt text in the widget before it is written to the field.
- Configure everything from one settings page at `/admin/config/ai/ai_image_alt_text`.
