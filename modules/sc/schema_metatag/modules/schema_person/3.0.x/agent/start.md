# schema_person — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Person** structured data as Metatag *Tag*
plugins in the `schema_person` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, givenName/familyName/additionalName/alternateName, email, telephone, address, contactPoint, image, description, jobTitle, gender, birthDate, url, sameAs, affiliation/memberOf/worksFor, brand, @type, @id.
- Use for author profiles, staff pages, and public-figure entities; reference the @id as an Article/Review author.
