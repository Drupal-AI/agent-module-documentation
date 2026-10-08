A tiny Sitemap submodule that integrates the Metatag module with the sitemap page, providing a metatag defaults configuration so you can set meta tags (title, description, canonical, etc.) specifically for the `/sitemap` page.

---

sitemap_metatag exists purely to connect the base Sitemap module with the contributed Metatag module. It ships a `metatag.metatag_defaults.sitemap.page` configuration object that registers the sitemap page as a metatag context, so the sitemap page gets its own row on Metatag's defaults admin screen. From there a site builder can override the meta title, description, canonical URL, robots directives, Open Graph, and any other tags Metatag supports for that single page — useful for controlling how the sitemap appears (or whether it is indexed) in search engines and social shares. It has no code of its own (no plugins, services, permissions, or schema) beyond that config, and depends on both `metatag` and `sitemap`. Enable it only when you want per-page meta-tag control over the sitemap page.

---

- Set a custom meta description for the `/sitemap` page.
- Override the page title tag on the sitemap page.
- Add a canonical URL meta tag to the sitemap.
- Apply `noindex`/`nofollow` robots directives to the sitemap page.
- Add Open Graph tags so the sitemap shares nicely on social media.
- Add Twitter Card tags for the sitemap page.
- Control how search engines display the sitemap in results.
- Prevent the human-readable sitemap from being indexed.
- Provide a keywords meta tag for the sitemap page.
- Manage sitemap-page metadata alongside other Metatag defaults.
- Keep sitemap meta tags exportable as configuration.
- Set a hreflang/alternate tag on the sitemap page.
- Give the sitemap page a distinct social share image.
- Override global metatag defaults just for the sitemap.
- Add author or publisher meta tags to the sitemap page.
- Standardize sitemap-page SEO across environments via config.
- Integrate sitemap metadata into an existing Metatag workflow.
