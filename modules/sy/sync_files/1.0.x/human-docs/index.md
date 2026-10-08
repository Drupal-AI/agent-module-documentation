# Sync Files — manual setup guide

**Sync Files** (`sync_files`) is a small administration/devops tool that
**synchronizes files from a remote server** into your site's local file system.
It is built for the everyday scenario where you have cloned a site — or imported
a production database dump — for development, staging or backup, and now the
database references images, videos, documents and other media files that are not
actually present locally. Instead of waiting on a large file archive or console
access, you point Sync Files at the source site and click a button to pull the
files down.

The way it works is simple: it takes the file URLs stored in your target
database, swaps the domain for the source domain you configure, and fetches each
file over HTTP(S). That means the source site's files must be reachable from your
environment over HTTP or HTTPS. It is designed to remove a common bottleneck when
setting up a dev/stage/cloned environment, and it is equally useful for topping
up a partial or corrupted file archive.

Sync Files is run by privileged users and has no access-control role of its own.
Keep the security implications in mind: it connects to a **remote server using
credentials you configure** (store them securely and use a trusted source over an
encrypted channel), and the **files it imports come from elsewhere** — treat them
as external content, apply your normal file hygiene, and do not sync untrusted
files into an environment where they could be served unsanitized. It has no other
module dependencies and supports Drupal 8.8, 9, 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the source server and run a
   sync.

## How to use it

After enabling, open the Sync Files settings page, enter the address of the
source (for example production) server, and click the sync button to pull its
files into your local file system. See [Configuration](configuration/index.md)
for the details.
