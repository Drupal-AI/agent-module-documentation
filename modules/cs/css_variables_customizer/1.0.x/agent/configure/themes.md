<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — make a theme customizable & edit its variables

## Step 1: opt a theme in (its `.info.yml`)

Only enabled themes whose `.info.yml` declares a `css_variables_customizer` key are discovered
(`ThemeFinder::findCustomizableThemes()`, `src/ThemeFinder.php:23`). List the source stylesheets — files
or whole folders — that hold the overridable variables:

```yaml
# my_theme.info.yml
css_variables_customizer:
  stylesheets:
    - css                      # a folder: every top-level *.css / *.scss not starting with "_"
    - src/tokens.css           # a specific file
```

`CustomizerForm::getMainCssAssets()` (`src/Form/CustomizerForm.php:734`) resolves each entry relative to
the theme directory. For a folder it globs `[!_]*.css` and `[!_]*.scss` (leading-underscore partials are
skipped, non-recursive). For a file it takes it as-is.

## Step 2: annotate the variables to expose

The parser only picks up custom properties wrapped in category annotation comments
(`CssVariablesManager::parseCss()`, `src/CssVariablesManager.php:69`):

```css
/* @css-variables-customizer-category theme */
:root {
  --card-radius: var(--theme-radius, 0.5rem);
  --card-spacing: 0.25rem;
}
/* @css-variables-customizer-category-end */
```

- Start marker regex: `/* @css-variables-customizer-category <name> */` — `<name>` (`\w+`) becomes the
  UI group heading.
- End marker: `/* @css-variables-customizer-category-end */`.
- A line is captured as a variable only inside an open category and only if it matches
  `CSS_VARIABLES_REGEXP` = `/(?<variable>--([a-zA-Z0-9]+-?)+):(?<value>.+);/` — i.e. `--name: value;`.
- The nearest preceding selector line (`… {`) is remembered and stored as the variable's default
  `selector`; variables under `:root { … }` therefore default to the `:root` selector.

After editing `.info.yml`/CSS run `drush cr` so routes, menu links and the parsed variable list refresh.

## Step 3: edit & save overrides

- Overview: `/admin/appearance/css-variables-customizer` (route `css_variables_customizer.overview`) lists
  every customizable theme with a link to its form.
- Per-theme form: `/admin/appearance/css-variables-customizer/<theme>` (route
  `css_variables_customizer.theme.<theme>`, `CustomizerForm`). Both routes require the core permission
  **`administer themes`**.

The form (`buildForm()`, `src/Form/CustomizerForm.php:132`) shows vertical tabs:

- **Global** — variables parsed from the theme's main stylesheets, default selector `:root`.
- **One tab per SDC component** that carries annotated variables (`getComponentVariables()`), default
  selector `:root [data-component-id="<component-id>"]`.
- Per variable you set a **Value** and a **Selector** (both plain textfields), and may **Add more**
  selector/value variants (each variant must use a distinct selector — a repeat is a validation error,
  `massageCategoryVariables()`).
- **Custom** tab — a free-form textarea for extra variables, one `--name: value;` per line
  (`validateCustom()` checks each line against `CSS_VARIABLES_REGEXP`; a variable already defined in a
  category group is rejected as a conflict).

## Where values are stored

`submitForm()` (`src/Form/CustomizerForm.php:612`) writes to the **config object**
`css_variables_customizer.customizations.<theme>` (the form extends `ConfigFormBase`; the editable name
is computed per theme in `getThemeConfigName()`):

```yaml
# css_variables_customizer.customizations.olivero
customizations:
  - id: global                     # 'global', an SDC component id, …
    overrides:
      '--card-radius':
        - { selector: ':root', value: '1rem' }
  # …
custom:
  '--theme-primary': '#0055ff'     # from the Custom textarea
```

Schema: `config/schema/css_variables_customizer.schema.yml` (key `css_variables_customizer.*`). Because
this is configuration, overrides are exported by the config system, travel between environments, and are
**overwritten by a config import** — they are not content/state.

## Preview (before saving)

The manager checks the current user's **private tempstore** (`css_variables_customizer` collection, key
`preview_<theme>`) before falling back to saved config. During AJAX form interaction `validate()` writes
the pending values there (`$this->tempStore->set('preview_' . $theme, …)`), so an editor sees unsaved
changes applied. Preview data is per-user and short-lived: `CssVariablesPreviewCleanupSubscriber` deletes
it on the `kernel.terminate` event after the response is sent. If `sdc_styleguide` is installed, each
component tab also gets a demo selector + "Show Preview" button that loads the component's styleguide demo
in an iframe (`SdcStyleguidePreviewTrait`, route `sdc_styleguide.viewer`).
