<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suppress Logs — agent index

Suppresses configured (unneeded) **log messages** (decorates `logger.factory` → drops them to a null logger,
reducing noise). Config at `suppress_logs.settings_form`; provides permissions. Version **1.0.1**. Core
`^9.2||^10||^11`.

**CAUTION:** suppressing logs can **hide security-relevant events** (failed logins, access-denied,
exceptions — key for detection/forensics). Be **selective** — suppress only genuine noise, **never broadly
suppress security/error/audit channels**; keep the config tight/reviewed. No access role.
