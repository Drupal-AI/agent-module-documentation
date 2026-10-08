<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TacJS Domain — agent index

Configures **per-domain tarteaucitron.js (TacJS) consent services** on Domain-module multi-domain sites (each
domain gets its own consent-managed service set). Depends on `domain`, `tacjs`. Version **3.0.0-alpha2**. Core
`^10||^11`.

Privacy/consent config layer — actual gating done by **TacJS** (this scopes it per domain); effectiveness
depends on TacJS gating third-party scripts. No access role.
