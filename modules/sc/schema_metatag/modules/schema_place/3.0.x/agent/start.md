# schema_place — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Place** structured data as Metatag *Tag*
plugins in the `schema_place` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, description, image, url, telephone, address (PostalAddress), geo (lat/long), @type.
- Use for venues, landmarks, and location pages; nest as an Event location.
