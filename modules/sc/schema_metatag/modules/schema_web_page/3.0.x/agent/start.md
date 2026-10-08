# schema_web_page — agent start

Submodule of **schema_metatag**. Adds **Schema.org/WebPage** structured data as Metatag *Tag*
plugins in the `schema_web_page` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: @type (WebPage/ItemPage/AboutPage/CheckoutPage/ContactPage/CollectionPage/ProfilePage/SearchResultsPage), description, inLanguage, author, publisher, breadcrumb, hasPart, isAccessibleForFree, speakable, translationOfWork/workTranslation, @id.
- Use to classify page type, mark speakable content, and express paywall/multilingual relationships.
