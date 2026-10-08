# ai_image_alt_text — agent start

Adds a "Generate with AI" button to image field widgets that fills the **alt text** from a
vision-capable AI model. Backend is **AI Core** (`ai`): it resolves the default provider for
the `chat_with_image_vision` operation and sends the image + a configurable prompt as a
`ChatInput`. Depends on core `image` and `ai:ai`. Config UI:
**Admin → Config → AI → AI Image Alt Text Settings** (`/admin/config/ai/ai_image_alt_text`);
settings route `ai_image_alt_text.settings_form`.

- Enable generation, pick provider/model, prompt, image style, autogenerate, button → [configure/ai_image_alt_text.md](configure/ai_image_alt_text.md)
- Generate route, ProviderHelper service, how the AI Core chat call is built → [api/ai_image_alt_text.md](api/ai_image_alt_text.md)

Permissions: `generate ai alt tags` (gates the button + the generate route);
the settings form requires `administer ai`. No Drush commands, no plugin types.

Submodule documented separately under
`modules/ai_image_alt_text/modules/ai_image_bulk_alt_text/1.0.x/`: batch-generate alt text
for many images missing it.
