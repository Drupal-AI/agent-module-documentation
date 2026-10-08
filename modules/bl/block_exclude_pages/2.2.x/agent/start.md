<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_exclude_pages — agent start

Extends the core block-visibility **Pages** condition (`request_path`) with `!`-prefixed
**exclude** patterns, so you can carve exceptions out of a `*` wildcard (e.g. show on
`/user/*` but not `/user/jc`). It applies to **every** block automatically — there is no
per-block toggle, no config UI of its own, no permissions, no drush, no config schema.
Edit a block's **Pages** setting in the normal Block layout UI
(**Admin → Structure → Block layout**, route `block.admin_display`) or in the block config
entity's `visibility.request_path.pages`.

- The exclude syntax and how include/exclude resolve → [configure/exclude-syntax.md](configure/exclude-syntax.md)
- The mechanism (which class replaces `request_path`, the `evaluate()` XOR) → [plugins/request-path-override.md](plugins/request-path-override.md)
- Setting a block's Pages visibility from PHP / config → [api/set-visibility.md](api/set-visibility.md)
