External Hreflang adds a Metatag field for declaring `rel="alternate" hreflang` links that point at **external** sites (other domains), for cases where the alternate-language version of a page lives outside this Drupal install.

---

The module extends Metatag rather than adding its own UI. It defines a single Metatag tag plugin, `hreflang_external` ("External Hreflang", group *advanced*, `multiple = TRUE`), that appears as a textarea on every Metatag configuration form — global defaults, per-entity-type/bundle defaults, and per-entity overrides. You enter one alternate per line in `langcode|url` syntax, e.g. `en-US|https://us.example.com` / `es-ES|https://es.example.com`; the plugin's `output()` parses the textarea (`getHrefLangsArrayFromString()`) and emits one `<link rel="alternate" hreflang="…" href="…">` per line into the page head. Values are stored wherever Metatag stores tags — i.e. in the `metatag_defaults` config entities (keyed `global`, `front`, `node`, `node__article`, …) under `tags.hreflang_external`, or on an entity's metatag field. Because the field content supports tokens (e.g. `[current-page:url:relative:en]`), you can build the external URL from the current path. The module also implements `hook_simple_sitemap_links_alter()` so that, when the Simple XML Sitemap module is present, the same external hreflang alternates are added to sitemap entries. It requires the Metatag module and has no configuration page, permissions, services (beyond a current-URL event subscriber) or Drush of its own.

---

- Declare a US English page whose alternate lives on a separate `us.example.com` domain.
- Point `hreflang` at a partner/affiliate site that hosts the localized version of a page.
- Add cross-domain `rel="alternate" hreflang` links Google can use for language/region targeting.
- Set external hreflang alternates as **global** defaults for the whole site.
- Set external hreflang alternates per content type (e.g. only Articles) via Metatag bundle defaults.
- Override external hreflang alternates on a single node via its Metatag field.
- Provide multiple alternates at once (one `langcode|url` per line).
- Use language/region codes like `en-US`, `es-ES`, `fr-CA` for precise targeting.
- Build the alternate URL dynamically with tokens such as `[current-page:url:relative:en]`.
- Add external hreflang links to XML sitemap entries when Simple XML Sitemap is installed.
- Keep hreflang management inside the familiar Metatag admin screens.
- Emit standards-compliant `<link rel="alternate" hreflang="…" href="…">` head tags.
- Handle sites split across multiple country domains sharing content.
- Complement Drupal's built-in per-language hreflang (which only covers on-site languages).
- Signal an alternate on a marketing microsite hosted outside Drupal.
- Validate the `langcode|url` syntax on save (invalid lines are rejected).
- Manage SEO hreflang for a headless/multi-front-end setup where languages live on other apps.
- Roll the same external hreflang defaults across an entire multilingual section.
