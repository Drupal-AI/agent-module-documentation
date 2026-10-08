# Configuration

Setting up Search API opensolr has three parts: enter your opensolr **credentials**,
create a **core and Search API server** (automatically or manually), then index
your content with Search API as normal. The **Get started** page
(`/admin/config/search/search-api/opensolr/get-started`) is a handy guide that shows
which of these steps you've already completed.

## Permission

All the admin screens here require the **administer search_api_opensolr**
permission. The configuration-upload actions on a server additionally require edit
access to that Search API server. Grant *administer search_api_opensolr* to your
administrator role under **People → Permissions**.

## Enter your opensolr credentials

Go to **Configuration → Search and metadata → Search API → Opensolr**
(`/admin/config/search/search-api/opensolr`). Enter:

- **Email** — the email of your opensolr account.
- **API key** — the API key from your opensolr dashboard.

Use **Test connection** to confirm the credentials work before saving. The module
ships with these fields **empty** — there is no built-in key.

### Where the API key is stored

- **Store the API key with the Key module** — a checkbox on this form. It is only
  available when the **Key** module is installed, and it is an **explicit opt-in**:
  tick it to keep the key in a **Key entity** (authentication type), which can draw
  its value from an environment variable or file provider instead of living in
  exported configuration. You can select an existing key or create a new one.
- **Leave the checkbox off** and the key is stored as a raw config value. An
  operator can still override it from `settings.php`/environment if desired.

> **Keeping the secret out of code.** Prefer the Key module with an environment
> variable so the API key never lands in your repository. Set the value in the
> environment (for example with DDEV's dotenv), then point a Key entity at that
> variable and tick the checkbox.

## Set up a core and server

Once credentials are saved you have two ways to get a working server (the **Get
started** page links to both):

### Option A — Autoconfigure (core + server in one step)

The **Autoconfigure** form (`.../opensolr/autoconfigure`) lists the compatible
opensolr environments/regions (Solr 8 and newer). Pick one and start: the module
creates an opensolr core, creates a matching Search API Solr **server** wired to the
*Opensolr with Basic Auth* connector, and uploads the Solr configuration archive.
This is the quickest path.

### Option B — Add a server manually

Under **Search API**, choose **Add server** and pick the Solr connector **Opensolr
with Basic Auth (recommended)**. The connector form lists your account's cores —
choose one. The Basic Auth username and password are pre-filled from that core and
hidden. On save, the module builds and uploads the Solr config archive
automatically.

> Don't have an opensolr account yet? Create one at
> [opensolr.com/register](https://opensolr.com/register), then come back and enter
> its email and API key above. Account creation happens on opensolr.com.

## The two connectors

Both connectors self-populate their connection settings from your opensolr
account, so the only real choice on the form is **which core**:

- **Opensolr** — the standard connector; fills the connection details from the
  selected core.
- **Opensolr with Basic Auth (recommended)** — the same, plus HTTP Basic Auth
  pre-filled from the core. It also shows the core's **disk usage** and **monthly
  bandwidth** in the server's view settings, with an upgrade link if you exceed a
  quota. This is the one Autoconfigure uses; prefer it.

## If the configuration upload fails

Each opensolr-backed server has an **Opensolr** tab with fallback actions:

- **Upload config zip** — re-upload the whole Solr configuration archive.
- **Import config files** — re-upload individual files that failed.

## Finish in Search API

With the server connected, add your Search API index to it and index your content
exactly as you would for any Search API Solr setup. To migrate an existing Search
API Solr site to opensolr, you can simply swap the server's connector to the
opensolr one and pick a core.

## Per-core security (submodule)

If you enabled **search_api_opensolr_security**, you can manage per-core HTTP Basic
Auth credentials and IP allow-lists for your opensolr cores' query and admin
handlers directly from Drupal.
