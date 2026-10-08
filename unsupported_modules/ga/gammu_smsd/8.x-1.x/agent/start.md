<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gammu SMS Daemon — agent index

**Send/receive SMS via Gammu SMSD** (admin UI + HTTP send API). Version **8.x-1.2**. Core `^8.8..^11`.

**SECURITY (8.x-1.2):** `api/gammu/send` is `_access: TRUE` and checks `Authorization == gammu_token` with loose `==`; `gammu_token` is unset by default so `null==null` passes → anonymous SMS send (cost abuse). Set a strong token; admin routes gated by `administer gammu`.