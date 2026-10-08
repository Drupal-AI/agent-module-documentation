<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Portuguese NIF — agent index

A **Webform element that collects and validates a Portuguese NIF (tax ID)** (checksum/format rules). Depends on
`webform`. Version **1.0.1**. Core `^8||^9||^10||^11`.

Forms/validation — a NIF is **PII/fiscal data**: handle submissions per privacy obligations (validation is
local, no external call). No access role.
