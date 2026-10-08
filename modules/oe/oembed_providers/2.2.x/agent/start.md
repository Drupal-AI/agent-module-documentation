# oembed_providers — agent start

Extends core Media's oEmbed support: define **custom oEmbed providers** and group them into
**buckets** that become new `oembed:{bucket}` media sources, so you can embed content from
providers core doesn't list. Works by decorating Media's `ProviderRepository`. Depends on core
`media`. Config UI: **Admin → Config → Media → oEmbed Providers**
(`/admin/config/media/oembed-providers`); settings route `oembed_providers.settings`. One
permission gates everything.

- Add custom providers, buckets, settings + how core Media picks them up → [configure/oembed_providers.md](configure/oembed_providers.md)
- Programmatic API: the ProviderRepository decorator, custom providers, the alter hook → [api/oembed_providers.md](api/oembed_providers.md)
- Permission → [permissions/oembed_providers.md](permissions/oembed_providers.md)
