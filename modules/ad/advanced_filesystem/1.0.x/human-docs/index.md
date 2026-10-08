# Advanced FileSystem — manual setup guide

**Advanced FileSystem** (`advanced_filesystem`) is a broad, enterprise-grade
file-management suite for Drupal. Rather than doing one thing, it bundles a large
set of capabilities around how your site stores, processes, protects, and serves
files.

Among the things it offers: pluggable **path strategies** for where files live;
batch **migration** of existing files (with a dry-run mode) and **orphan
detection**; **retention/lifecycle** rules, **deduplication** (both exact-hash and
perceptual), and **quota** enforcement; **backup** to external stores such as S3,
FTP, Google Cloud Storage, and Cloudflare R2; **metadata extraction** from images,
PDFs, audio and video; **AI** features such as transcription, alt-text
generation, smart filenames, and embeddings; an **image optimizer** and **CDN**
integration; **HMAC-signed URLs**; **ClamAV antivirus** scanning; **LGPD/GDPR**
auditing; webhooks; and enterprise document/video/PDF/presentation **processors**
exposed as Media Source plugins with Views integration.

Because that surface is so wide — external storage, AI services, antivirus,
signed URLs — treat installation as a deliberate, feature-by-feature rollout
rather than turning everything on at once. Store every integration's credentials
securely (backed by environment variables, not committed config), and enable only
the features you actually need and have reviewed. Administration is gated by the
`administer advanced filesystem` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the areas you configure, the
   `administer advanced filesystem` permission, and handling credentials safely.

## Where it lives in the admin menu

Administration is controlled by the `administer advanced filesystem` permission
(set on **People → Permissions**), and the suite's features are configured from
its own administration screens. See [Configuration](configuration/index.md) for
the areas to work through.
