# Drimage S3fs — agent index

Adapts Drimage's on-the-fly responsive images for image files stored on Amazon S3 (s3fs).
No settings page, no permissions, no config schema, no Drush. Requires `s3fs` + `drimage_improved`.

Key facts:
- Field formatter `drimage_s3fs` ("Drimage S3 Formatter", image fields) extends the parent
  `DrImageFormatter` (`src/Plugin/Field/FieldFormatter/DrimageS3fsFormatter.php`). Use it in place
  of "Dynamic Responsive Image" on s3fs-backed fields.
- Kernel `RequestEvent` subscriber `DrimageS3Subscriber`
  (`src/EventSubscriber/DrimageS3Subscriber.php`, service `drimage_s3fs.event_subscriber`) catches
  requests for not-yet-generated S3 derivatives and delegates to `drimage_improved.manager` to
  generate/deliver.
- Ships library `drimage_s3fs` (loader JS/CSS).
- Global drimage settings and the on-the-fly route are the parent module's — see
  [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).
