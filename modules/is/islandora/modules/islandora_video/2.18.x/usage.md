Islandora Video adds a video derivative-generation Action (transcoding via the Homarus/FFmpeg microservice) and an HTML5 video field formatter for Islandora repository objects.

---

The submodule provides the Context Action `generate_video_derivative` (extends Islandora Core's
`AbstractGenerateDerivative`), defaulting the `queue` to `islandora-connector-homarus` and the target
`mimetype` to `video/mp4`, so an ingested video master is transcoded (e.g. to MP4) by the Homarus/FFmpeg
microservice and the derivative PUT back as media/file. It also ships a field formatter `islandora_file_video`
(with `islandora-file-video.html.twig`) that renders a video media's file as an HTML5 `<video>` player. Wire
the Action into a Context whose Condition matches video objects; set the formatter on the video media's
display. Depends only on `islandora`. No config page, no permissions.

---

- Transcode an uploaded video master to a web-friendly MP4 service copy.
- Route video jobs to the Homarus/FFmpeg microservice via the `islandora-connector-homarus` queue.
- Generate a video derivative as a new media on the node (`generate_video_derivative`).
- Pass FFmpeg arguments to control codec/bitrate/resolution of the derivative.
- Play video media with the built-in HTML5 `islandora_file_video` formatter.
- Drive video derivative creation declaratively from a Context Derivative reaction.
- Choose the source media (by term) that is transcoded.
- Tag output with a derivative term (e.g. Service File).
- Store video derivatives in a chosen filesystem/scheme and path.
- Convert to a target `video/*` mimetype other than MP4 (e.g. `video/quicktime`).
- Keep heavy transcoding off the web server by delegating to a microservice.
- Regenerate video derivatives by re-running the Action.
- Provide accessible video playback in the repository UI.
- Support moving-image / film-archive collections with consistent access copies.
- Pair video derivatives with thumbnails and breadcrumbs for full object pages.
