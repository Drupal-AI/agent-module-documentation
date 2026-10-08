<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: Yandex Elements extends the Views RSS module with the Yandex/Dzen XML namespaces and the yandex:full-text, yandex:genre and yandex:enclosure item elements, plus an optional Yandex Turbo feed style.

---

Yandex/Dzen (formerly Yandex.News) requires syndication feeds to carry specific XML namespaces (xmlns:yandex and a Yahoo media namespace) and a handful of Yandex-only item elements. This module hooks into Views RSS to register those namespaces and elements so that, in the Views RSS "fields" style, you can map any Views field to yandex:full-text (full article text used by Yandex for indexing), yandex:genre (lenta/message/article/interview) and yandex:enclosure (multiple media enclosures per item). It also adds a companion Views style plugin, "Yandex RSS Feed - Fields", that exposes a per-feed "Enable yandex turbo" checkbox; when ticked, the feed advertises the xmlns:turbo namespace and renders the mapped full-text field inside a turbo:content block so the feed conforms to Yandex Turbo page requirements. The module ships only a display/output layer over Views RSS: no permissions, no routes, no services, and no admin settings form of its own — all mapping happens in the standard Views RSS feed settings.

---

- Build a Yandex/Dzen-compatible RSS feed from a View of published articles.
- Add the xmlns:yandex="http://news.yandex.ru" namespace to a Views RSS feed.
- Add the xmlns:media="http://search.yahoo.com/mrss/" namespace to a Views RSS feed.
- Map a node body/summary field to the yandex:full-text element for Yandex indexing.
- Classify each feed item with yandex:genre (lenta, message, article or interview).
- Emit several media enclosures per item via yandex:enclosure.
- Produce a Yandex Turbo feed by selecting the "Yandex RSS Feed - Fields" style and enabling turbo.
- Advertise the xmlns:turbo="http://turbo.yandex.ru" namespace on a Turbo feed.
- Wrap the full-text field in a turbo:content block for Yandex Turbo pages.
- Extend an existing Views RSS "fields" feed with Yandex-only elements without a code change.
- Syndicate site content to Dzen.News per its technical feed requirements.
- Provide the RFC 822 date format (installed with the module) for pubDate output.
- Combine the standard RSS core elements (title, link, description, pubDate) with Yandex elements in one feed.
- Preview and validate a Yandex feed at the View's feed path before submitting the URL to Yandex.
- Switch a single feed between a plain RSS feed and a Yandex Turbo feed via the per-feed toggle.
- Keep separate Views displays for a general RSS feed and a Yandex-specific feed on the same content.
- Serve full article HTML to Yandex Turbo while a shorter description stays in the standard feed.
- Use the module's help page (help.page.views_rss_yandex) to read the bundled README guidance.
- Restrict the source View to published, public content so only intended items reach Yandex.
