# schema_review — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Review** structured data as Metatag *Tag*
plugins in the `schema_review` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: itemReviewed, reviewRating, author, datePublished, name, reviewBody, @type, @id.
- Use for editorial/first-party reviews; nest inside Product, Service, or Organization.
