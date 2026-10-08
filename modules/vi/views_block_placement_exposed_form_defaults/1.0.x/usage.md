Views Block Placement Exposed Form Defaults lets you pick which of a Views block's exposed filters can be given default values when the block is placed, and then set those defaults per placement (in Block layout or Layout Builder).

---

The module swaps the core Views **Block** display plugin class for its own
`ExposedFormBlockDisplay` (via `hook_views_plugins_display_alter()`). In the Views UI, the block
display's **"Allow settings"** section gains a **"Customizable filters"** checkbox list of the
display's exposed filters; the chosen ones are saved on the display as the
`customizable_exposed_filters` option. When that block is then placed — through the normal Block
layout form or as a Layout Builder block — the block configuration form renders the exposed-filter
form elements for exactly those filters, so the site builder can enter **default values** for that
specific placement. Those values are stored on the block/views_block configuration as
`exposed_filter_values`, and at render time `preBlockBuild()` feeds them into the view via
`setExposedInput()`, so the block loads pre-filtered without the visitor having to submit the
exposed form. A `hook_config_schema_info_alter()` registers the two new keys
(`customizable_exposed_filters` on `views.display.block`, `exposed_filter_values` on `views_block`).
It has no admin page, permission, or config of its own and requires `views` and `block`.

---

- Place a "latest articles" views block that defaults to a specific content type.
- Show a products block pre-filtered to one category on a landing page.
- Reuse the same view block in several places, each defaulting to different filter values.
- Set a default status/published filter value when a block is placed.
- Pre-set an exposed taxonomy filter so a block shows one term by default.
- Give a Layout Builder views block sensible default filter values per section.
- Let editors choose default filter values without editing the view itself.
- Expose a filter to visitors but seed it with a default value on placement.
- Build multiple "curated list" blocks from one view by varying placement defaults.
- Default a date-range exposed filter to a preset range for a block.
- Provide region-specific defaults (e.g. sidebar block defaults differ from footer).
- Choose which exposed filters are customizable per block display (not all of them).
- Keep a single reusable view instead of cloning it per filter preset.
- Pre-filter a search-style view block placed on a campaign page.
- Set defaults for several exposed filters at once on one placement.
- Let a view block load already-filtered so visitors see relevant results immediately.
- Offer editors a simple placement form to tune block output.
- Combine with Layout Builder to compose pages of differently-filtered view blocks.
- Avoid custom preprocess/code to preset a views block's exposed input.
- Restrict which filters editors can override, hiding the rest from the placement form.
- Default an exposed "sort" or filter identifier for a block instance.
- Maintain consistent default filtering across many block placements of one view.
