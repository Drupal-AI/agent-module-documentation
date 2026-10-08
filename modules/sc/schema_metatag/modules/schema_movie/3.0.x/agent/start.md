# schema_movie — agent start

Submodule of [schema_metatag]. Adds Metatag groups for `@type` Movie / Series / Season / Episode
with Tag plugins for their properties (name, description, actor, director, producer, musicBy,
image, duration, dateCreated, releasedEvent, episodeNumber, seasonNumber, partOfSeason,
partOfSeries, hasPart, aggregateRating, sameAs, potentialAction, url, @id). Configure the tags
with tokens under the site's **Metatag** settings; values render as JSON-LD via schema_metatag.
No config UI of its own.
