<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove Unused Files (remove_unused_files) — agent index

Flags managed files with **`file_usage` count 0**, moves them to **temporary** status → core deletes
them on a later cron (a soft-delete grace window). Version **2.1.0**. Core `>=10`.
Submodules `remove_unused_files_form`, `remove_unused_files_link`.

**DATA-LOSS WARNING: "zero file_usage" does NOT reliably mean "unused."** Usage tracking is only as
complete as every module registering it — WYSIWYG-embedded files, config-referenced files, and files
used by modules that never call `FileUsage::add()` show usage 0 while in use. Deleting them silently
breaks content. Dry-run first, verify against actual use, keep backups, be extra careful with WYSIWYG
embeds. The temporary-status soft-delete is a good safety margin — rely on it.