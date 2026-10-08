# Configuration

There are two layers to configure: the **NanoBanana AI provider** (which holds
the API key and connects to the image service) and **NanoBanana Editor's own
settings** (system instructions and reusable style presets). You should also
understand the cost and privacy implications before letting editors use it.

## Step 1 — Configure the AI provider and its API key

The credentials for the image service live on the **NanoBanana AI provider**
module (`ai_provider_nanobanana`), not on the editor itself. Configure that
provider first and give it a valid API key.

**Store the key securely — never hard‑code or commit it.** Save it as an
environment variable and reference it through a Key entity. With DDEV:

```bash
ddev dotenv set .ddev/.env --nanobanana-api-key=<value>
ddev restart
```

Then, using the [Key](https://www.drupal.org/project/key) module, create a Key
backed by that environment variable and select it in the AI provider's settings.
Keep `.ddev/.env` out of version control. This way the secret never lands in code
or in exported configuration.

## Step 2 — NanoBanana Editor settings

Once the provider works, open **Configuration → Media → NanoBanana Settings**
(`/admin/config/media/nanobanana`).

### System Instructions

A block of global instructions that is prepended to **every** prompt, edit and
generation alike. Use it to enforce a consistent tone, style, or quality bar
across the whole site. For example:

```
Generate high-quality, professional images suitable for editorial use.
Maintain photorealistic style unless otherwise specified.
```

### Image Styles

Reusable **style presets** that editors can pick from a dropdown when generating
or editing. To add one:

1. Click **Add style**.
2. Enter a **Style Name** (for example "Watercolor", "Photorealistic", or "Comic
   Book") — this is the label editors will see.
3. Enter a **Style Prompt** — the phrasing that gets applied, such as "in
   watercolor painting style" or "photorealistic with dramatic lighting".
4. Click **Add style** to save it.

Repeat for as many presets as you want to offer.

## Cost, privacy, and access

- **Cost:** every edit or generation is a paid API call to the provider. High‑res
  Gemini 3 Pro output and multi‑image compositions cost more. Budget accordingly
  and consider limiting who can trigger generations.
- **Privacy / egress:** the images you edit or upload as references, along with
  your prompts, are **sent to the AI provider's servers**. Do not process
  confidential or personal images you are not permitted to share externally.
- **Access:** the module provides its own permissions — grant image generation and
  editing only to **trusted editors** via **People → Permissions**.

## Save and test

Save the settings, then go to **Content → Media → Add media → Image** and click
**Generate with NanoBanana**. Enter a prompt, choose a model and (optionally) one
of your style presets, click **Generate** to preview, and **Save** to create the
media entity. If generation fails, re‑check the provider's API key.
