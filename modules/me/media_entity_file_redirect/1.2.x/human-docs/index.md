# Media Entity File Redirect — manual setup guide

**Media Entity File Redirect** (`media_entity_file_redirect`) gives file-based
media entities a clean, stable download URL. It adds a `/document/{id}` path that
302-redirects to the actual file behind a media entity — so instead of linking to
a raw path like `/sites/default/files/report.pdf`, you link to `/document/42`. The
media id never changes, so the link keeps working even if you later replace the
file on that media entity.

This is handy for documents and downloads you distribute by print or email, for
"download" buttons that should point at a memorable URL, and for keeping ugly file
paths out of your links. Access to the redirect respects the media entity's own
**view** permission, and for private files the actual download still passes through
Drupal's normal file-access checks. The redirect target always comes from the
file's own stored URI — never from anything in the request — so there is no
open-redirect risk.

The feature is **off by default** and turned on per media type with a single
checkbox on the media type's edit form. The module also ships optional
[Linkit](https://www.drupal.org/project/linkit) integration so editors can pick the
`/document/{id}` path directly from the CKEditor link dialog.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Media must be present).
2. [Configuration](configuration/index.md) — turn the redirect on per media type
   and, optionally, set up the Linkit integration.

## Where it lives in the admin menu

There is no settings page of the module's own. You enable the feature on each media
type at **Structure → Media types → *(a file-based type)* → Edit**
(`/admin/structure/media/manage/<type>`). The optional Linkit setup lives at
**Configuration → Content authoring → Linkit profiles**.
