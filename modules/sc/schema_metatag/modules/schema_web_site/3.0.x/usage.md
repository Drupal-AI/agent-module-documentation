Adds Schema.org/WebSite JSON-LD structured data via Metatag, describing the site itself and enabling the Sitelinks Search Box via potentialAction.

---

Schema.org WebSite is a Schema.org Metatag submodule that registers Metatag tag plugins for the `WebSite` type, typically configured on the global/front-page Metatag defaults. Enabling it adds a `Schema.org WebSite` group whose token-driven values render into the page's JSON-LD. It provides `name`, `url`, `inLanguage`, `publisher`, and a `potentialAction` property used to declare a `SearchAction` for Google's Sitelinks Search Box. It also includes `translationOfWork`/`workTranslation` tags for multilingual relationships and `@type`/`@id` for specialization and cross-referencing. Because it describes the whole site rather than a single node, it is usually set once on the site-wide defaults. It is the standard way to give search engines your canonical site name and to opt into the sitelinks search box feature.

---

- Declare the site as a `WebSite` entity on global Metatag defaults.
- Set the canonical site `name` for search engines.
- Provide the site `url`.
- Enable the Sitelinks Search Box via `potentialAction` (SearchAction).
- Point the search action at the site's search URL template.
- Set `inLanguage` for the primary site language.
- Associate a `publisher` (Organization) with the site.
- Give the WebSite a stable `@id` referenced by other entities.
- Set a custom `@type` where needed.
- Declare `translationOfWork` for a translated site.
- Declare `workTranslation` linking to translated versions.
- Provide a consistent site name across all SERP appearances.
- Reduce the chance Google guesses the wrong site name.
- Support multilingual site relationships in structured data.
- Cross-reference the WebSite from Organization markup.
- Configure once site-wide rather than per node.
- Improve branded search appearance.
- Feed knowledge-graph site identity data.
