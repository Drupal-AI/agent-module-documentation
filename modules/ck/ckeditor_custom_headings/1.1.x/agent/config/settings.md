<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring custom headings (ckeditor_custom_headings)

There is **no dedicated admin route** (`configure: null`). All configuration lives inside the core
CKEditor 5 Heading plugin's settings, per text format.

## Install / enable

```
drush en ckeditor_custom_headings -y
```

Requires core `ckeditor5` (declared dependency). Then edit a text format
(`/admin/config/content/formats/manage/<format>`) that uses the CKEditor 5 editor and has the **Heading**
button on the toolbar. A **Headings** tab appears under *CKEditor 5 plugin settings*.

## The two alter hooks (`ckeditor_custom_headings.module`)

- **`hook_ckeditor5_plugin_info_alter(&$plugins)`** — if `ckeditor5_heading` exists, converts its
  `CKEditor5PluginDefinition` to an array, sets `drupal.class` to
  `Drupal\ckeditor_custom_headings\Plugin\CKEditor5Plugin\Heading`, and appends `<h1 class>`…`<h6 class>`
  to `drupal.elements` so the `class` attribute *can* be produced on any heading. Returns early if the
  core plugin is not registered.
- **`hook_config_schema_info_alter(&$definitions)`** — on `ckeditor5.plugin.ckeditor5_heading`:
  - adds mapping key `customize` (`boolean`, "Customize headings").
  - adds mapping key `custom_headings` (`string`, "Custom headings").
  - **unsets** the `NotBlank` constraint on `enabled_headings` (lets a format save with zero standard
    headings enabled when custom headings are used instead).
  - repoints the `enabled_headings` `Choice` constraint callback to `Heading::validChoices` (avoids
    `AssertionError: assert($plugin_definition->getClass() === static::class)` after the class swap).

## Config keys (stored in the editor's plugin settings)

Under the existing `ckeditor5.plugin.ckeditor5_heading` mapping:

| Key | Type | Meaning |
| --- | --- | --- |
| `customize` | boolean | When TRUE, use `custom_headings` instead of core `enabled_headings`. Default FALSE. |
| `custom_headings` | string | Newline-separated heading definitions (format below). Default `''`. |
| `enabled_headings` | sequence | Core key; still present but hidden in the form while `customize` is on. |

## The form (`Heading::buildConfigurationForm()`)

Extends the core Heading form and adds:

- **Customize headings** checkbox (`#weight -50`).
- **Custom Headings** textarea, defaulting to the current `custom_headings` or, if empty,
  `getDefaultCustomHeadings()` (one `hN|Heading N` line per currently-enabled heading, falling back to
  `h2`–`h6`).

`#access` toggles which control is visible: with *customize* on, the core `enabled_headings` control is
hidden and the textarea shown; with it off, the reverse. `submitConfigurationForm()` writes both
`customize` and `custom_headings` back into plugin configuration.

## The custom-headings string format

One definition per line:

```
h2.custom-heading-2|Custom heading (h2)
h3|Subheading
p|Paragraph
```

Each line = `tag` `.class`(optional) `|title`(optional), parsed by `parseConfiguration()` with
`^(?<tag>[^|.]*)(?:\.(?<class>[^|]*))?(?:\|(?<title>.*))?$`. Blank/non-matching lines are skipped.

- **tag** — must resolve to a model in `getModelFromItem()`: `p` → `paragraph`, `h1`–`h6` →
  `heading1`…`heading6`. **Any other tag throws `\RuntimeException`** when the editor config is built,
  so avoid typos like `div.foo`.
- **class** — appended (ucfirst'd) to the model name to keep it unique, and set as `view.classes`; also
  raises `converterPriority` to `high` so the class-bearing variant wins conversion.
- **title** — the label shown in the editor's Heading dropdown.

## How it reaches CKEditor (`getDynamicPluginConfig()`)

When `customize` is on and `custom_headings` is non-empty, each parsed item becomes a
`heading.options` entry: `model`, `view` (the tag, or `{name, classes}` when a class is set), optional
`title`, optional `class`, and `converterPriority: high` for class variants. When custom headings are
empty or *customize* is off, it defers to the parent (standard core behaviour).

## Allowed-HTML scope (`getElementsSubset()`)

With custom headings set, only the `<hN>` (and `<hN class>` for tags given a class) that intersect the
plugin's declared elements are returned — so the widened `class` allowance is limited to `class` on the
heading tags actually configured. Ensure the **text format's allowed HTML** permits the resulting
heading markup/classes. Empty custom config falls back to the parent subset.
