# schema_article — agent start

Submodule of [schema_metatag]. Adds a Metatag group `schema_article` (`@type` Article /
BlogPosting / SocialMediaPosting / Report / ScholarlyArticle / TechArticle / APIReference) with
one Tag plugin per Article property (headline, description, image, author, publisher,
datePublished, dateModified, mainEntityOfPage, aggregateRating, review, speakable, about,
hasPart, isAccessibleForFree, name, @id). Configure the tags with tokens under the site's
**Metatag** settings; values render as JSON-LD via schema_metatag. No config UI of its own.
