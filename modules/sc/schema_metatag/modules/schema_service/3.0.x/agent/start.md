# schema_service — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Service** structured data as Metatag *Tag*
plugins in the `schema_service` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, description, image, brand/provider, offers, aggregateRating, review, @type, @id.
- Use for agency/professional service pages and service catalogs.
