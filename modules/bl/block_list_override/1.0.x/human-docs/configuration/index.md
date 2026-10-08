# Configuration

All of Block List Override's behavior comes from its settings form. With the
pattern fields empty, nothing is filtered — you switch it on by adding rules.

## Open the settings form

1. Log in as a user with the **Access block list override** permission (an
   administrator by default) — this is the permission the module adds for its
   settings.
2. Go to **Configuration → System → Block List Override Settings**, or navigate
   directly to `/admin/config/block_list_override/settings`.

Note that **saving the form flushes all caches**, since the block lists are cached.

## Describe which blocks to target

You identify block plugins with three textareas — put **one entry per line** in
each. A block counts as "matched" if it satisfies *any* of them:

- **Match** — an exact block plugin id. For example `system_powered_by_block`
  targets just the "Powered by Drupal" block.
- **Prefix** — a colon-prefix; matches any id that starts with `<prefix>:`. For
  example `field_block` matches every `field_block:…` block in one line.
- **Regex** — a regular-expression pattern (include the delimiters). For example
  `/field_block:node:(.*):nid/` matches all node-nid field blocks.

## Choose the action

The **Action** setting decides what happens to the matched blocks:

- **Remove** (the default) — the matched blocks are dropped from the list and
  everything else stays.
- **Allow only** — the list is restricted to *only* the matched blocks; everything
  not matched is hidden. Use this to enforce a small, curated palette.

## The two lists (and a version quirk)

Block List Override filters two places:

- The **site-wide block list** — the theme's *Place block* screen and anywhere
  blocks are chosen. Removing a block here makes it disappear from all block UIs.
- The **Layout Builder** "Add block" chooser.

Each list has its own **Action** toggle, so you can, say, *Remove* certain blocks
site-wide but *Allow only* a set within Layout Builder. **However, in this version
(1.0.x) the same Match / Prefix / Regex patterns govern both lists** — the
Layout-Builder-specific pattern fields are saved but not actually used by the
filtering. In practice: write your patterns once, and only the Remove/Allow-only
action can differ between the two lists.

Blocks already placed inside a Layout Builder section are **always kept**, so your
existing layouts won't break. Regular *placed* blocks (block config entities) are
**not** exempt, though — removing a block that's actually placed somewhere produces
"non-existent block" warnings.

## Preview before you rely on it

Two preview pages show exactly which blocks survive your current rules:

- **System list** — `/admin/config/block_list_override/system-list`
- **Layout Builder list** — `/admin/config/block_list_override/layout-list`

Check these after saving, especially before removing anything, to make sure you
haven't accidentally hidden a block that's in use.

## Save

Click **Save configuration**. Because the form flushes caches on save, the block
lists reflect your rules immediately.
