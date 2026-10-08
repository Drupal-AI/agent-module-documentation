# Configuration

Setting up Classy Paragraphs is two jobs: **(1)** build your catalog of styles, and **(2)**
add a field to a Paragraph type so editors can pick one.

## 1. Create your styles

1. Go to **Structure → Classy paragraphs style**
   (`/admin/structure/classy_paragraphs_style`). This is the list of all styles; it starts
   empty.
2. Click **Add classy paragraphs style**.
3. Fill in:
   - **Label** — a human‑friendly name editors will see, e.g. *Loud background* or *Primary
     button*.
   - **Classes** — the CSS class(es) this style applies, **one per line**. For example:

     ```
     loud-background
     text-uppercase
     ```

     Both classes will be added together whenever an editor selects this style. Put several
     classes on one style when they always go together (e.g. `btn btn-primary` — you can put
     them on one line separated by a space, or split them across lines).
4. Save. Repeat to build up your menu of approved styles.

These styles are configuration, so they export with `drush config:export` and deploy to other
environments like any other config.

## 2. Add the class‑picker field to a Paragraph type

The picker is an ordinary **entity reference** field that targets your styles.

1. Go to **Structure → Paragraph types**, edit the Paragraph type you want to style, and open
   **Manage fields**.
2. Click **Add field** and choose **Reference → Other…** (an entity reference field). For the
   **type of item to reference**, choose **Classy paragraphs style**.
3. Give the field a label (e.g. *Style*). Set **Allowed number of values** to **Unlimited** if
   you want editors to be able to stack several styles on one paragraph; otherwise leave it at
   1.
4. On the field settings, you can leave the default reference handler, or choose the
   **Classy paragraphs** handler if you want this particular field to offer only a *subset* of
   your styles (for example only your `btn_*` styles) or a specific option order — see the
   agent docs for that handler's filter/sort options.
5. Save.

### Choose the widget

On the Paragraph type's **Manage form display**, set the field's widget to **Check
boxes/radio buttons** or **Select list** so editors see the available styles as options.
(Leave the field optional so "no style" is possible.)

### Hide the field on display

On **Manage display**, set the field to **Hidden / Disabled**. This is important: the style's
value is applied to the paragraph's wrapper as CSS classes automatically — it should **not**
be printed as visible field output.

## 3. See it in action

Edit a piece of content that uses this Paragraph type, add a paragraph, pick a style, and save.
Inspect the rendered paragraph and you'll find the style's classes on its wrapper element
(reaching `{{ attributes.class }}` in the template). If you don't see them, clear caches with
`drush cr` after adding new styles, and make sure your paragraph template outputs
`{{ attributes.addClass(classes) }}` (or just `{{ attributes }}`) on a real HTML element.

> **Not just paragraphs:** because the mechanism is a plain entity‑reference field, you can add
> the same field to nodes, blocks, or other entities to style them the same way.
