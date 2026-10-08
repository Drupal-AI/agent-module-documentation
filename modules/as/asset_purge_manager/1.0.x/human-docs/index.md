# Asset Purge Manager — manual setup guide

**Asset Purge Manager** (`asset_purge_manager`) helps you clean up **unused
assets** — files and media that nothing on the site references any more. Over
time an assets directory fills with orphaned uploads that no content points to;
this module identifies those and removes them, reclaiming storage and keeping the
files directory tidy.

You would use it as an occasional housekeeping tool, run by an administrator, to
find and purge files that are genuinely no longer needed. It provides its own
permission so that only privileged users can run a purge, and it ships in the
Content package. It has no dependencies beyond core and supports Drupal 9, 10,
and 11.

**Read this before you run it.** Purging assets is **destructive and
irreversible** — deleted files are gone. Whether an asset is "unused" is decided
by a scan, and a scan can be wrong: an asset that is referenced in a way the scan
doesn't detect (in custom code, a serialized field, an external system) can be
misjudged as unused and deleted, breaking content that depended on it. So treat
this as a careful, deliberate operation: **back up your files first, review what
the purge will remove before confirming, and grant its permission only to trusted
administrators.** The module has no access‑control role beyond that permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — review and run a purge safely.

## Where it lives in the admin menu

The purge tools are available to users who hold the module's purge permission.
Grant it (**People → Permissions**) only to trusted administrators, because it
controls the ability to permanently delete files. See
[Configuration](configuration/index.md) for how to run a purge without losing
something you needed.
