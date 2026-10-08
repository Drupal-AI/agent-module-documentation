Adds Schema.org/WebPage JSON-LD structured data via Metatag, describing the current page (its type, breadcrumb, author, publisher, and speakable sections).

---

Schema.org WebPage is a Schema.org Metatag submodule that registers Metatag tag plugins for the `WebPage` type and its many specializations: ItemPage, AboutPage, CheckoutPage, ContactPage, CollectionPage, ProfilePage, and SearchResultsPage. Enabling it adds a `Schema.org WebPage` group to Metatag configuration where token-driven values render into the page's JSON-LD block. It covers `@type` (choose the page specialization), `description`, `inLanguage`, `author`, `publisher`, `breadcrumb`, `hasPart`, `isAccessibleForFree`, `speakable` (CSS selectors/paths for voice), and `translationOfWork`/`workTranslation` for multilingual relationships, plus `@id` for cross-referencing. Because values map from tokens, one configuration classifies whole bundles of pages. It is used to give each page an explicit type, connect it to breadcrumbs and publishers, mark speakable content for voice assistants, and express multilingual and paywall relationships.

---

- Classify a page with a specific `@type` (AboutPage, ContactPage, etc.).
- Mark a listing view as a `CollectionPage` or `SearchResultsPage`.
- Mark a user profile as a `ProfilePage`.
- Set the page `description` and `inLanguage`.
- Attach the page `author` (as a Person).
- Attach the `publisher` (as an Organization).
- Provide a `breadcrumb` for the page.
- Declare `hasPart` for nested WebPageElement content.
- Mark `speakable` sections for voice-assistant reading.
- Set `isAccessibleForFree` for paywall/free-content signalling.
- Declare `translationOfWork` for a translated page.
- Declare `workTranslation` linking to translations.
- Give the WebPage a stable `@id` for cross-referencing.
- Nest the WebPage inside other entity markup.
- Classify checkout/contact pages for e-commerce sites.
- Standardize page-type markup across bundles via tokens.
- Support voice search with speakable selectors.
- Express multilingual page relationships in structured data.
- Distinguish free vs paywalled articles.
- Improve overall structured-data coverage of the site.
