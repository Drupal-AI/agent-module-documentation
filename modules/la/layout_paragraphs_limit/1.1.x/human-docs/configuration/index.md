# Configuration

All of this module's behavior is driven from one form. Until you add a rule,
every region accepts every Paragraph type just as it did before.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Layout Paragraphs Limit**, or
   navigate directly to `/admin/config/content/layout_paragraphs/limit`.

The form only lists the layouts that are actually used by one of your
layout‑enabled Paragraph types. If a layout isn't offered anywhere, it won't
appear here. Each layout is shown with one collapsible group per region — for
example a one‑column layout shows a single `content` region, while a two‑column
layout shows `top`, `first`, `second`, and `bottom`.

## The three controls in each region

For every region you get the same trio of settings:

### Include / exclude mode

A pair of radio buttons decides how the checklist below is interpreted:

- **Include the selected below** — only the Paragraph types you check are
  allowed in this region; everything else is hidden from the "add component"
  menu. Use this to whitelist a short, approved palette.
- **Exclude the selected below** *(default)* — the types you check are removed
  from the menu and everything else stays available. Use this to blacklist a
  few disruptive types while keeping the rest.

If you check nothing, the type filter does nothing at all — the mode only
matters once at least one type is checked.

### Paragraph types

A checkbox list of every Paragraph type available to the layout. Tick the types
the rule should apply to. In *include* mode the ticked types are the only ones
allowed; in *exclude* mode the ticked types are the ones removed.

### Limit total number of components

A numeric field that caps how many components the region will hold. Leave it at
**0** for no limit. When a region already contains that many components, the
"add component" menu offers nothing further until an editor removes one. This is
independent of the type filter, so you can combine "only Card and Callout" with
"at most three components" on the same region.

## Save

Click **Save configuration**. On save the module tidies up — unchecked types are
dropped from the stored value while your include/exclude choice and numeric cap
are kept. The rules take effect immediately: edit a piece of content and the
region's add‑component menu will reflect exactly what you allowed.

## How the rules are stored

Everything lives in the configuration object `layout_paragraphs_limit.settings`,
under `disallowed_types.<layout_id>.<region>`. Because it is plain config, you
can export it with `drush config:export` and deploy the same region rules across
your development, staging, and production environments. To inspect the current
value from the command line:

```bash
drush cget layout_paragraphs_limit.settings disallowed_types
```
