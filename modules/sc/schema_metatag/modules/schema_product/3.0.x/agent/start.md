# schema_product — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Product** structured data as Metatag *Tag*
plugins in the `schema_product` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, description, image, brand, category, url, sku, mpn, isbn, gtin8/12/13/14, offers (price/currency/availability), aggregateRating, review, @type, @id.
- Use for catalog/Commerce products to qualify for price and rating rich results.
