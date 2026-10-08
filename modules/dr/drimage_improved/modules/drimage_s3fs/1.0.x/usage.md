Drimage S3fs adapts Drimage's on-the-fly responsive image generation for image fields whose files are stored on Amazon S3 via the s3fs module.

---

The submodule provides a dedicated field formatter, `drimage_s3fs` ("Drimage S3 Formatter"), which extends the parent `DrImageFormatter` so drimage's dynamic image-style behaviour works when the source file lives in an `s3://` stream wrapper rather than local `public://`. A kernel `RequestEvent` subscriber (`DrimageS3Subscriber`, registered via `drimage_s3fs.services.yml` with the same arguments as the parent `drimage_improved.event_subscriber`) intercepts requests for drimage derivatives that do not yet exist on S3 and hands them to the shared `drimage_improved.manager` to generate/deliver, so first-request generation still works with remote storage. It ships its own JS/CSS library (`drimage_s3fs`) for the loader/placeholder behaviour. Requires both `s3fs` and `drimage_improved`. Use it instead of the standard "Dynamic Responsive Image" formatter on sites that offload image files to S3.

---

- Serve Drimage on-the-fly responsive images for files stored on Amazon S3.
- Use the `drimage_s3fs` field formatter on image fields backed by the s3fs stream wrapper.
- Generate a missing drimage derivative on first request even when originals live on S3.
- Keep drimage's zero-config responsive behaviour on S3-offloaded media sites.
- Handle the S3 "file not yet generated" case through a kernel request subscriber.
- Load the S3-specific placeholder/loader JS and CSS for drimage images.
- Combine remote object storage (s3fs) with automatic per-size image styles.
- Avoid pre-generating every image style for cloud-stored assets.
- Reuse the parent module's `drimage_improved.manager` to generate S3 derivatives on demand.
- Keep image-heavy pages fast while storing originals off the web server.
- Migrate a drimage site to S3 without losing responsive image behaviour.
- Deliver WebP and cropped derivatives for S3-hosted images (inherited from `DrImageFormatter`).
- Show a loader/placeholder while an S3 derivative is being generated.
- Support the same image-handling modes (scale, aspect-ratio, background, container, iwc) on S3.
- Serve responsive images from S3 without configuring responsive image styles by hand.
- Offload storage costs to Amazon S3 while retaining on-the-fly image sizing.
