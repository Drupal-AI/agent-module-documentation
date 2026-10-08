# Configure — region restrictions

**Route:** `layout_paragraphs_limit.settings_form` → `/admin/config/content/layout_paragraphs/limit`
(access: core permission `administer site configuration`).
**Config object:** `layout_paragraphs_limit.settings` (key `disallowed_types`).
**Form class:** `Drupal\layout_paragraphs_limit\Form\LayoutParagraphsLimitSettingsForm`.

The form only lists layouts that appear in some Paragraph type's `layout_paragraphs`
behavior (`available_layouts`). For every such layout it renders a details group per region
with three inputs.

## Config structure

```yaml
# layout_paragraphs_limit.settings
disallowed_types:
  <layout_plugin_id>:
    <region_key>:
      negate: false            # false = EXCLUDE checked types; true = INCLUDE only checked types
      numeric_limit: 0         # 0 = unlimited components in this region
      paragraph_types:         # keyed by paragraph type machine name; checked = value == machine name
        bp_card: bp_card
        bp_callout: 0          # unchecked types are stored as 0 (or omitted after save)
```

- `negate` is stored as a boolean. The form radio labels: `1` = "Include the selected below",
  `0` = "Exclude the selected below".
- `numeric_limit` is cast to int; `0` means no cap.
- `paragraph_types` is a checkboxes value: checked entries hold the type id, unchecked hold `0`.
  On save, `massageFormValues()` drops zero-valued region/type keys (but keeps `negate` and
  `numeric_limit`).

Layout ids and region keys are **core layout plugin** ids, e.g. `layout_onecol` → `content`;
`layout_twocol` → `top`, `first`, `second`, `bottom`; `layout_twocol_section` → `first`,
`second`. Paragraph type ids are your Paragraph types' machine names (e.g. `bp_card`).

## Set it with Drush (no UI)

```bash
# Exclude bp_card from the content region of layout_onecol:
drush php:eval '$c=\Drupal::configFactory()->getEditable("layout_paragraphs_limit.settings");
$c->set("disallowed_types.layout_onecol.content", ["negate"=>false,"numeric_limit"=>0,"paragraph_types"=>["bp_card"=>"bp_card"]])->save();'

# Cap layout_twocol "first" region at 2 components (no type restriction):
drush php:eval '$c=\Drupal::configFactory()->getEditable("layout_paragraphs_limit.settings");
$c->set("disallowed_types.layout_twocol.first", ["negate"=>false,"numeric_limit"=>2,"paragraph_types"=>[]])->save();'
```

Read the current value: `drush cget layout_paragraphs_limit.settings disallowed_types`.
