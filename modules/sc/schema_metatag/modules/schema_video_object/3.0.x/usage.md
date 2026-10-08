Adds Schema.org/VideoObject JSON-LD structured data via Metatag, describing a video (thumbnail, duration, upload date, embed URL) for video rich results.

---

Schema.org Video Object is a Schema.org Metatag submodule that registers Metatag tag plugins for the `VideoObject` type. Enabling it adds a `Schema.org VideoObject` group to Metatag configuration where token-driven values render into the page's JSON-LD block. It covers the properties Google needs for video rich results and video indexing: `name`, `description`, `thumbnailUrl`, `uploadDate`, `duration` (ISO‑8601), `contentUrl`, `embedUrl`, `expires`, `transcript`, `interactionCount` (view count), plus `aggregateRating` and `review`. The `@type` and `@id` tags allow specialization and cross-referencing so the video can be nested in an Article or Recipe. Because values map from tokens, one configuration covers every video node or media entity. It is the standard way to make hosted or embedded video content eligible for video rich results and Google video search.

---

- Mark up a video node or media entity as a `VideoObject`.
- Set the video `name` and `description`.
- Provide a `thumbnailUrl` for the video preview.
- Record the `uploadDate`.
- Specify `duration` as an ISO‑8601 value.
- Provide the `contentUrl` to the raw video file.
- Provide the `embedUrl` for the player.
- Set an `expires` date for time-limited video.
- Include a `transcript` of the video.
- Report `interactionCount` (view count).
- Add `aggregateRating` for the video.
- Include individual `review` markup.
- Set `@type` and a stable `@id`.
- Nest the VideoObject inside an Article or Recipe.
- Qualify content for video rich results and video search.
- Standardize video markup across all media nodes via tokens.
- Surface duration and thumbnail in search results.
- Feed Google video indexing with structured metadata.
- Keep video structured data synced with media fields.
- Improve discoverability of a video library.
