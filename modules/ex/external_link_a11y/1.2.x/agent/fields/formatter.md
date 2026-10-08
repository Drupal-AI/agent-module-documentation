<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Link (target blank when external a11y)" field formatter

`src/Plugin/Field/FieldFormatter/ExternalLinkA11yFormatter.php` — plugin id **`external_link_a11y`**,
label *"Link (target blank when external a11y)"*, `field_types: ['link']`. It **extends core
`LinkFormatter`** and only post-processes the render array core already builds, so all standard Link
formatter options (link text trimming, `url_plain`, `url_only`, etc.) still apply — except the core
**`target`** checkbox, which this formatter removes (`unset($elements['target'])`) because it manages
target itself.

## Enable it on a Link field

UI: *Structure → (content type) → Manage display* → set a **Link** field's format to
**"Link (target blank when external a11y)"** → gear icon for the options below.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_link.type external_link_a11y -y
drush cr
```

## Settings

`defaultSettings()` adds three keys on top of core Link's defaults:

| Setting key | Default | Meaning |
|---|---|---|
| `add_target_blank` | `TRUE` | Add `target="_blank"` to external links that do not already define a `target`. Disable to keep the other enhancements without adding a target. |
| `rel_noopener` | `FALSE` | Add the `noopener` value to the anchor's `rel` attribute on new-tab links. |
| `rel_noreferrer` | `FALSE` | Add the `noreferrer` value to the anchor's `rel` attribute on new-tab links. |

Config schema: `field.formatter.settings.external_link_a11y` (in
`config/schema/external_link_a11y.schema.yml`) extends `field.formatter.settings.link` and adds the three
booleans above. `settingsSummary()` appends "Does not add target=\"_blank\"" when `add_target_blank` is
off, and one line per enabled `rel` value.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_link:
    type: external_link_a11y
    label: above
    settings:
      # ...core Link settings (trim_length, url_plain, url_only, rel, target)...
      add_target_blank: true
      rel_noopener: true
      rel_noreferrer: true
```

## How rendering works (`viewElements()`)

1. Calls `parent::viewElements($items, $langcode)` (core Link formatter) to get the base elements, then
   iterates them, reading `$url->getOption('attributes')` for each `#url`.
2. If `add_target_blank` is on **and** `$url->isExternal()` **and** no `target` attribute is set yet,
   sets `attributes['target'] = '_blank'`.
3. For any element whose `target === '_blank'` (whether just added or already present): sets a
   `title` attribute of `"@title (Open in new window)"` and replaces `#title` with
   `"@title<span class=\"visually-hidden sr-only\"> (Open in new window)</span>"` — the placeholder
   `@title` is passed through `$this->t()`, so it is auto-escaped (safe render markup, not raw output).
4. Still within the new-tab branch, appends the enabled `rel_noopener` / `rel_noreferrer` values to
   `attributes['rel']` (de-duplicated), then writes attributes back with `$url->setOption('attributes', …)`.
5. The whole loop is wrapped in `try/catch`; on exception it logs via `Error::logException()` to the
   `external_link_a11y` logger channel (service `logger.factory`, injected in `create()`) and returns `[]`.

## Notes

- Only **external** links get a target added (`$url->isExternal()`); internal links are left alone by
  the target logic.
- The `rel` and "Open in new window" cue only apply to links that actually open in a new tab.
- No permissions, routes, hooks or services beyond the injected `logger.factory`. Behaviour is entirely
  a per-view-display display concern.
