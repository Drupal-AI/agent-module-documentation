# Configuration

Advanced FileSystem is a suite, so "configuration" means enabling and setting up
the individual features you need rather than filling in one form. This page is an
orientation to the areas involved; work through only the ones relevant to your
site.

## Who can administer it

Access to the suite's administration is gated by the `administer advanced
filesystem` permission. Grant it on **People → Permissions**
(`/admin/people/permissions`) to trusted administrators only, since these
features touch file storage, external services, and security controls.

## Handle credentials as secrets

Several features connect to external services — S3, FTP, Google Cloud Storage,
Cloudflare R2, AI providers, ClamAV. **Never paste those credentials into
committed configuration.** Back them with environment variables (and, where the
integration supports it, a Key entity), following the site's secrets convention.
This keeps keys out of version control and out of exported config.

## Feature areas to configure

Enable and set up only what you need:

- **Path strategies** — choose how and where files are laid out on disk.
- **Migration & orphans** — batch-migrate existing files (use **dry-run** first)
  and detect files no longer referenced.
- **Lifecycle** — retention rules, deduplication (hash and perceptual), and quota
  enforcement.
- **Backup** — replicate files to S3, FTP, GCS, or R2 (needs credentials).
- **Metadata extraction** — pull EXIF, PDF, and audio/video metadata.
- **AI features** — transcription, alt-text generation, smart filenames, and
  embeddings (needs API access; review privacy implications of sending files to a
  provider).
- **Optimization & delivery** — image optimizer and CDN integration.
- **Security** — HMAC-signed URLs and ClamAV antivirus scanning.
- **Compliance** — LGPD/GDPR auditing.
- **Processors** — PDF, video, document, and presentation processors exposed as
  Media Source plugins, with Views integration for listing them.

## A safe rollout

Turn features on incrementally, verify each against your storage and services
before relying on it, and keep destructive operations (migration, dedup,
retention/cleanup) in dry-run or test mode until you have confirmed the results.
