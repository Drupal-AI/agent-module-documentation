Islandora Audio adds an audio derivative-generation Action (transcoding via the Homarus/FFmpeg microservice) and an HTML5 audio field formatter for Islandora repository objects.

---

The submodule provides the Context Action `generate_audio_derivative` (extends Islandora Core's
`AbstractGenerateDerivative`), defaulting the `queue` to `islandora-connector-homarus` and the target
`mimetype` to `audio/mpeg`, so an ingested audio master is transcoded (e.g. to MP3) by the Homarus/FFmpeg
microservice and the result PUT back as a derivative media/file. It also ships a field formatter
`islandora_file_audio` (with an `audio.js` library and `islandora-file-audio.html.twig` template) that renders
an audio media's file as an HTML5 `<audio>` player. Wire the Action into a Context whose Condition matches
audio objects; set the formatter on the audio media's display. Depends only on `islandora`. No config page,
no permissions.

---

- Transcode an uploaded audio master to a web-friendly MP3 service copy.
- Route audio jobs to the Homarus/FFmpeg microservice via the `islandora-connector-homarus` queue.
- Generate an audio derivative as a new media on the node (`generate_audio_derivative`).
- Pass FFmpeg arguments to control bitrate/format of the derivative.
- Play audio media with the built-in HTML5 `islandora_file_audio` formatter.
- Drive audio derivative creation declaratively from a Context Derivative reaction.
- Choose the source media (by term) that is transcoded.
- Tag output with a derivative term (e.g. Service File).
- Store audio derivatives in a chosen filesystem/scheme and path.
- Convert to a target `audio/*` mimetype other than MP3.
- Keep transcoding off the web server by delegating to a microservice.
- Regenerate audio derivatives by re-running the Action.
- Provide accessible audio playback in the repository UI.
- Combine audio derivatives with breadcrumbs/IIIF for full object pages.
- Support oral-history / sound-archive collections with consistent access copies.
