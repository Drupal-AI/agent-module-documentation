<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Roles and Permission Builder — agent index

**Builds roles and permissions from YAML files** (declarative access setup). Version **1.0.2**. Core `^10||^11`.

Access-configuration/deployment — the YAML files are effectively **security policy** (they grant permissions to
roles): control who edits them, review every change (a line can grant `administer users`/`administer permissions`),
keep them under code review. Treat like sensitive access config.
