<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skpr Key — agent index

A **Key module provider that reads secrets from Skpr (hosting platform) config** (keep secrets out of DB/config).
Depends on `key`. Version **2.0.0-beta2**. Core `^9||^10||^11`.

**Security-positive** secret handling — sources credentials from the platform secret store via the Key
abstraction (not in exported config/VCS). Credential source; no access role.
