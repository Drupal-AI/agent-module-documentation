# schema_image_object — agent start

Submodule of [schema_metatag]. Adds a Metatag group `schema_image_object` (`@type` ImageObject)
with Tag plugins for ImageObject properties (contentUrl, url, name, description, width, height,
aggregateRating, review, @id). Configure the tags with tokens under the site's **Metatag**
settings; values render as JSON-LD via schema_metatag. No config UI of its own.
