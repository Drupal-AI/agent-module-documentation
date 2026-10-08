oEmbed Providers lets site builders and developers add custom oEmbed providers to core Media (beyond the YouTube/Vimeo core lists) and group providers into "buckets" that become their own media sources, so you can embed video/content from providers core doesn't ship.

---

Core Media fetches a list of oEmbed providers from `https://oembed.com/providers.json` and hard-limits its built-in "Remote video" source to YouTube and Vimeo. This module decorates Media's `ProviderRepository` (`ProviderRepositoryDecorator`) so that custom providers you define through the admin UI are merged into the list Media uses. Two config entities do the work: an **oEmbed provider** (`oembed_provider`, config prefix `provider`) records a provider name, provider URL, and one or more endpoints (schemes, endpoint URL, discovery flag, JSON/XML formats); an **oEmbed provider bucket** (`oembed_provider_bucket`, config prefix `bucket`) groups a chosen set of allowed providers and is exposed as a new media source with the machine name `oembed:{bucket_id}` via `hook_media_source_info_alter()`, so each media type can be restricted to just the providers its bucket allows. A settings form at `/admin/config/media/oembed-providers` controls whether the external providers list is fetched at all (`external_fetch`) and lets you change Media's providers URL, plus clear the KeyValue-cached provider list. All functionality is gated by one permission, `administer oembed providers`. A security note is surfaced in the UI: disabling a provider does not stop Media rendering its content if the provider is still returned by the repository, and creating a bucket with machine name `video` overrides core's default `oembed:video` source. Developers can also alter the merged provider list programmatically with `hook_oembed_providers_alter()`.

---

- Add a custom oEmbed provider (name + provider URL + endpoint) that core Media does not list.
- Embed content from a niche or self-hosted oEmbed provider (e.g. a university media hub).
- Define an endpoint that supports discovery, or explicitly declare JSON/XML formats.
- Use `{format}` in an endpoint URL and have Media substitute `json` at fetch time.
- Group several providers into a bucket exposed as a new `oembed:{bucket}` media source.
- Restrict which providers a given media type accepts by pointing it at a specific bucket.
- Override core's default `oembed:video` source by creating a bucket with machine name `video`.
- Create a "remote image" media source from an oEmbed image provider.
- Turn off external fetching (`external_fetch`) so only your locally defined providers are used.
- Point Media at a mirror or alternate providers list by changing the oEmbed Providers URL.
- Run an air-gapped/offline site that relies solely on custom, locally-defined providers.
- Clear the KeyValue-cached provider list from the settings form when a provider changes.
- Store provider and bucket definitions as configuration so they deploy between environments.
- Ship providers/buckets in an install profile or module via `config/install/*.yml`.
- Limit a media type to a single trusted provider for security/curation.
- Programmatically add or modify providers with `hook_oembed_providers_alter()`.
- Add multiple endpoints to one provider for different URL scheme patterns.
- Give editors a Media Library "Add" tab scoped to a custom provider bucket.
- Review the security warning about disabled providers still rendering embedded content.
- Manage custom providers at `/admin/config/media/oembed-providers/custom-providers`.
- Manage provider buckets at `/admin/config/media/oembed-providers/buckets`.
- Gate all provider/bucket administration behind the `administer oembed providers` permission.
- Keep provider names matching the endpoint's `provider_name` value (core requirement).
- Fall back gracefully to stale provider data when the remote providers list is unavailable.
- Add config dependencies so buckets/media sources track the custom providers they use.
