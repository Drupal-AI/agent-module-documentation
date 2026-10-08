# Configuration

EBT Core has one site-wide settings form. The values here are the **defaults**
EBT block types fall back to — the brand colors, responsive breakpoints, and
named container widths that keep every EBT block consistent. Individual blocks
can still override much of this through their own EBT Settings design field.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Extra Block Types (EBT)
   settings**, or navigate directly to `/admin/config/content/ebt-core`.

The form is grouped into Colors, Breakpoints, and Width sections, and it edits
the single `ebt_core.settings` configuration object.

## Colors

- **Primary color** and **Secondary color** — your two main brand colors, used
  as defaults across EBT blocks. Shipped empty, so set them to match your theme.
- **Primary button text color** and **Secondary button text color** — the text
  colors EBT buttons use on the primary and secondary backgrounds. Also empty by
  default.
- **Background color** — the default block background color. This one ships set
  to **`#0d77b5`** (a mid blue). If you clear it and save, the form falls back to
  `#0d77b5` rather than storing an empty value.

All color fields are validated as hex values (for example `#223344`), and the
design field's color picker uses these as starting points.

## Breakpoints

Three responsive breakpoints, in pixels, passed to the EBT JavaScript so blocks
know when to switch between mobile, tablet, and desktop behavior:

- **Mobile breakpoint** — default **640**.
- **Tablet breakpoint** — default **1020**.
- **Desktop breakpoint** — default **1320**.

The form requires all three values to be **different** from one another; it will
refuse to save if two match.

## Width

Seven named container widths, in pixels, that EBT layout blocks offer when you
constrain a block to a fixed width instead of making it edge-to-edge:

| Setting | Default (px) |
|---------|--------------|
| xxSmall width | 480 |
| xSmall width | 640 |
| Small width | 768 |
| Default width | 960 |
| Large width | 1100 |
| xLarge width | 1320 |
| xxLarge width | 1600 |

As with the breakpoints, the seven width values must all be **different** from
each other, or the form will not save.

## Save

Click **Save configuration**. The new defaults apply the next time EBT blocks are
rendered. If you prefer to script it, the same values can be read and written
with Drush, for example:

```bash
drush cget ebt_core.settings                          # dump all values
drush cset ebt_core.settings ebt_core_background_color '#223344' -y
drush cset ebt_core.settings ebt_core_mobile_breakpoint '600' -y
```

Note that direct `drush cset` writes bypass the form's "all different" validation
rules, so take care to keep the breakpoint and width values distinct yourself.
