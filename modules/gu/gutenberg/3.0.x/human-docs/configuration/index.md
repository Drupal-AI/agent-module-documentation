# Configuration

Gutenberg has **no global settings page**. Instead, you switch it on for each
content type that should use the block editor, and optionally give that type a
starter template and a limited set of image styles. This page covers those choices
plus the text format and permissions behind them.

## Enable Gutenberg on a content type

1. Go to **Structure → Content types** and click **Edit** on the type you want to
   convert (`/admin/structure/types/manage/<type>`).
2. Tick the **Enable Gutenberg experience** checkbox.
3. Click **Save content type**.

From now on, adding or editing content of that type opens the full‑screen Gutenberg
block editor instead of the standard node form. To turn it back off, untick the box
and save.

For Gutenberg to work, the content type's body field must be a single‑value long‑text
field (a **Text (formatted, long)** or **Text (formatted, long, with summary)**
field) — the standard body field on most content types qualifies.

If you prefer the command line, the flag lives in the `gutenberg.settings`
configuration object, keyed by content type:

```bash
drush cget gutenberg.settings                              # see all enabled types
drush cset gutenberg.settings article_enable_full true -y  # enable on Article
drush cset gutenberg.settings article_enable_full false -y # disable on Article
```

## Per‑content‑type options

Alongside the enable flag, `gutenberg.settings` stores a few related keys per content
type that control the starting point and image handling:

- **Template** (`<type>_template`) — a Gutenberg block template (as JSON) used to
  prefill new content of that type, so editors start from a consistent structure.
- **Template lock** (`<type>_template_lock`) — how strictly the template is enforced:
  `all` prevents any structural change, `insert` prevents adding or removing blocks,
  or `false` for no lock. Use this to keep editors from restructuring a curated
  layout.
- **Allowed image styles** (`<type>_allowed_image_styles`) — restricts which image
  styles the editor offers for that content type.

## The text format and editor

Behind the per‑type toggle, Gutenberg ships two pieces of configuration you normally
do not need to touch:

- **Gutenberg Blocks text format** (`filter.format.gutenberg`) — the text format with
  the required Gutenberg filter that parses stored block markup and renders it. Its
  oEmbed provider patterns and maximum width live in this format's settings.
- **The Gutenberg editor** (`editor.editor.gutenberg`) — binds the block editor to
  that format, including image‑upload settings (uploads go to the public
  `inline-images` directory by default).

Both are installed and maintained by the module. There is also a **Gutenberg text**
field formatter you can use to render a Gutenberg‑formatted field elsewhere on the
site.

## Permissions recap

Three permissions at **People → Permissions** govern who can do what:

- **Use Gutenberg** — author content with the block editor (required for most
  editor actions).
- **Manage blocks lock** — manage block locking inside the editor.
- **Create and edit custom gutenberg content blocks** — create and edit custom
  non‑reusable content blocks inline.

Enabling Gutenberg on a content type itself uses the usual **Administer content
types** permission, not a Gutenberg‑specific one.

## Reusable blocks

Gutenberg lets editors save a block as a **reusable block** and drop it into other
content. Reusable blocks are stored as content blocks of the `reusable_block` type,
and you can organize them and patterns with the `pattern_categories` taxonomy
vocabulary that the module provides.
