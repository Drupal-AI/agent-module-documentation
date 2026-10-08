# Configuration

All of oEmbed Providers' screens live under **Configuration → Media → oEmbed
Providers** (`/admin/config/media/oembed-providers`) and are gated by the single
**Administer oembed providers** permission. There are three things to configure:
the global **settings**, your **custom providers**, and optional **buckets**.

## Global settings

On the main settings form (`/admin/config/media/oembed-providers`):

- **Fetch external providers list** (`external_fetch`, on by default) — whether
  Media still fetches the remote provider list from oembed.com. Turn it **off** to
  use only the providers you've defined locally — useful for offline, air-gapped,
  or tightly curated sites.
- **oEmbed providers URL** (default `https://oembed.com/providers.json`) — the URL
  Media fetches the remote list from. Point it at a mirror or an alternate list if
  you need to. (This value actually lives in core's `media.settings`, but this form
  edits it for you.)
- **Clear Provider Cache** — a button that clears the cached provider list. The
  list is cached in Drupal's KeyValue storage, so an ordinary "Clear all caches"
  won't refresh it — use this button after changing a provider.

## Add a custom oEmbed provider

Go to **Custom providers**
(`/admin/config/media/oembed-providers/custom-providers`) and click **Add
provider**. A provider has:

- **Provider name** — the display name. **Important:** it must match the
  `provider_name` that the endpoint actually returns, or Media won't match embeds
  correctly.
- **Provider URL** — the provider's website URL.
- **Endpoints** — one or more, each with:
  - **Schemes** — the URL patterns this endpoint handles, using `*` wildcards (for
    example `https://example.com/media/*`).
  - **Endpoint URL** — the oEmbed API URL. You can include `{format}` in it, which
    Media replaces with `json` at fetch time.
  - **Discovery** — whether the provider supports oEmbed discovery.
  - **Formats** — JSON and/or XML.
  - A provider must **either** support discovery **or** declare at least one
    format.

Providers are stored as configuration (`oembed_providers.provider.{id}`), so they
export and deploy with `drush config:export`. You can also ship them in a module
or install profile's `config/install` directory.

## Create a provider bucket (a new media source)

Go to **Provider buckets** (`/admin/config/media/oembed-providers/buckets`) and
click **Add bucket**. A bucket has:

- **Label** and **machine name**.
- **Providers** — the set of provider *names* this bucket allows.
- **Description** — optional.

Each bucket is exposed as a **media source** named `oembed:{machine_name}`. Assign
that source to a media type (on the media type's settings) to restrict that type
to only the bucket's allowed providers. A couple of important notes:

- **Keep the machine name short — 14 characters or fewer** (a core limitation).
- Creating a bucket with the machine name **`video`** overrides core's default
  `oembed:video` (Remote video) source — do this deliberately, not by accident.

Buckets are configuration too, and they automatically add config dependencies on
the custom providers they reference.

## Security note

The module surfaces this warning in the UI, and it's worth repeating:
**disabling or removing a provider does not, on its own, stop Media from rendering
that provider's content** while the provider is still returned by the repository.
Treat which providers you allow (and which buckets a media type uses) as a
security and curation decision, not just a convenience.

## Permission

| Permission | Grants |
|------------|--------|
| **Administer oembed providers** | The settings form and full create/edit/delete access to custom providers and buckets. It covers everything — there is no separate permission for providers vs. buckets vs. settings. Marked security-sensitive. |

## Doing it from the command line

Settings, providers, and buckets are all configuration, so they deploy with `drush
config:export` / `config:import`. You can also set an option directly, e.g.:

```bash
drush cset oembed_providers.settings external_fetch false
```
