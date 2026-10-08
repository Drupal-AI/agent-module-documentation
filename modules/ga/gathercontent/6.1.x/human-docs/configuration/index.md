# Configuration

Setting up GatherContent is a two‑step job: first connect your GatherContent
account, then map each GatherContent template to a Drupal content type. Both live
under **Configuration → Web services → GatherContent**
(`/admin/config/services/gathercontent`) and require the **Administer
GatherContent** permission.

## 1. Connect your account

Open the authentication sub‑page (`/admin/config/services/gathercontent/config`)
and enter:

- **Account email** — the email address of your GatherContent account.
- **API key** — the API key generated in your GatherContent account settings.

Save the form. The module uses these credentials (through the
`gathercontent/client` library over Drupal's HTTP client, with normal TLS
verification) to fetch your projects, templates, and items.

> **Keep the API key secret.** GatherContent stores the email and key in the
> `gathercontent.settings` configuration, which means they can end up in exported
> config. Do **not** commit them to version control. Prefer supplying the key from
> an environment variable — with DDEV, `ddev dotenv set .ddev/.env
> --gathercontent-api-key=<value>` then `ddev restart` — and keep any config
> exports private.

## 2. Map templates to Drupal content

Open the import‑configuration form (`.../import-config`, provided by the
**GatherContent UI** submodule). Here you:

- Pick a GatherContent **project** and **template**.
- Choose the Drupal **entity type and bundle** (for example, a content type) that
  imported items should become.
- **Map fields** — line up each GatherContent template field with the Drupal field
  that should receive it. This covers plain text, files and images, taxonomy
  references, and meta tags.

Save the mapping. Each saved mapping becomes a Migrate definition behind the
scenes.

## 3. Run imports

With a mapping in place you can import items — either from the import selection
form in the UI or by running the underlying migrations with Drush (for example
`drush migrate:import <migration_id>`). Re‑running an import updates the existing
Drupal entities from the latest GatherContent revisions, so you can keep content
in sync as it changes upstream.

## Pushing content back (optional)

If you enabled **GatherContent Upload** (and its UI), you can also push Drupal
content back up to GatherContent from the corresponding upload screens — useful
when editing happens on both sides.
