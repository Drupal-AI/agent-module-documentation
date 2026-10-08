<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User term node access — agent index

**Node access by user taxonomy term** via node-access grants (authoritative). Version **1.0.0-alpha2**. Core `^9||^10||^11`.

Uses hook_node_grants/records — filters listings/Views/search/canonical (not form-only). Perm `administer user term node access`; rebuild node access after config changes. Depends on core `node`, `taxonomy`.