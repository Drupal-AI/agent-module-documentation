# Configuration

There are three things you can do here: adjust **global settings** (whether to
fetch the remote provider list and from where), add **custom providers**, and
create **buckets** that turn a chosen set of providers into a media source. All of
it is under **Configuration → Media → oEmbed Providers**
(`/admin/config/media/oembed-providers`) and requires the **Administer oEmbed
providers** permission.

## Global settings

On the main settings form:

- **Fetch remote provider list** (`external_fetch`, default **on**) — whether
  Drupal fetches the master list of providers from the internet. Turn this **off**
  if you want to use *only* your own custom providers and never call out to an
  external service.
- **Providers URL** (default `https://oembed.com/providers.json`) — the URL the
  provider list is fetched from. This value actually lives in core's
  `media.settings`, but this form edits it for you. Point it at a mirror or a
  custom list if you need to.
- **Clear Provider Cache** button — the provider list is cached in key-value
  storage, so an ordinary cache clear won't refresh it. Use this button after
  changing providers or when you want to pull a fresh remote list.

## Add a custom oEmbed provider

Go to **Custom providers → Add** (`/custom-providers/add`). Each provider is a
configuration entity, so it exports with `drush config:export`. You'll enter:

- **Provider name** — the human label. **This must exactly match** the
  `provider_name` that the provider's endpoint returns, due to a core limitation.
- **Provider URL** — the provider's website.
- **Endpoints** — one or more endpoints, each with:
  - **Schemes** — URL patterns the provider handles, with `*` wildcards
    (e.g. `https://example.com/media/*`).
  - **Endpoint URL** — the oEmbed endpoint (may contain `{format}`, which is
    replaced with `json`).
  - **Discovery** — whether the provider supports oEmbed discovery.
  - **Formats** — JSON and/or XML.

A provider must either support discovery or declare at least one format.

## Create a provider bucket (a new media source)

Go to **Buckets → Add** (`/buckets/add`). A **bucket** groups a set of allowed
providers and is exposed as a **media source** named `oembed:{bucket_id}`. You
assign that source to a media type to restrict it to only the providers in the
bucket. Enter:

- **Label** and **machine name** — keep the machine name **14 characters or fewer**
  (a core bug affects longer names). Tip: name a bucket **`video`** to override
  core's default Remote video (`oembed:video`) source.
- **Providers** — the list of allowed **provider names** for this bucket.
- **Description** — optional.

Once saved, create (or reconfigure) a media type and choose your bucket's media
source. Remember core Media does **not** let you change the source of an existing
media type, so decide on your buckets before building media types around them.

## Security note

Be aware of a warning the module surfaces on oEmbed media type edit forms:
**disabling or removing a provider does not stop Media from rendering that
provider's already-embedded content** while the provider is still returned by the
repository. Treat provider removal as a configuration change, not as a way to
retroactively block content that's already been embedded.

## Save

Save each form as you go. After changes to providers, use **Clear Provider Cache**
so the new provider list is picked up (a normal cache rebuild is not enough for
the cached provider list).
