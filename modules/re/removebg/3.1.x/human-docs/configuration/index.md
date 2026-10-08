# Configuration

Setting up remove.bg is a two-part job: enter your API details on the module's
settings form, then add the effect to an image style. You do both as an
administrator holding the **administer removebg** permission.

## Open the settings form

Go to **Configuration → remove.bg** (`/admin/config/removebg`). This form stores
the module's settings and, once a key is entered, calls the provider's account
endpoint to display your remaining credits and status.

## Settings

- **API provider** — choose **remove.bg** or **rembg.com** (rembg). Each posts to
  its own fixed endpoint; you can switch providers here without touching your image
  styles.
- **API key** — the key issued by your chosen provider. It is sent as an API-key
  header on each request. This is a **secret** — see the note below on storing it
  safely.
- **Output format** — the format of the returned image (for example PNG, which
  preserves the transparency you're paying for).

Click **Save configuration**.

## Add the effect to an image style

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Edit an existing style or add a new one.
3. Add the **remove.bg** effect and save.

When an image is built through that style, the effect writes the source image to a
temporary file and sends it to the provider's API, then replaces the derivative
with the returned, background-removed image. Derivatives are cached like any image
style, so the API is not called again for the same image until the style is
flushed. To reprocess existing images, flush the image style.

## Storing the API key safely (important)

The API key is a credential, and by default it is stored in the module's
configuration (`removebg.settings`), which exports to YAML.

- **Keep it out of version control.** If you export configuration for deployment,
  the key can end up in the exported YAML — do not commit that, and restrict who
  can access or export configuration.
- **Prefer an environment variable.** The recommended pattern on this project is
  to keep secrets in an environment variable rather than in files. With DDEV, set
  one with `ddev dotenv set .ddev/.env --removebg-api-key=<value>` (which becomes
  the variable `REMOVEBG_API_KEY`; never commit `.ddev/.env`), then `ddev restart`
  so it's available in the container. Where Drupal offers a **Key** entity to
  reference such a variable, use it so the secret is not stored inline. At minimum,
  treat `removebg.settings` as sensitive.

## What gets sent to the provider (egress and privacy)

The background removal happens **on the provider's servers**, so the image being
processed is uploaded to remove.bg or rembg.com over HTTPS.

- Only the **image under processing** is sent — not a request-supplied URL — so
  there's no server-side request-forgery surface, and the connection uses standard
  TLS verification.
- Even so, be mindful of **what** you send. If images contain people or sensitive
  content, sending them to a third-party API has privacy implications — make sure
  that's acceptable under your privacy policy and the provider's terms.
- Each processed image consumes provider **credits**, so factor cost into how
  widely you apply the effect (and remember derivatives are cached).

## Save

Save the settings form and the image style. Test on a sample image and confirm the
returned derivative has a transparent background before applying the style broadly.
