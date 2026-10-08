# Advanced File Destination — manual setup guide

**Advanced File Destination** (`advanced_file_destination`) gives people uploading
files a choice of **where the file lands**, instead of every upload always going
to the field's single fixed target directory. With it enabled and permitted, a
user can pick a destination directory at upload time, create a new directory on
the fly, and — with the right permission — target private-file storage.

The feature is deliberately governed by several **fine-grained permissions**, one
each for accessing the feature, creating directories, reaching private-file
locations, and enabling or disabling it per context. Because letting users
influence where files are written is a path-handling concern — especially near
the private filesystem — grant the directory-creation and private-file
permissions only to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and assign the permissions.

## Where it lives in the admin menu

This module does not add a central settings form. Its behavior is controlled by
**permissions** on **People → Permissions** (`/admin/people/permissions`) and
appears as an extra destination control on file-upload fields for users who have
those permissions.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. On **People → Permissions**, grant the module's permissions to the roles that
   should have them:
   - `access advanced file destination` — use the feature at all.
   - a dedicated permission to **create new directories** during upload.
   - a separate permission to reach **private-file** locations.
   - a permission to **enable or disable** the feature per context.
3. As a permitted user, when you upload to a file field you can now choose the
   destination directory (and, if allowed, create one or target private storage)
   rather than being locked to the field's default path.

Keep the directory-creation and private-file permissions restricted to trusted
roles — unconstrained destination choice near private storage is the main risk to
manage here.
