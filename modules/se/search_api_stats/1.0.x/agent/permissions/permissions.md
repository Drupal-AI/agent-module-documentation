<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `search_api_stats.permissions.yml`:

| Machine name | Title | Gates |
|---|---|---|
| `access all views` | access search api stats | Intended to gate the search-stats report Views/pages. |

Caveat worth knowing: the permission's **machine name** in the YAML is literally
`access all views` (the human title is "access search api stats"). `access all views` is also
a core Views permission, so this declaration effectively re-declares that permission's title.
When you build your own stats View, you can gate its display with **"access search api stats"**
(this permission) or any other permission you prefer - the module does not enforce it itself;
recording happens for everyone. Nothing here grants a capability beyond viewing reports.
