# Enabling & configuring the filter (and CKEditor 5 plugin)

There is **no dedicated settings page** (`configure` = null). You enable and configure the
"Advanced Insert View" filter per **text format** at
`/admin/config/content/formats/manage/<format>` (*Configuration → Content authoring → Text
formats and editors*).

## Where the enabled state + settings live

In config `filter.format.<format>`:

```yaml
filters:
  insert_view_adv:
    id: insert_view_adv
    provider: insert_view_adv
    status: true
    weight: 10
    settings:
      allowed_views: {}        # empty = all views allowed; else keys like 'my_view=page_1'
      render_as_empty: 0       # 0 = leave a disallowed view as its raw [view:...] token
      hide_argument_input: 0   # 1 = ignore user-supplied contextual arguments
```

`filters.insert_view_adv.status: true` is the signal that the filter is enabled on a format.

### Filter settings

| Setting | Default | Meaning |
|---|---|---|
| `allowed_views` | `{}` (all) | Whitelist of `viewMachineName=displayId` keys editors may embed. Empty allows all. |
| `render_as_empty` | `0` | If `0`, a not-allowed/disabled view is output as its literal `[view:...]` token; if `1`, it renders nothing. |
| `hide_argument_input` | `0` | If `1`, user-supplied contextual-filter arguments are discarded (only defaults used). |

## Enable via drush / PHP

```php
$f = \Drupal::configFactory()->getEditable('filter.format.full_html');
$f->set('filters.insert_view_adv.id', 'insert_view_adv');
$f->set('filters.insert_view_adv.provider', 'insert_view_adv');
$f->set('filters.insert_view_adv.status', TRUE);
$f->set('filters.insert_view_adv.weight', 10);
$f->set('filters.insert_view_adv.settings', [
  'allowed_views' => [], 'render_as_empty' => 0, 'hide_argument_input' => 0,
]);
$f->save();
```

## CKEditor 5 toolbar button

The module ships a CKEditor 5 plugin (`insert_view_adv.ckeditor5.yml`, id `insert_view_adv`)
that adds an **Insert View** toolbar button opening a dialog (route
`insert_view_adv.editor_dialog`) to pick a view, display and contextual-filter values (with
entity-reference autocomplete). Add the button to the format's CKEditor 5 toolbar in the same
Text-format form. Its config schema `ckeditor.plugin.insert_view_adv` has one option:

- `enable_live_preview` (bool) — preview the embedded view live in the editor
  (route `insert_view_adv.editor_preview`).

## Security

The filter renders arbitrary views. Grant formats that enable it to **trusted roles only**,
and ensure **every** embeddable view/display (including the default display) has correct Views
access — the README states this explicitly.
