<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phaxio — agent index

**Phaxio online-fax integration** (send + status callback). Version **1.2.3**. Core `^9||^10||^11`.

Status callback `/phaxio/status` fires `hook_phaxio_status` (base only fires a hook; mutates nothing). Secret env-backed.