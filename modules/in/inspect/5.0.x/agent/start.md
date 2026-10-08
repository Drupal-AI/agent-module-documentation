<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inspect — agent index

A developer tool for **inspecting variables and stack traces** (richer than `var_dump`; admin gated by
`administer site configuration`). Version **5.0.1**. Core `^9||^10||^11`.

Developer/debug — dumps can reveal **sensitive runtime data** and internals; keep to **trusted admins/devs**,
prefer not enabling on production. No access role beyond the admin gate.
