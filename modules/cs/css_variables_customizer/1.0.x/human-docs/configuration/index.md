# Configuration

Setting up CSS Variables Customizer happens in two parts: a **one‑time preparation
of your theme** (so the module knows which variables it may override), and then the
ongoing **overview page** where you actually change values. The overview will be
empty until the theme is prepared, so do the theme setup first.

## Part 1 — Prepare your theme (one time)

### Declare the source stylesheets

In your theme's `.info.yml` file, tell the module which CSS files (or folders) hold
the variables you want to expose. Add a `css_variables_customizer` section listing
the source stylesheets:

```yaml
css_variables_customizer:
  stylesheets:
    - cssSourceFolder
    - src/cssSpecificFile.css
```

You can list either individual files or whole folders under `stylesheets`.

### Annotate the variables

For the module to discover a variable, wrap it in a pair of annotation comments in
the CSS. Begin a group with `@css-variables-customizer-category <category>` —
replacing `<category>` with any name you like, which becomes the group heading in
the UI — and close it with `@css-variables-customizer-category-end` after the last
variable you want to expose:

```css
/* @css-variables-customizer-category theme */
--card-media-aspect: 16/9;
--card-radius: var(--theme-radius, 0.5rem);
--card-spacing: var(--theme-spacing, 0.25rem);
/* @css-variables-customizer-category-end */
```

Everything between those two comments becomes overridable and appears under the
category name you chose. This works both for the main theme CSS and for Single
Directory Components (SDC). If you later remove a variable from the code, it simply
stops appearing on the configuration page.

### Clear caches

After editing the `.info.yml` and annotating the CSS, **clear caches** (`drush cr`)
so the module re‑reads your theme.

## Part 2 — Override values on the overview page

1. Log in as an administrator and go to **Appearance → CSS Variables Customizer**
   (`/admin/appearance/css-variables-customizer`).
2. Your prepared theme appears in the list — **select it**. (Multiple themes are
   supported, each configured independently.)
3. You'll see the discovered variables, grouped under the category names from your
   annotations. Enter the new value for any variable you want to change.
4. Use the **preview** to see your changes applied before you commit them — this
   is also where the recommended **SDC Styleguide** module helps you preview
   component overrides.
5. **Save** your customizations. The overridden values are applied to the front end
   without any code deployment.

## Good to know

- **Only annotated variables are adjustable.** If a client asks for a change to
  something the theme didn't expose as a token, you'll need to annotate that
  variable in the theme first (Part 1).
- **Values are written into the page's CSS.** Enter valid CSS values; the preview
  step is the quickest way to catch a value that doesn't render as intended.
- Removing a variable from the theme code automatically removes it from this page,
  so the configuration stays in step with the theme.
