<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preview Site provides preview site functionality.

---

Preview Site generates a **shareable static preview of the site** — building a static snapshot (via Tome
Static) of selected content that can be deployed somewhere (it ships a `preview_site_s3` submodule for S3), so
stakeholders can review unpublished/in-progress content on a standalone preview without touching production. It
depends on Tome Static, Entity Usage, Dynamic Entity Reference and core File/Link/Datetime/Options, provides
its own permissions, in its package.

Use it to share static previews of draft content. It is a content-workflow/deployment feature. Security notes:
a preview may contain **unpublished/draft content**, so the **preview destination must be protected** (a public
S3 bucket would expose drafts — restrict access to the preview), and the deploy target's **credentials** (e.g.
S3 keys) must be stored as **secrets** (env/Key). Its permissions gate who can generate previews. Configure the
preview build and destination.

---

- Generate a static site preview.
- Build a snapshot via Tome Static.
- Share drafts with stakeholders.
- Deploy previews (S3 submodule).
- Depend on Tome Static/Entity Usage.
- Provide its own permissions.
- PROTECT the preview destination (drafts inside).
- Avoid a public bucket exposing drafts.
- Store deploy credentials (S3 keys) as secrets.
- Gate who can generate previews.
- Not touch production.
- Configure the build and destination.
- Handle site previews.
- Build previews.
- Configure the preview.
- Deploy snapshots.
- Handle the deployment.
- Share previews.
- Secure the destination.
- Provide static previews.
