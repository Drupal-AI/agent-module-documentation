# Link Field Entity Filter — manual setup guide

**Link Field Entity Filter** (`link_field_entity_filter`) lets you restrict which
**content types** a core **Link** field is allowed to point to, across the site.
When a link field is set up to link to internal content, this module narrows the
valid targets to the content types you choose — guiding editors toward the right
destinations and keeping links pointed at the kinds of content you intend.

Note that the project is distributed under the Composer package name
**`drupal/link_field_filter`**, even though the module's machine name is
`link_field_entity_filter` — this matters when you install it (see Installation). It
builds on core **Link** and adds no content of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (note
   the package name) and enable it.

This module does not add a top‑level settings page in the admin menu. You apply the
content‑type restriction where the Link field's behavior is configured, described in
"How to use it" below.

## How to use it

1. Go to the **Link** field you want to restrict — a link field on a content type,
   taxonomy vocabulary, or other bundle.
2. In the field's settings, use the content‑type restriction this module adds to
   limit which content types the link may target.
3. Save. Editors filling in that link field are now guided to the allowed content
   types only.
