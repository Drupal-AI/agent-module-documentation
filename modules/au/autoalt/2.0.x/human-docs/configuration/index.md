# Configuration

AutoAlt.ai is configured on one settings form, plus a separate bulk-operations
screen.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → AutoAlt**, or navigate directly to
   `/admin/config/content/autoalt`.

## Settings

- **API Key** — the key from your AutoAlt.ai account (https://autoalt.ai). It is
  used to authenticate the outbound calls to the AutoAlt.ai service and to draw
  down your credits. Keep it private.
- **Default language** — the default language for generated alt text.
- **Short alt text length** — the threshold below which existing alt text counts
  as "short", used when you target images that need better alt text.

You can also provide **SEO keywords / negative keywords** to guide how alt text
is generated, and choose a default language for the output.

### A note on the API key as a secret

The API key is stored in the module's configuration. Avoid committing it to
version control in a config export. On this DDEV-based project you can keep the
real value in the environment — for example:

```bash
ddev dotenv set .ddev/.env --autoalt-api-key=<value>
ddev restart
```

(the flag `--autoalt-api-key` becomes `AUTOALT_API_KEY` in the container; never
commit `.ddev/.env`) — and reference it from `settings.php` with
`getenv('AUTOALT_API_KEY')` as a config override so the key stays out of exported
config.

## Bulk operations

The bulk UI is separate, at **`/admin/config/media/autoalt/bulk-alt`** (also
requires Administer site configuration). From there you can:

- Generate alt text for many images at once.
- Filter runs by language.
- Skip images already processed by AutoAlt.
- Target only images with short or missing alt text.
- See remaining AutoAlt credits and total/short-alt image counts.

Generated alt text is saved back to image fields (`/api/autoalt/save-alt`,
restricted to **Administer media**) and media entities. A processing history is
available at **`/admin/content/autoalt/history`**.
