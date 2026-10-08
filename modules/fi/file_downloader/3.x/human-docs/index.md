# File Downloader — manual setup guide

**File Downloader** (`file_downloader`) is a field formatter for file and image
fields that can expose **one or more download links** per file. Where the older
File Download module offered a single download link, File Downloader turns
download options into a **plugin system**: each option you configure renders its
own link, so a single file can offer, say, a "High resolution" and a "Low
resolution" download side by side.

You set it up in two layers. First you create **Download Option Config** entities
— each one selects a plugin (for example *Original File* or *Image Style*) and
carries its own settings, such as which file extensions it applies to. Then, on a
file or image field's **Manage display**, you pick the **File downloader**
formatter and choose which of your Download Option Config entities to expose as
links.

The module gets file access right, which matters because it serves files through
its own controller route. Before a download proceeds it requires a per-option
permission (`use {id} download option link`), checks the file extension, and then
checks the file's own view access — so a user cannot download a private file they
could not otherwise view just by guessing its id. It depends on core's **File**
module and covers Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create Download Option Config
   entities, set the formatter on a field, and grant the per-option permissions.

## How to use it

The typical flow is: create a Download Option Config entity for each kind of
download you want to offer, set the **File downloader** formatter on your file or
image field's *Manage display*, tick the options to expose, and grant the
matching per-option permission to the roles who should be able to download. See
[Configuration](configuration/index.md) for the step-by-step.
