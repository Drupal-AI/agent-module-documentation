# Configuration

Go to **Configuration → Content authoring → GovNL Table of contents**
(`/admin/config/content/govnl-toc`). You need the **Administer GovNL Table of
contents** permission (`administer govnl_cms_toc`) — an administrator has it by
default. These settings are the site‑wide defaults for how the table of contents
is built; block placement itself happens separately under Block layout.

## Heading levels

Choose which heading levels the module scans when building the table of contents.
The available range is **H2 to H6**. Most sites scan H2 and H3 (and perhaps H4)
so the table of contents reflects the main sections and sub‑sections without
drowning in deeply nested minor headings. Include lower levels only if your
content genuinely uses them for navigation.

## Minimum threshold

Set the **minimum number of headings** required before a table of contents is
rendered at all. This keeps short pages tidy — if a page has fewer qualifying
headings than the threshold, no table of contents is shown. Raise it if you only
want a table of contents on substantial, multi‑section pages; lower it (to 1 or 2)
if even short pages should get one.

## Skip‑selectors

Provide **CSS selectors** for elements whose headings should be **excluded** from
scanning. This is how you stop the table of contents from picking up headings that
are not part of the main article — for example headings inside a related‑links
box, a callout component, or a comment section. The module also supports a set of
**default skip‑selectors** configured centrally here, so selectors you always want
excluded are applied everywhere without repeating them.

## Save

Save the form. The settings apply wherever the Table of contents block is placed.
If you don't see the change on a page, clear the render cache (or trigger a cache
rebuild) so the block re‑scans the content.
