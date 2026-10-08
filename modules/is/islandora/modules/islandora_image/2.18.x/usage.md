Islandora Image adds the derivative-generation Actions that turn a source image into service files and thumbnails, by emitting events to the Islandora image microservice (Houdini / ImageMagick).

---

The submodule provides two Context Actions that extend Islandora Core's abstract derivative actions:
`generate_image_derivative` (creates a **new media** on the node from the converted image) and
`generate_image_derivative_file` (attaches the converted **file** to an existing media). Both default the
`queue` to `islandora-connector-houdini` and the target `mimetype` to `image/jpeg`, and inherit all the
source-term / derivative-term / destination-media-type / path configuration from
`AbstractGenerateDerivative(MediaFile)`. `args` are passed as ImageMagick `convert` arguments (e.g.
`-resize 50%`). You wire these Actions into a Context whose Condition matches image objects (e.g.
`node_has_term` = Image), so that when an image is ingested the microservice fetches the source, converts it,
and PUTs the derivative back through Islandora's media-source REST route. Depends only on `islandora`. No
config page, no permissions of its own.

---

- Generate a JPEG service derivative from an uploaded TIFF/master image.
- Generate a thumbnail image derivative for repository objects.
- Attach a converted image file to an existing media with `generate_image_derivative_file`.
- Create a new derivative media entity on a node with `generate_image_derivative`.
- Route image conversion jobs to the Houdini/ImageMagick microservice via the `islandora-connector-houdini` queue.
- Resize images on ingest with ImageMagick `convert` args (e.g. `-resize 50%`).
- Convert masters to a web-friendly `image/jpeg` (or another target mimetype).
- Drive derivative creation declaratively from a Context Derivative reaction.
- Select which media (by source term) is the input for the derivative.
- Tag the output media/file with a derivative taxonomy term (e.g. Service File, Thumbnail).
- Store derivatives in a chosen filesystem/scheme and token-based path.
- Regenerate image derivatives by re-running the Action on existing content.
- Support multi-page/paged-content image derivatives as part of an Islandora model.
- Keep image-processing logic in a microservice instead of PHP/GD on the web server.
- Combine with IIIF to serve tiled access copies from generated service files.
