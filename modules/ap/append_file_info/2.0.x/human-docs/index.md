# Append File Info — manual setup guide

**Append File Info** (`append_file_info`) automatically appends the **file
extension and size** to links that point at local managed files. Instead of a bare
"Annual report" download link, visitors see something like "Annual report (PDF,
1.2 MB)" — a small touch that improves the clarity and accessibility of file
links, so people know what they are about to download and how big it is.

The information comes straight from the managed file's own metadata, so there is
nothing to maintain: the module reads the file's type and size and adds them to the
link text. It works on links to **local managed files** and affects only how those
links render — it changes no content and has no access-control role.

There is nothing to configure. Enable the module and the file-info annotation
starts appearing on qualifying links.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Just enable the module — there is no settings form. Links that point at local
managed files will automatically gain their extension and size in the displayed
text (for example "Report (PDF, 1.2 MB)"). Because the module only affects link
rendering and reads existing file metadata, there is nothing further to set up.
