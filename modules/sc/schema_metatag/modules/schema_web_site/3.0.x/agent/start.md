# schema_web_site — agent start

Submodule of **schema_metatag**. Adds **Schema.org/WebSite** structured data as Metatag *Tag*
plugins in the `schema_web_site` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, url, inLanguage, publisher, potentialAction (SearchAction → Sitelinks Search Box), translationOfWork/workTranslation, @type, @id.
- Configure once on site-wide Metatag defaults; sets canonical site name and enables the sitelinks search box.
