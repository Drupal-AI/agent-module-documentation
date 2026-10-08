<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview Site — agent index

Generates a **shareable static preview of the site** (Tome Static snapshot; `preview_site_s3` submodule for
S3) for stakeholder review of draft content. Depends on `tome_static`, `entity_usage`,
`dynamic_entity_reference`, core `file`/`link`. Provides permissions. Version **1.2.0**. Core `^10.3||^11`.

Content-workflow/deployment — previews contain **unpublished/draft content**: **protect the destination** (a
public S3 bucket would expose drafts), store deploy **credentials as secrets**. Permissions gate generation.
