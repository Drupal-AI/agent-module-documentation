# Configuration

Enhanced Button Link has one global settings form that does two jobs: it defines
the **list of button styles** editors can pick from, and it decides which button
options editors are allowed to **override per link**. Everything else — the default
style for a given field — is set on that field's formatter (see the
[overview](../index.md)).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Enhanced Button Link**, or navigate
   directly to `/admin/config/content/enhanced-button-link`.

## Button link styles

This is the curated list of Bootstrap button classes editors and site builders can
choose from. You edit it as one entry per line, in the form:

```
class|Label
```

For example:

```
btn-primary|Primary
btn-secondary|Secondary
btn-outline-dark|Outline dark
```

The left side is the CSS class that gets added to the button (alongside the base
`btn` class); the right side is the friendly label shown in the select lists. The
defaults cover the standard Bootstrap button types, including the `btn-outline-*`
variants. To add your own, define the CSS class in your theme and add a matching
`class|Label` line here.

Each entry is validated when you save: the class must be a valid CSS identifier and
the label must be safe to display. If a value would change when sanitized, the form
rejects it with an error — so you can't accidentally introduce unsafe markup.

## Override toggles

Four checkboxes decide whether editors can change a button's properties on an
individual link, rather than being locked to the formatter's default:

- **Override type** *(on by default)* — let editors choose a different button style
  (`btn-*` class) per link.
- **Override size** *(on by default)* — let editors choose a different size (normal,
  large, or small) per link.
- **Override status** *(off by default)* — let editors mark a specific link as
  disabled or enabled.
- **Override target** *(on by default)* — let editors choose same‑window or new‑tab
  per link.

Whichever of these you switch on appear as extra selects inside a **Button Link
Options** area on the field widget. If you leave all four off, editors just get the
plain Link field, and every button uses the formatter's fixed settings. Turn them
on when you want editors to have flexibility; leave them off to keep buttons
perfectly consistent across the site.

## Save

Click **Save configuration**. Your changes take effect immediately — the module
clears its cached button rendering so updated styles and toggles show up on the
next page view.
