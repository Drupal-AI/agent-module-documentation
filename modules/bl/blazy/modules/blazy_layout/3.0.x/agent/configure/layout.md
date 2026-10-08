# Blazy dynamic layout

Defined in `blazy_layout.layouts.yml`:
- Layout id: `blazy_layout` (label "Blazy dynamic layout", category "Blazy").
- Class: `Drupal\blazy_layout\Plugin\Layout\BlazyLayout`.
- Library: `blazy_layout/layout`.
- Default region: `blzyr_0`.
- Regions: `blzyr_0` Main, `blzyr_1` Feature, `blzyr_2` Sidetop, `blzyr_3` Sidebar,
  `blzyr_4` Sidebelow, `blzyr_5`/`blzyr_6` Footer middle first/last, `blzyr_7`/`blzyr_8`
  Footer first/last.

Use it:
1. Enable Layout Builder for an entity view display (or a Layout Builder landing page).
2. **Add section → Blazy dynamic layout**.
3. In the section config form (`Drupal\blazy_layout\Form\BlazyLayoutAdmin`) set column count,
   region widths, gaps, and breakpoints dynamically — one layout covers many arrangements.
4. Place blocks/fields into the `blzyr_*` regions.

Services: `blazy_layout` (`BlazyLayoutManager`, extends `blazy.manager`) does the grid math;
`blazy_layout.admin` (extends `blazy.admin.base`) builds the settings form. Defaults live in
`src/BlazyLayoutDefault.php`.
