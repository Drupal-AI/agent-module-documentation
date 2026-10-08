# Configure the EPT Views paragraph type

`ept_views` ships one Paragraphs bundle and its display config; there is **no module settings page**.
Everything you tune lives on the paragraph type's *Manage form display* / *Manage display* and in the
`viewsreference` field settings. Source of truth: `config/install/*.yml`.

## What gets installed

| Config | id | Note |
|---|---|---|
| Paragraph type | `paragraphs.paragraphs_type.ept_views` | bundle `ept_views`, label "EPT Views", no behavior plugins |
| Field storage | `field.storage.paragraph.field_ept_views_view` | type `viewsreference`, `target_type: view`, cardinality 1 |
| Field instance | `field.field.paragraph.ept_views.field_ept_views_view` | the view picker (required) |
| Field instance | `field.field.paragraph.ept_views.field_ept_settings` | ept_core design settings (`ept_settings`) |
| Field instance | `field.field.paragraph.ept_views.field_ept_title` / `…field_ept_text` | optional `text_long` title + intro |
| Form display | `core.entity_form_display.paragraph.ept_views.default` | widgets + field_group tabs |
| View display | `core.entity_view_display.paragraph.ept_views.default` | formatters |

To let editors place it, add a **paragraphs (entity reference revisions) field** to a host bundle
(e.g. a node type) and allow the `ept_views` type — this is standard Paragraphs wiring, not something
ept_views configures for you.

## Which views are embeddable + per-placement options (viewsreference field settings)

These are the settings that matter most and are edited on the `field_ept_views_view` instance
(*Manage form display* → the field's gear, and the field's *Edit* settings). Keys, from
`field.field.paragraph.ept_views.field_ept_views_view` → `settings`:

| Key | Shipped default | Meaning |
|---|---|---|
| `handler` | `default:view` | Entity-reference handler selecting `view` config entities. |
| `preselect_views` | `{}` (empty) | **Allowlist of view ids** an editor may pick. Empty = **all views** are selectable — including administrative/module-shipped views. Set this to restrict the surface. |
| `enabled_settings` | `{}` (empty) | Which per-placement viewsreference options the editor sees (e.g. `title`, `display_id`, `argument`, `limit`, `offset`, `pager`, `field_*`). Empty = only the view+display picker. |
| `plugin_types` | `{block: block}` | Which Views display plugin types are offered by the autocomplete (here: `block` displays). |

The view-display **formatter** (`viewsreference_formatter`) also carries `plugin_types: [block]` in the
view display config; keep it aligned with the field/widget when you widen the allowed display types.

## Form widget (how the editor picks a view)

Form display `paragraph.ept_views.default`, component `field_ept_views_view`:

```yaml
type: viewsreference_autocomplete
settings:
  match_operator: CONTAINS   # autocomplete match mode
  match_limit: 10            # max suggestions
  size: 60
  placeholder: ''
```

Other components: `field_ept_title` / `field_ept_text` → `text_textarea` (rows 2 / 5),
`field_ept_settings` → `ept_settings_default` (the ept_core design widget).

### field_group tabs

`third_party_settings.field_group` splits the edit form into a **Tabs** group (`group_tabs`, format
`tabs`) with two tabs:

- `group_content` (label "Content", open) — `field_ept_title`, `field_ept_text`, `field_ept_views_view`.
- `group_settings` (label "Settings", closed) — `field_ept_settings`.

(`field_group` is therefore an install-time module dependency even though it is not in `info.yml`'s
`dependencies` — it is pulled in via the form-display config.)

## Rendering (view display)

View display `paragraph.ept_views.default`:

- `field_ept_title` → `text_default` (weight 0), `field_ept_text` → `text_default` (weight 1),
  `field_ept_views_view` → `viewsreference_formatter` with `settings.plugin_types: [block]` (weight 2),
  `field_ept_settings` → `ept_settings_default` (weight 3), all `label: hidden`.
- The template `templates/paragraph--ept-views--default.html.twig` renders the title (wrapper tag /
  strip-tags driven by the ept_core `field_ept_settings` values), then `content|without('field_ept_settings','field_ept_title')`, and finally the ept_core-generated inline `{{ styles }}`.
- Library `ept_views/ept_views` (`css/ept-views.css`) hides the view's own title
  (`.viewsreference--view-title`) since EPT renders the paragraph title instead.

## Access note (for agents)

The embedded view is executed by `viewsreference_formatter` and returned as a Views core
`#type => view` element; Views' `Element\View::preRenderViewElement` re-checks the display access
plugin against the **current viewer** before emitting markup. So placing a restricted view does not
expose it to viewers who lack access; the host page must still carry the view's cache/access metadata
(it does, via the render element's cacheability).
