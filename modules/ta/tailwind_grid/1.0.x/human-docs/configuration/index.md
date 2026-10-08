# Configuration

Tailwind Grid is configured where you would expect a Views layout to be configured:
on the View itself. The module also provides a small settings configuration
(`tailwind_grid.settings`) for defaults, but day to day you work with it through the
Views UI.

## Apply the Tailwind Grid style to a View

1. Go to **Structure → Views** and edit (or create) a View.
2. In the display's **Format** section, click the current format and choose
   **Tailwind Grid**.
3. Open the format's **Settings**.

## Set the columns per breakpoint

The style is built around Tailwind's responsive grid, so you choose how many columns
the results should flow into **at each screen size** (breakpoint). Setting fewer
columns on small screens and more on larger ones gives you a grid that reflows
responsively — for example a single column on phones widening to several columns on
desktop — without writing any CSS yourself. The module translates your choices into
the matching Tailwind grid utility classes.

## Make sure Tailwind is available

Because the layout is expressed as Tailwind classes, those classes must exist in
your theme's compiled Tailwind CSS. If the grid does not visually take effect,
confirm your Tailwind build includes the grid/column classes the module emits (for
example that they are not being purged out of your production CSS).

## Save

Save the View. The results should now render in the responsive Tailwind grid you
configured.
