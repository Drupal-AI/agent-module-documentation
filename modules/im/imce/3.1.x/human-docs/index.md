# IMCE — manual setup guide

**IMCE** (`imce`) is a web-based, server-side **file manager** for Drupal. It gives
users a JavaScript file browser where they can **browse, upload, delete, resize
and organize files** that live on the server, arranged in per-role and per-user
folders. Instead of re-uploading the same image over and over, editors open the
IMCE browser and pick a file that is already there. IMCE plugs into the
**CKEditor 5** link and image dialogs, into **BUEditor**, and into **file/image
field widgets**, so the same browser is available wherever a file needs to be
selected.

Who can open the browser, which folders they see, what file types and sizes they
may upload, and which operations (upload, delete, resize, create subfolders) they
are allowed to perform are all controlled by **configuration profiles**. A profile
is a reusable bundle of these rules, and you assign profiles to **user roles** —
separately for each file system (public and private) — from the module's settings
page. This guide is written for a **human** clicking through the admin UI, with
numbered steps and screenshots. If you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The IMCE File Manager settings page: configuration profiles and the role-to-profile assignment table](images/profiles.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Media → IMCE File Manager**
(`/admin/config/media/imce`). That page has three tabs:

- **IMCE Settings** (`/admin/config/media/imce`) — the list of configuration
  profiles and the role-to-profile assignment table. This is where you do almost
  all of your setup.
- **IMCE Help** — the module's built-in help screen.
- **IMCE File Browser** — opens the file browser itself so an administrator can try
  it out.

## Contents

1. [Installation](installation/index.md) — install IMCE with Composer and enable it.
2. [Configuration](configuration/index.md) — create configuration profiles, assign
   them to roles per file system, and wire IMCE into CKEditor and file fields.
