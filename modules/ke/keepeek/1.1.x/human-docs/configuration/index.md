# Configuration

Setting up Keepeek has two parts: connecting Drupal to your Keepeek platform, then
creating a media type that uses it.

## 1. Connect to Keepeek

1. Make sure the Keepeek team has **enabled your Drupal module account** — the
   integration must be activated on the Keepeek side first.
2. Log in as an administrator and go to **Configuration → Keepeek** (route
   `keepeek.settings`).
3. Enter your **Keepeek connection details / API credentials** and save.

> **Treat the credentials as secrets.** Store the API credentials securely and
> scope them to only what the integration needs. Prefer supplying secret values
> from the environment rather than committing them — with DDEV you can store a value
> with `ddev dotenv set .ddev/.env --keepeek-…=<value>` (never commit `.ddev/.env`)
> and reference it from `settings.php`. Anyone who can export site configuration can
> read credentials stored directly in config.

## 2. Create a Keepeek media type

1. Go to **Structure → Media types** (`/admin/structure/media`) and click **Add
   media type**.
2. Give it a **name** (for example "Keepeek image").
3. For **media source**, select **Keepeek**.
4. **Source field** — select an existing field, or leave it to have one created
   automatically.
5. **JSON field** — select an existing field, or leave it to have one created
   automatically.
6. Click **Save** / create.
7. On the media type's **Manage display** tab:
   - For the **Keepeek field**, select the **Keepeek** format.
   - Make sure the **JSON field is not displayed**.
   - Save the display.

## 3. Reference the media type from content

1. Go to **Structure → Content types → *(your content type)* → Manage fields**.
2. Click **Create a new field**, choose a **Media** reference field, and give it a
   label.
3. Add it, then on **Save field settings** and the field's parameters, under the
   Keepeek field parameters select your **Keepeek media type**.

Keepeek is now ready — editors can insert Keepeek assets into that field through the
Media Library, browsing with Keepeek's search, filters, collections, and folders,
and cropping or resizing images as they go.
