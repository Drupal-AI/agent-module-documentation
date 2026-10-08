Adds `hreflang` alternate-language `<link>` tags, with logic to emit one per available translation plus an `x-default`.

---

On multilingual sites, `hreflang` link tags tell search engines which URL serves each language/region so the right version ranks for the right audience. This submodule adds those tags to Metatag with extra automation: rather than configuring each language by hand, it can emit a `hreflang` link per available language for the current entity, plus an `x-default` fallback. Depends on the main Metatag module and works with Drupal's multilingual system. Essential for SEO on translated sites.

---

- Emit a `hreflang` link for every available translation of a page.
- Provide an `x-default` hreflang for the fallback language.
- Prevent duplicate-content penalties across language versions.
- Help Google serve the right language to the right user.
- Auto-generate per-language alternates without manual entry.
- Support region-specific targeting (e.g. en-US vs. en-GB) via language config.
- Set hreflang behavior globally as a Metatag default.
- Keep hreflang links in sync as translations are added.
- Improve international SEO rankings.
- Reduce manual maintenance of language links.
- Work alongside canonical tags for correct indexing.
- Handle the current entity's translations automatically.
- Export hreflang configuration as config.
- Standardize hreflang across a multilingual multisite.
- Signal language equivalence to Bing and Yandex too.
- Avoid mis-served translations in search results.
