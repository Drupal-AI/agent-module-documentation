# ClamAV Anti-Virus — manual setup guide

**ClamAV Anti-Virus** (`clamav`) connects Drupal's file uploads to the
[ClamAV](https://www.clamav.net/) anti-virus scanner so that every file a visitor
or editor uploads is checked for viruses before it is stored. When someone attaches
a file to a node, a media item, a webform, or their user picture, the module runs
that file through ClamAV during Drupal's normal file-validation step. If ClamAV
reports an infection, the upload is blocked, the file is deleted, and the user sees
a clear error message.

The module does not run its own virus engine — it talks to a ClamAV installation
you provide. It can reach ClamAV in three ways: a ClamAV daemon over TCP/IP (the
default, pointing at `localhost:3310`), a ClamAV daemon over a Unix socket, or the
local `clamscan` command-line program. You pick the connection method and its
details on the settings form.

A few thoughtful touches round it out: you decide what happens when ClamAV is
temporarily unreachable (block the upload to be safe, or let it through), you can
limit which storage areas are scanned, verbose logging can record clean and skipped
files for auditing, and a Drush command can retroactively scan every file already
in your library. The Status Report page shows the connected ClamAV version so you
can confirm the link is live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (you also need a working ClamAV service).
2. [Configuration](configuration/index.md) — the settings form, field by field:
   scan mode, outage behavior, logging, and which storage areas to scan.

## Where it lives in the admin menu

Once enabled, the module's settings live at **Configuration → Media → ClamAV
Anti-Virus** (`/admin/config/media/clamav`). Access is gated by the
**Administer ClamAV** permission. Scanning itself happens automatically for every
upload — there is no per-user setting to turn it on.

## How to use it

Enable the module, make sure a ClamAV service is running and reachable, then open
the settings form and confirm the scan mode matches your setup (host and port for
the TCP/IP daemon, socket path for the Unix socket, or the `clamscan` path for
executable mode). Save, then visit **Reports → Status report** to check that Drupal
reports the connected ClamAV version. From that point on, uploads are scanned with
no further action needed. To check files that were uploaded before you turned the
module on, run `drush clamav:scan-files`.
