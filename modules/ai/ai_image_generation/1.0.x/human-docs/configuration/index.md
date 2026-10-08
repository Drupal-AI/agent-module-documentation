# Configuration

There are two screens: a **settings** form where you enter your OpenAI
credentials once, and a **generation** form you use each time you want images.
Both require the **Administer site configuration** permission, so keep them to
trusted admins — every generation costs money at OpenAI.

## Step 1 — Enter your OpenAI credentials

1. Get an API key and Organisation ID from <https://platform.openai.com>.
2. Go to **Content → AI Image generation settings**, or navigate directly to
   `/admin/content/ai_image_generation_settings`.
3. Fill in the two required fields:
   - **Organisation ID** — your OpenAI organisation identifier (saved as `orgid`).
   - **API Key** — your OpenAI secret key (saved as `apikey`).
4. Save.

Both values are stored in the configuration object `ai_images_api.settings` in
plain text, and the API Key field is a normal text input. Because of that, keep
this config object out of any shared/committed configuration export and treat it
as a secret.

## Step 2 — Generate images

Go to **Content → AI Image generation** (`/admin/content/ai_image_generation`).
The **Generate Image** button is disabled until a key has been saved on the
settings form. The form fields are:

- **Prompt** — the text description of the image you want (up to 255 characters).
- **Model** — choose **dall-e-2** or **dall-e-3**.
- **Size** — the output resolution, from `256x256` up to `1792x1024` (the
  available sizes depend on the model).
- **Count** — how many images to generate at once, 1–4. DALL·E 3 is limited to a
  single image per request, so this is forced to 1 when you pick dall-e-3.
- **Style** *(DALL·E 3 only)* — **vivid** or **natural**.
- **Quality** *(DALL·E 3 only)* — **standard** or **HD**.

Pressing **Generate** runs the request in the background (an AJAX call) and shows
the results inline as a preview. Generated images are held temporarily in your
session, not yet saved.

## Step 3 — Keep the ones you want

Each previewed image has a **save** checkbox. Tick the images you want to keep and
press **Save Image**. The module decodes those images, writes them as JPEG files
into the public files directory (`public://`), and creates an `image` Media entity
for each, owned by you. From then on they behave like any other media item and can
be reused anywhere the media library is referenced.

## The pricing page

A read-only page at `/ai_image_generation/AIusage` shows a static DALL·E pricing
table (and a link to OpenAI's usage dashboard) so you can gauge cost before
generating. It contains only hard-coded numbers and exposes no key or usage data.

## Troubleshooting

- **Generate button greyed out** — no API key saved yet; complete Step 1.
- **Errors after generating** — OpenAI errors (such as a `429` rate-limit
  response) are surfaced back in the form. Request/response details are also
  written to the Drupal log under the `AI Image` channel, so avoid leaving that
  readable to non-admins.
