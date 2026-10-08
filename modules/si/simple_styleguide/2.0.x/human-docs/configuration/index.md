# Configuration

Simple Styleguide is configured in two places: a **settings form** (which built‑in
patterns appear, plus your colour palette) and a **patterns list** (your own custom
components). Together they decide what shows up on the `/simple-styleguide` page.

## The settings form

Go to **Configuration → Styleguide → Settings**
(`/admin/config/styleguide/settings`). You need the **Administer site configuration**
permission to open it.

### Default patterns

This is a list of checkboxes for the eleven built‑in HTML patterns:

- **Headings**, **Text**, **Lists**, **Blockquote**, **Rule** (horizontal rule),
  **Table**, **Alerts**, **Breadcrumbs**, **Forms**, **Buttons**, and
  **Pagination**.

Tick the ones you want the styleguide to display and untick the rest. Each ticked
pattern renders a representative example of that element on the styleguide page, using
your theme's real CSS — so you can see at a glance how your headings, buttons, tables,
and so on actually look.

### Colour palette

Below the checkboxes is a text area where you define your colour palette — **one
colour per line**, using pipe characters to separate three parts:

```
#hex|class|description
```

For example:

```
#FF0000|red|Primary error colour
#0B5FFF|brand-primary|Main brand blue
#F5F5F5|surface|Page background
```

- **#hex** — the colour's hex value (the page also derives and shows the RGB value).
- **class** — the CSS class name you use for that colour in your theme.
- **description** — a short note on when to use it.

On the styleguide page each line becomes a swatch showing the colour alongside its hex
value, RGB, class name, and description — a handy, always‑accurate palette reference.

Click **Save configuration** when you are done.

## Custom patterns

Beyond the eleven built‑ins you can add your own components — a card, a hero banner, a
call‑to‑action block, anything you can express as HTML. These are managed at
**Configuration → Styleguide → Patterns** (`/admin/config/styleguide/patterns`) and
require the **Administer style guide** permission.

### Add a pattern

1. On the patterns list, click **Add styleguide pattern**.
2. Fill in the form:
   - **Label** — the name shown for this pattern (and used to generate its machine
     name).
   - **Description** — a rich‑text note explaining what the component is and when to
     use it.
   - **Pattern** — the **raw HTML** for the component. This is rendered as‑is on the
     styleguide page, so it picks up your theme's styling.
3. Save. New patterns are added to the bottom of the list.

### Reorder and edit

The patterns list is **draggable** — grab a row's handle and drop it to change the
order in which patterns appear on the styleguide page. You can also **edit** or
**delete** any pattern from this list. Remember to save the order after dragging.

### They deploy like any other config

Because each custom pattern is a configuration entity, it is included in your
configuration exports (`drush config:export`) and moves between environments like the
rest of your site config — your component library travels with your codebase rather
than living in a separate tool.
