# Configuration

Duplicate Node works as soon as it's enabled and the permission is granted — the
settings form simply lets you shape *how* duplicates are created.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Duplicate Node Settings**.

## Settings

- **Title prefix** — text that is automatically prepended to a duplicated node's
  title, so clones are easy to spot in content lists. A common choice is something
  like `Copy of ` (which turns *About us* into *Copy of About us*). Leave it empty
  if you'd rather the duplicate keep the original title unchanged.
- **Layout Builder duplication** — enable or disable copying of the node's Layout
  Builder configuration, including any custom (inline) blocks placed within the
  layout. Turn this **on** when you want clones to reproduce the full page
  structure; turn it **off** if you only want the field values copied and prefer the
  clone to fall back to the default display.
- **Other duplication behavior** — additional options for adjusting how duplication
  behaves to suit your site. Review each one on the form and set it to match how you
  want clones produced.

## Save

Click **Save configuration**. The new settings apply to the next duplication — open
a node, click its **Duplicate** tab, and the clone is created according to these
choices.
