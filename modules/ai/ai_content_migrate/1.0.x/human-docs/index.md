# AI Content Migrate — manual setup guide

**AI Content Migrate** (`ai_content_migrate`) automates the hardest part of moving
a legacy site into Drupal: working out the content model. It uses **AI agents** to
look at source HTML, infer a content model from it, and then import the content —
along with the images and media it references — into Drupal nodes and media
entities. Instead of hand-building content types and copy-pasting article by
article, you point it at legacy HTML and let the agents map it into entity fields.

It can fetch the source HTML directly from a URL and download referenced assets as
part of the import, creating media entities for images and files it finds. This
makes migrating a body of legacy pages far less manual.

The importer fetches the source HTML and downloads referenced assets from the
server, so point it only at sources you control and content you intend to import.
Access is gated by the `administer ai content migrate` permission, which should
stay with trusted administrators. The module depends on core Node, Media, and
the AI Agents module, and works on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm AI Agents and a provider are in place.

## How to use it

The whole workflow sits behind the **`administer ai content migrate`** permission,
so grant it only to trusted administrators running the migration. You provide a
source (a trusted URL or HTML), the AI agents infer a content model, and the
module imports the content into nodes while creating media entities for referenced
images and files. Review the inferred model and the imported content before
treating the migration as final, and keep in mind that the AI agent work is billed
through your configured provider.
