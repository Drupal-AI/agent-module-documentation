<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extended Path Aliases — agent index

Extends path aliases to cover **entity task tabs** (e.g. `about-us/edit` for `node/123/edit`) and
allows **alias wildcards** in page specifications (`about-us*` for block visibility). Depends on core
`path`; config at `path_alias_xt.settings_form`; provides permissions. Version **2.x** (dev). Core
`^10||^11`.

Routing/URL feature — aliases the tab URL; **does not change access** (tabs still governed by
permissions).
