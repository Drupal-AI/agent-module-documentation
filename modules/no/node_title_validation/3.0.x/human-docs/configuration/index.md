# Configuration

All of Node Title Validation's rules are set on one form, with a separate section
for each content type. A content type with no rules filled in is simply left
unchecked, so you only configure the types you care about.

## Open the settings form

1. Log in as a user who has the **Node title validation admin control** permission
   (see [Installation](../installation/index.md)).
2. Go to **Configuration → Content authoring → Node Title Validation**, or navigate
   directly to `/admin/config/content/node-title-validation`.

The form renders one fieldset per content type (Article, Basic page, and so on).
Fill in the rules under whichever types you want to constrain.

## The rules (per content type)

For each content type you can set any combination of:

- **Minimum length** (`min`) — the fewest characters a title may have, for example
  10. Leave blank (or 0) to disable.
- **Maximum length** (`max`) — the most characters a title may have. Handy for
  keeping titles under an SEO-friendly budget, well below the 255-character node
  limit.
- **Minimum word count** (`min-wc`) — the fewest words a title must contain, for
  example 3, to stop one-word titles.
- **Maximum word count** (`max-wc`) — the most words a title may contain, to keep
  headlines short.
- **Excluded characters/words** (`exclude`) — a comma-separated blocklist. A
  **single character** entry (like `!`, `@`, `#`) is blocked anywhere in the
  title; a **multi-character** entry (like `spam`) is blocked when it appears as a
  whole word. Use this for forbidden punctuation, marketing buzzwords, or
  profanity.
- **Block comma** (`comma`) — a dedicated toggle that also forbids the comma
  character in titles, even if you did not list it in the blocklist above.
- **Unique** (`unique`) — when ticked, a title is rejected if another node **of the
  same content type** already uses it. This prevents accidental duplicate pages or
  events. The violation message links to the existing node.

The form checks that your minimum is not greater than your maximum (for both
character length and word count) before it will save.

A single title is validated against every rule you set for its type at once, so if
a title is both too short and contains a blocked word, the editor sees both
messages together.

## Save

Click **Save configuration**. The rules take effect immediately — the validator
reads the configuration live on every node save, so there is no cache to clear.
Because validation runs as an entity constraint, the rules also apply to nodes
created by migration, JSON:API, REST, or programmatic saves, not just the node
edit form.

## A note on the global "unique" checkbox

The form has a top-level **"Unique node title for all content types"** checkbox.
Be aware of a quirk: this global toggle is saved but **not actually enforced** —
the uniqueness check always compares against other nodes of the *same* content
type. To require unique titles, tick the **per-content-type** Unique option on each
type you care about rather than relying on the global checkbox. This is documented
in more detail in the [`agent/`](../agent/start.md) docs.
