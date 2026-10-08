# Configuration

CKEditor Font has **no dedicated settings page**. Everything is configured **per text
format**, on the same screen where you set up the CKEditor 5 toolbar. That means you
can give each format its own set of fonts, sizes, and colors.

## Add the buttons to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses the **CKEditor 5** editor.
3. In the **Toolbar configuration**, drag the buttons you want from *Available
   buttons* into the *Active toolbar*:
   - **Font Family** and **Font Size** (both come from the same plugin)
   - **Font Color**
   - **Font Background Color**
4. Each button's settings appear **below the toolbar** once the button is active.
   Fill them in (see below) and click **Save configuration**.

You don't need to touch the format's allowed‑HTML settings: each plugin declares
`<span>` and `<span style>` as its allowed elements, so CKEditor 5 adds those
automatically and the inline styles survive filtering.

## Font Size & Family settings

These appear when you add the Font Family and/or Font Size buttons.

- **Font sizes** — a textarea, one entry per line, in the form `123px|Size label`.
  The size can use `px`, `em`, `%`, `pt`, `rem`, or a CSS keyword like `small` or
  `large`. The part after the `|` is the friendly label shown in the dropdown and is
  optional. For example:

  ```
  12px|Small
  16px|Normal
  24px|Large
  ```

  Leave the field empty to fall back to the built‑in defaults (tiny, small, default,
  big, huge). A malformed line produces a "list of font sizes is syntactically
  incorrect" error on save.

- **Support all Font Size values** — a checkbox. When ticked, pasted content that uses
  a font size outside your list is kept rather than stripped (the values must be
  numeric). It cannot be enabled if the size list is empty.

- **Font families** — a textarea, one entry per line, each a comma‑separated fallback
  stack. The label shown in the dropdown is taken from the first family in the stack.
  For example:

  ```
  Verdana, Geneva, sans-serif
  Georgia, 'Times New Roman', serif
  'Courier New', monospace
  ```

  Leave it empty to use a built‑in serif / sans‑serif / monospace default list.

- **Support all Font Family values** — a checkbox. When ticked, pasted content keeps
  font families outside your list instead of having them stripped.

## Font Color and Font Background Color settings

The **Font Color** and **Font Background Color** buttons each expose the same three
settings:

- **Colors** — a textarea, one entry per line, in the form `value|Label`. The value
  can be a hex code, an `rgb()` value, or an `hsl()` value. For example:

  ```
  #d40000|Brand red
  rgb(0, 90, 156)|Brand blue
  hsl(0, 0%, 0%)|Black
  ```

  Invalid syntax produces an error on save. This is where you define an approved brand
  palette for editors.

- **Number of columns** *(default: 5)* — how many swatches appear per row in the color
  dropdown. Minimum 1.

- **Maximum available colors** *(default: 0)* — how many recently‑used "document
  colors" the picker remembers and offers. Set it to `0` to disable that feature
  entirely.

## Save and deploy

Click **Save configuration**. Because these settings are stored as part of the text
editor's configuration entity, they export and import with `drush config:export` /
`drush config:import` like any other Drupal configuration, so you can move a format's
typography setup between environments.

## Upgrading from CKEditor 4

If you're upgrading a site from CKEditor 4, the module includes an upgrade plugin that
maps the old `Font` button to Font Family, the old `FontSize` button to Font Size, and
converts the legacy font‑size and font‑family settings into this module's plugin
configuration during the format upgrade — so your existing setup carries over.
