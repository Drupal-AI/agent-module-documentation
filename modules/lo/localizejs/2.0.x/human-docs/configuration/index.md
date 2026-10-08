# Configuration

## Enter your project key

1. Log in as a user with permission to administer the module's settings.
2. Go to **Configuration → System → Localize.js**, or navigate directly to
   `/admin/config/system/localizejs`.
3. Enter your **Localize Project Key** (from your Localize dashboard) and save.

From then on, every page carries the Localize.js JavaScript in its HTML header —
you can confirm this by viewing a page's source. Once the widget is present,
Localize automatically detects your content and it starts appearing in your
Localize dashboard for translation.

## Place the language switcher block

Localize can serve your content in the languages you've configured on the Localize
side (and can even assign a domain per language, e.g. `es.example.com`). To let
visitors switch language:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the block that Localize generates for switching between configured
   languages, and place it in the region you want.
3. Save the block layout.

## Handling the project key securely

The project key is a client-side identifier that ends up in your page markup, but
it is still best treated as configuration you don't want to leak into public
repositories. If you manage configuration in code and prefer to keep the value out
of exported config, store it in an environment variable and reference it rather
than committing it.

> **With DDEV**, you can store a value as an environment variable with
> `ddev dotenv set .ddev/.env --localizejs-project-key=<value>` (keep `.ddev/.env`
> out of version control), then `ddev restart` so the container picks it up.

## Privacy considerations

Remember that the Localize.js widget runs in your site's origin and **sends page
content to Localize for translation**. Extend trust to the vendor accordingly, and
disclose the third-party processing in your site's privacy policy.
