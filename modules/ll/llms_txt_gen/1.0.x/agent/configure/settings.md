<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring included content types

Route: `llms_txt_gen.settings` → `/admin/config/search/llms-txt-gen` (permission `administer llms_txt_gen`).

Config object `llms_txt_gen.settings`:
- `bundles_default` (int) — `0` = "Only those selected", `1` = "All except those selected".
- `selected_bundles` (array) — the node bundles checked in the form.

Behaviour: if `selected_bundles` is empty, **all** content types are included regardless of mode. Otherwise the generator applies `type IN (...)` (mode 0) or `type NOT IN (...)` (mode 1).

Output: each section's content uses the auto-created `llms_txt_raw` text format and contains lines like `- [Node title](https://site/node/1.md)`. Node titles are escaped (`\`, `[`, `]`) and every node is access-checked against an anonymous session before inclusion, since `/llms.txt` is served publicly.
