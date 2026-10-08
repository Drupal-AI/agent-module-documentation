# Configuration

Layout Custom Section Classes has two layers of configuration: a **global settings
form** where you decide what editors are allowed to do, and the **per-section /
per-region fields** that editors fill in while building a layout.

## Open the global settings form

1. Log in as a user with the **Administer layout builder section classes module
   settings** permission.
2. Go to **Configuration → Content authoring → Layout builder section attributes**,
   or navigate directly to
   `/admin/config/content/layout-builder-section-attributes`.

Everything on this form is saved into the `layout_custom_section_classes.settings`
config object.

## Which attributes editors may set

Two groups of checkboxes control which attribute fields appear in the Configure
section form — one group for the **section** as a whole and an identical group for
the **regions** inside a section. Each group offers five toggles:

- **ID** — a single HTML `id` on the section/region.
- **Class** — a free-text field for space-separated CSS classes.
- **Class list** — a checkbox list built from your predefined class list (below).
- **Style** — inline CSS.
- **Data** — `data-*` attributes.

All five are **on by default**. Turn any off to hide that field from editors — for
example, disable **Style** and **ID** so editors can only apply approved classes,
keeping your markup tidy and within guardrails.

## The predefined class list

The **Class list** field is where you define the classes that appear as checkboxes
for editors (when the *Class list* attribute is enabled). Enter one class per line.
You can give each a friendlier label using the `class|Friendly name` syntax — the
part before the `|` is the real CSS class, and the part after is what the editor
sees. For example:

```
bg-dark|Dark background
py-5
container-fluid
```

This lets a site builder curate a small, safe set of theme utility classes instead
of letting editors free-type anything.

## CSS validation

- **Relax CSS validation** — when **off** (the default), class names and IDs must be
  valid CSS identifiers; invalid input like `my!#class_1` is normalised to
  `my-class-1`. Turn it **on** to accept names as-is (underscores, uppercase, and so
  on); HTML tags are still stripped either way.
- Inline styles are always validated with the bundled `neilime/php-css-lint` linter,
  so genuinely invalid CSS is rejected.
- `data-*` attribute names must begin with `data-`.
- Token patterns (`[...]`) skip CSS-identifier validation, so token-derived values
  are left intact.

Click **Save configuration** when done.

## Setting attributes on a section or region (for editors)

The values themselves are entered while building a layout, not on the settings form:

1. Edit a layout with Layout Builder and open a section's **Configure section**
   dialog.
2. Fill in any of the enabled fields for the whole section:

   | Field | What it sets |
   |---|---|
   | **ID** | A single HTML `id`. |
   | **Custom Class(es)** | Space-separated CSS classes (free text). |
   | **Choose classes** | Checkboxes from your predefined class list. |
   | **Style** | Inline CSS. |
   | **Data-\* attributes** | One per line, as `data-name|value` (the value is optional). |

3. The same set of fields is offered per **region** inside the section, so a
   two-column section can give each column its own classes.
4. Save the section.

The values are stored in the layout's own configuration (on the entity for
overrides, or on the view display for defaults) — there is no separate config object
per section.

## Remember: the template must print the attributes

For any of this to show up, the layout template must output `{{ attributes }}` and
`{{ region_attributes.REGION }}`. Core's `layout--onecol.html.twig` does this
correctly. If you use a **custom** layout whose Twig hard-codes the wrapper markup
without those variables, the classes and attributes are computed but silently
dropped — add the variables to your template to fix it.

## Tokens (optional)

If the contrib **Token** module is enabled, the free-text fields (ID, classes,
styles, `data-*`, and their region equivalents) accept tokens and show a "Browse
available tokens" link. Tokens are resolved at render time against the entity being
rendered — so, for example, a section ID could derive from `[node:nid]`.

## Reading and changing settings with Drush

```bash
drush cget layout_custom_section_classes.settings
# turn OFF inline styles for sections:
drush cset layout_custom_section_classes.settings allowed_section_attributes.style false -y
# add predefined classes:
drush cset layout_custom_section_classes.settings class_list.0 'bg-dark|Dark background' -y
drush cset layout_custom_section_classes.settings class_list.1 'py-5' -y
```
