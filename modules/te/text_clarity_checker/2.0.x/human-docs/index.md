# Text Clarity Checker — manual setup guide

**Text Clarity Checker** (`text_clarity_checker`) gives content editors
real-time feedback on the clarity and readability of what they are writing. It
was designed with occasional contributors in mind — people who come from a world
other than the web and may not know Drupal's content best practices — and gives
them a range of information about their content as they work, so they can improve
it before publishing.

Once installed, the module adds a **block** that you place in the theme of your
choice. The block reports on a node's content and can be scoped by content type
and by user role. The metrics it surfaces include:

- **Text length analysis** — how long the content is.
- **Estimated reading time** — roughly how long it will take a visitor to read.
- **Image count** — how many images are used, counting decorative and background
  images too.
- **Heading structure validation** — whether the heading structure and its depth
  are valid.
- **Real-time feedback** — immediate insights as the editor writes.

Administrators can also add **recommendations** to guide contributors — for
example a suggested number of images, of internal and external links, or of
subtitles — so the feedback nudges writers toward the site's editorial
standards. The maintainers describe the module as a prototype and welcome
suggestions for more metrics.

Text Clarity Checker runs on Drupal 11 (and tracks toward 12), needs no other
contrib modules or libraries, and requires no special setup beyond enabling it
and placing the block. It is purely an editor-facing authoring aid: it analyses
text to help writers and has no role in content access or permissions.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no central settings page — the module works through the block you place:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place the Text Clarity Checker block
   into a region of your chosen theme (typically an admin-facing region).
3. Configure the block to target the node types and roles you want, and add any
   recommendations you want contributors to aim for.

Editors then see the clarity metrics and recommendations while they work. No
additional configuration is required for basic functionality.
