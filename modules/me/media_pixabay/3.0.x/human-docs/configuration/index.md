# Configuration

Setting up Media Pixabay has two parts: entering your API key on the settings page,
and adding the Pixabay widget to an Entity Browser so editors can actually use it.

## 1. Get a Pixabay API key

Register a free account at Pixabay and copy your API key from your Pixabay account
settings. Full API access (needed for the largest download sizes) may require
enabling it on your Pixabay account.

## 2. Enter the API key

1. Log in as a user with the **Administer Pixabay settings** permission.
2. Go to **Configuration → Media → Pixabay**, or navigate directly to
   `/admin/config/media/pixabay`.
3. Paste your **Pixabay API key** into the field and click **Save**.

> **Where the key is stored — and how to handle it.** This module stores the API
> key in ordinary Drupal configuration (the `media_pixabay.admin.config` object),
> not in a Key entity. That means it can end up in exported/committed config, so
> treat it accordingly: restrict who holds the **Administer Pixabay settings**
> permission, and prefer to keep the value out of version control. If you manage
> config in Git, exclude or override this config object per environment rather than
> committing the live key — for example set it from `settings.php` using a value
> read from the environment. To keep the secret in the environment with DDEV
> (never commit `.ddev/.env`):
>
> ```bash
> ddev dotenv set .ddev/.env --pixabay-api-key=<value>
> ddev restart
> ```
>
> The flag `--pixabay-api-key` becomes `PIXABAY_API_KEY` in the container; confirm
> it without printing it via `ddev exec 'test -n "$PIXABAY_API_KEY"'` (exit `0`
> means set), then reference it from `settings.php` with `getenv('PIXABAY_API_KEY')`
> to override the stored config value. A Pixabay key is lower‑risk than most
> secrets (it's a rate‑limited read key for a public API), but keeping it out of
> committed config is still good practice.

## 3. Add the Pixabay widget to an Entity Browser

The search UI lives inside an Entity Browser:

1. Go to **Configuration → Content authoring → Entity browsers** (Entity Browser's
   admin area) and edit or create an entity browser.
2. Add the **Pixabay** widget to it. Note that only **one** Pixabay widget per
   entity browser is supported.
3. Configure the widget:
   - **Target image media type** — the media type new imports are created as (must
     use the image source plugin).
   - **Allowed extensions** — loaded from the media type's source field; imports
     are validated against these. If the widget's list drifts from the media
     type's, the module warns you.
   - **Image size** — the download resolution (180 / 340 / 640 / 1280, or
     full‑HD/original with full API access).
   - **Upload location** — the path files are saved under, e.g.
     `public://Pixabay/[PIXABAY_SEARCH_TERM]/` (tokens require the Token module).

Wire that entity browser to a media/entity‑reference field's form widget as usual,
and editors will get a **Pixabay** tab to search and import from.

## How it behaves

When an editor searches, the module calls the Pixabay API over HTTPS with your key
and caches the results for 24 hours per search term. Selected images are downloaded
server‑side from the URLs in Pixabay's response and saved as image media entities
owned by the importing user, with alt text tagged from Pixabay's returned tags. The
download URL always comes from the trusted API response, not from user input.
