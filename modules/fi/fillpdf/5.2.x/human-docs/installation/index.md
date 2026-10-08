# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **File**, **Options**, **Serialization**, and **Views** modules (all part
  of Drupal core; enabled as dependencies).
- The contributed **Token** module (`drupal/token`, `^1.0`) — a hard dependency
  Composer pulls in. Field mappings use tokens.
- **A PDF backend** — FillPDF does not fill PDFs by itself. You must set up exactly
  one of the three backends below (covered under [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/fillpdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Token.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fillpdf -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fillpdf -y
```

## Choose and prepare a backend

Before FillPDF can fill anything, decide which backend to run and get it ready.
You'll select and finish configuring it on the settings form (see
[Configuration](../configuration/index.md)).

| Backend | What you need to prepare |
|---------|--------------------------|
| **FillPDF Service** (hosted) | An account/API key for the hosted service, and the service host/endpoint. Simplest to run — nothing to install on your server — but templates and data are sent to the remote service. |
| **FillPDF LocalServer** (self-hosted) | Run the LocalServer service yourself (commonly via Docker) and note its base URL, e.g. `http://127.0.0.1:8085`. Keeps processing on your own infrastructure. |
| **pdftk** | Install the `pdftk` binary on the server and know its path (e.g. `/usr/bin/pdftk`). Fully on-server; also enables PDF encryption/passwords. |

### Storing the FillPDF Service API key safely

If you use the hosted **FillPDF Service**, treat its API key as a secret — never
hard-code or commit it. With DDEV, store it in an environment variable and load it
into the container:

```bash
ddev dotenv set .ddev/.env --fillpdf-service-api-key=<value>
ddev restart
```

(The flag `--fillpdf-service-api-key` becomes the variable
`FILLPDF_SERVICE_API_KEY`; keep `.ddev/.env` out of version control.) You can then
reference that variable — for instance via `getenv()` in `settings.php` to override
`fillpdf.settings:fillpdf_service_api_key` — instead of typing the key into the
settings form and committing it to config. The module ships **no** keys or secrets;
the API key, endpoints, and any PDF passwords are all admin-entered.

## Permissions

FillPDF adds three permissions (grant at **People → Permissions**):

| Permission | Grants |
|-----------|--------|
| **administer pdfs** | The settings form and all FillPDF form admin screens (upload, edit, delete, import/export, duplicate, field mapping). Also allowed to generate any PDF. This is the "site builder" permission. |
| **publish own pdfs** | Generating a PDF **only** for contexts whose entities the user can already *view* — the safe default for letting end users produce PDFs from their own/visible content. |
| **publish all pdfs** | Generating a PDF from any form and any content, bypassing per-entity view checks. Grant only to trusted roles. |

Next, finish setup on the settings form and create your first form — see
[Configuration](../configuration/index.md).
