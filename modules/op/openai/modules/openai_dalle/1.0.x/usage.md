OpenAI DALL·E adds an admin form for generating images from a text prompt using OpenAI's DALL·E 3 or
DALL·E 2 models. It exposes the image endpoint's options — model, size, quality, style and response
format — and can either return the OpenAI image URL or decode and save the image as a permanent file
in the site's public files.

---

The module provides a single explorer form at `/admin/config/openai/dalle`, gated by the
`access openai dalle` permission, backed by `DalleForm`. It calls the parent OpenAI module's
`openai.api` service (`OpenAIApi::images()`), so it needs the parent's configured API key. The form
validates prompt length and size per model (dall-e-2 vs dall-e-3), and dall-e-3-only options (quality
and style) are shown conditionally. With `url` output it renders a link to the OpenAI-hosted image;
with `b64_json` output it base64-decodes the payload and creates a permanent public `File` entity
(named from the Filename field) owned by the current user, then links to it. Errors are handled
silently and the form rebuilds. It has no configuration object or Drush command of its own; it is a
utility for testing image generation and saving results into the media/file system.

---

- Generate a marketing hero image from a text description.
- Test DALL·E 3 vs DALL·E 2 output for the same prompt.
- Produce placeholder imagery during site building.
- Create illustrative images and save them to the public files directory.
- Experiment with vivid vs natural styles for brand imagery.
- Compare HD and standard quality for a given prompt.
- Generate square vs landscape vs portrait images by size.
- Get a shareable OpenAI image URL without saving a file.
- Save a generated image as a permanent File entity for reuse.
- Prototype concept art for a campaign quickly.
- Generate icons or spot illustrations for content.
- Produce sample images for design/layout mockups.
- Explore prompt phrasing and its effect on results.
- Create images for demo or QA content.
- Generate on-brand imagery within character limits per model.
- Provide editors a quick in-admin image generator.
- Produce alternate image variations by resubmitting prompts.
- Generate imagery for social posts at required aspect ratios.
- Test OpenAI content-policy rejections on prompts.
- Seed a file library with AI-generated images.
