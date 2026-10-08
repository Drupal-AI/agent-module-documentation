# Configuration

Configuring Region in Content is two things: telling the module **which regions**
to make available inside nodes, and **printing** them in your node template.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Region in Content**, or navigate
   directly to `/admin/config/user-interface/regionincontent`.

## List the regions to expose

The form has a single field: a **textarea** where you enter the **machine names of
the theme regions** you want available inside node content — one per line.

- Use the region *machine names* as declared by your active theme (for example
  `secondary_menu`, `sidebar_first`), not their human-readable labels.
- Only regions your active theme actually declares take effect: the module
  intersects your list with the theme's real regions, so a typo or a region from a
  different theme is simply ignored.
- The rendered regions become available for the **full** view mode.

Click **Save configuration** when done.

## Print the region in your node template

Listing a region makes it available as a Twig variable on the node whose name
matches the region's machine name. Print it in your theme's full-node template
(`node--full.html.twig`) wherever you want it to appear among the node's fields.
For example, to show a secondary menu region:

```twig
{% if secondary_menu|render %}
  {{ secondary_menu }}
{% endif %}
```

Wrapping it in `{% if ... |render %}` avoids printing an empty wrapper when the
region has no visible blocks.

## Remember: blocks keep their own access

The blocks that appear in-content are the ones you placed in that region at
**Structure → Block layout**, and their **visibility and access rules still
apply**. Region in Content only decides which regions become available inside the
node — it does not override who may see a given block. To change what shows up,
adjust the block placement and visibility, or edit the region list here.
