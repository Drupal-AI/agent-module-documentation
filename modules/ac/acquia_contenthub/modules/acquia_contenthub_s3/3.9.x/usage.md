DEPRECATED (experimental) submodule that integrated s3fs-backed files with Acquia Content Hub, mapping S3 file entities (bucket + root folder + origin) so they syndicate without repeated location discovery.

---

It hooks file insert/delete to record/remove entries in an S3 file map (`S3FileMap`), decorates
the s3fs stream wrapper, and adds a file-scheme handler and dependency collector so files
stored on `s3://` export/import correctly across sites. It depends on `s3fs` (pinned to a dev
release), `file`, `system`, and `acquia_contenthub`. The project marks it **deprecated**
(`lifecycle: deprecated`) — do not adopt it for new sites; prefer the base module's standard
file scheme handlers and current Acquia Content Hub file guidance.

---

- (Deprecated — retained for existing sites only) Syndicate `s3://` files across Content Hub sites.
