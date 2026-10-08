# Configuration

There's no site-wide settings form — you configure the Bootstrap Buttons plugin **per
text format**, alongside the rest of that format's CKEditor 5 toolbar.

## Add the button to a text format

1. Log in as a user who can administer text formats.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit a format that uses **CKEditor 5** (for example *Full HTML*).
4. In the toolbar configuration, drag the **Bootstrap Buttons** item from *Available
   buttons* into the *Active toolbar*.
5. A **Bootstrap Buttons** vertical tab appears below the toolbar — open it to set the
   options below.

The plugin automatically declares the HTML elements it needs (`<a>` with `class`,
`href`, and `target`; `<em class>`; `<span class>`), so the format's allowed-tags
filter is updated to permit them.

## The three settings

### Class Selectors

This textarea defines the grouped dropdowns editors see in the button dialog. The
syntax is one option per line, grouped under headings:

- A line **with no leading `-`** is a **group heading** (for example `Size`).
- A line like **`- Label|css-class`** is an **option** under the current group. The
  text before `|` is what the editor sees; the text after `|` is the CSS class
  applied. Leave the class empty (`- Normal|`) for an option that adds no class.

The default value gives you three groups — Size, Style, and Color:

```
Size
- Small|btn-sm
- Normal|
- Large|btn-lg
Style
- Primary|btn-primary
- Secondary|btn-secondary
Color
- Light|
- Dark|dark
```

Edit these to match the button classes your theme actually provides. You can add your
own groups the same way.

### Text Class

A single CSS class applied to the `<span>` that wraps the button's label text
(default `text`). It's sanitized to one clean class token when you save.

### Show Icon Settings

A checkbox (on by default). When enabled, the button dialog includes a Glyphicon /
Font Awesome icon picker so editors can add an icon to the button.

> **Font Awesome note.** If you use the Font Awesome module, it needs to be set to the
> **webfonts** method for these icons to work. If it's configured with a different
> method, this settings form shows a warning linking to the Font Awesome settings.

## Save, and remember the CSS

Save the text format. Editors can now select a link in that format's editor, click
**Bootstrap Buttons**, and pick a size/style/colour (and icon) to style it.

Keep in mind the module only styles the button *preview* inside the editor. The real
appearance on the published page depends on your theme providing the Bootstrap button
CSS for the classes you offered (`btn`, `btn-primary`, and so on). If the buttons look
unstyled on the front end, that CSS is what's missing.

## Per-format palettes

Because configuration is per format, you can offer different button palettes in
different formats — a fuller set in *Full HTML* for trusted editors, a restricted set
in a *Basic* format — simply by giving each format its own Class Selectors.
