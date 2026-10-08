# Configuration

Setting up Search API opensolr has three parts: enter your opensolr **credentials**,
create a **core and Search API server** (automatically or manually), then index
your content with Search API as normal.

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

- **With the Key module installed** (recommended), the settings form lets you
  store the key as a **Key entity**. You can select an existing key or create a new
  one. This lets the key come from an environment variable or file provider instead
  of living in exported configuration.
- **Without Key**, the key is stored as a raw config value. An operator can still
  override it from `settings.php`/environment if desired.

> **Keeping the secret out of code.** Prefer the Key module with an environment
> variable so the API key never lands in your repository. Set the value in the
> environment (for example with DDEV's dotenv), then point a Key entity at that
> variable.

## Set up a core and server

Once credentials are saved you have three ways to get a working server:

### Option A — Get started (register a new opensolr account)

If you don't yet have an opensolr account, the **Get started** form
(`/admin/config/search/search-api/opensolr/get-started`) walks you through a
multistep registration: confirm you need an account, enter your email to receive an
activation code, then enter the code to create the account. On success your new API
key and email are saved and you're taken to Autoconfigure.

### Option B — Autoconfigure (core + server in one step)

The **Autoconfigure** form (`.../opensolr/autoconfigure`) lists the compatible
opensolr environments/regions. Pick one and start: the module creates an opensolr
core, creates a matching Search API Solr **server** wired to the *Opensolr with
Basic Auth* connector, and uploads the Solr configuration archive. This is the
quickest path.

### Option C — Add a server manually

Under **Search API**, choose **Add server** and pick the Solr connector **Opensolr
with Basic Auth (recommended)**. The connector form lists your account's cores —
choose one. The Basic Auth username and password are pre-filled from that core and
hidden. On save, the module builds and uploads the Solr config archive
automatically.

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
