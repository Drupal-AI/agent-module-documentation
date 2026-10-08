# Configure custom providers, buckets & settings

All UI lives under `/admin/config/media/oembed-providers` and is gated by the
`administer oembed providers` permission.

| Route | Path | Purpose |
|---|---|---|
| `oembed_providers.settings` | `/` | Global settings form (the `configure` route) |
| `entity.oembed_provider.collection` | `/custom-providers` | List custom providers |
| `entity.oembed_provider.add_form` | `/custom-providers/add` | Add a custom provider |
| `entity.oembed_provider.edit_form` | `/custom-providers/{oembed_provider}/edit` | Edit |
| `entity.oembed_provider.delete_form` | `/custom-providers/{oembed_provider}/delete` | Delete |
| `entity.oembed_provider_bucket.collection` | `/buckets` | List provider buckets |
| `entity.oembed_provider_bucket.add_form` | `/buckets/add` | Add a bucket |
| `entity.oembed_provider_bucket.edit_form` | `/buckets/{oembed_provider_bucket}/edit` | Edit |
| `entity.oembed_provider_bucket.delete_form` | `/buckets/{oembed_provider_bucket}/delete` | Delete |

## Global settings — `oembed_providers.settings`

Config object with one key. The URL lives in core's `media.settings`, not here — the settings
form edits both.

| Key | Config object | Default | Meaning |
|---|---|---|---|
| `external_fetch` | `oembed_providers.settings` | `true` | Fetch the remote providers list. If `false`, only locally-defined providers are used. |
| `oembed_providers_url` | `media.settings` | `https://oembed.com/providers.json` | URL Media fetches the providers list from. |

The form also has a **Clear Provider Cache** button: the provider list is cached in KeyValue
storage (`keyvalue('media')->get('oembed_providers')`), so a normal cache clear won't refresh it.
`drush cset oembed_providers.settings external_fetch false` works too.

## Add a custom oEmbed provider (`oembed_provider` config entity)

Config prefix `provider` → config name `oembed_providers.provider.{id}`. Exported keys:
`id`, `label`, `provider_url`, `endpoints`. Each endpoint has `schemes` (array of URL patterns
with `*` wildcards), `url` (endpoint URL — may contain `{format}`, replaced with `json`),
`discovery` (bool), and `formats` (`{json: bool, xml: bool}`). A provider must **either** support
discovery **or** declare at least one format. The **Provider name** (`label`) must match the
`provider_name` the endpoint returns (core bug #3134433). Example `config/install` file:

```yaml
# oembed_providers.provider.example_provider.yml
id: example_provider
label: 'Example Provider'
provider_url: 'https://example.com'
endpoints:
  - schemes:
      - 'https://example.com/media/*'
    url: 'https://example.com/oembed/{format}'
    discovery: true
    formats:
      json: true
      xml: false
```

## Provider buckets → new media sources (`oembed_provider_bucket` config entity)

Config prefix `bucket` → `oembed_providers.bucket.{id}`. Exported keys: `id`, `label`,
`providers` (array of allowed **provider names**), `description`. A bucket is exposed as a media
source with machine name **`oembed:{bucket_id}`** via `hook_media_source_info_alter()`. Assign
that source to a Media type to restrict it to only the bucket's allowed providers (intersected
with providers that actually exist in the repository).

- Machine name should be **≤ 14 characters** (core bug #3276845).
- Create a bucket with machine name **`video`** to override core's default `oembed:video`
  (Remote video) source.
- Saving a bucket clears cached media source definitions; saving a provider clears the KeyValue
  provider store.

## How core Media picks these up

The module decorates `media.oembed.provider_repository` with `ProviderRepositoryDecorator`. Its
`getAll()` merges custom providers (from `getCustomProviders()`) into the fetched list (custom
first, then the remote list — remote definitions can't be overridden), sorts by name, fires
`hook_oembed_providers_alter()`, and caches the result in KeyValue. When `external_fetch` is off,
only custom providers are returned. A `Plugin/media/Source/OEmbed` subclass (same `oembed` id as
core, higher module weight) adds bucket config dependencies.

## Security note (shown in the UI)

Disabling/removing a provider does **not** stop Media rendering its content while the provider is
still returned by the repository. This warning renders on the bucket form and on oEmbed media
type edit forms (`Helper::disabledProviderSecurityWarning()`).
