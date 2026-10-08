# DOI Field — manual setup guide

**DOI Field** (`doi_field`) adds a new field type for storing a **DOI** (Digital
Object Identifier) — the persistent identifier used to reference scholarly
publications and datasets. Once the field type is available, you can add a "DOI
Field" to any content type (or other fieldable entity), enter a DOI when
authoring, and have the site display information about the corresponding
publication.

What makes this more than a plain text field is that it works together with the
**DOI Publications** module (`doi_search`), which it depends on and which Composer
installs automatically. When a DOI field is displayed, the module can look up and
show selected elements of the matching publication's metadata. On the field's
display settings you choose which of those elements to render, so you control how
much of the publication's information appears on the page.

This is a content-editing feature: the DOI you enter is authored data, and the
field has no role in controlling access to content. It is aimed at academic,
library and research sites that need to attach structured publication references
to their content. (Note: the module's own documentation mentions that a caching
layer to avoid repeated lookups may be added in future, depending on demand.)

The field type is available as soon as the module is enabled — the real setup is
adding the field to a content type through Drupal's normal Field UI, described
below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which also
   pulls in DOI Publications) and enable the module.

There is **no module settings form** — DOI Field is configured per field through
Drupal's Field UI, as described in "How to use it" below.

## Where it lives in the admin menu

DOI Field does not add an admin settings page of its own. You use it from
**Structure → Content types → *(your type)* → Manage fields** when adding a field,
and from **Manage display** when choosing how the DOI's publication details are
shown.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields**
   and click **Add field**.
2. Choose the **DOI Field** field type and give it a label.
3. Save the field settings. The field is now available on that content type.
4. On **Manage display**, configure the DOI field's formatter to select which
   elements of the corresponding publication should be shown when content is
   viewed.
5. When authoring content, enter the DOI into the field. On display, the site
   shows the selected publication information for that DOI.
