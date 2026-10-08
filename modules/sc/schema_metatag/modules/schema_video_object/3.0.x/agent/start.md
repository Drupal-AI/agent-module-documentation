# schema_video_object — agent start

Submodule of **schema_metatag**. Adds **Schema.org/VideoObject** structured data as Metatag *Tag*
plugins in the `schema_video_object` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, description, thumbnailUrl, uploadDate, duration, contentUrl, embedUrl, expires, transcript, interactionCount, aggregateRating, review, @type, @id.
- Use for hosted/embedded video to qualify for video rich results and video search.
