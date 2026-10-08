# Bootstrap field-group formatters

All plugins live in `src/Plugin/field_group/FieldGroupFormatter/` and extend
`field_group`'s `FieldGroupFormatterBase` (or, for HTML-based ones, its `HtmlElement`). You don't
call these in code — you select one as the *Format* of a field group in the Field Group UI on
*Manage form display* or *Manage display*. Most declare `supported_contexts = {"form","view"}`.

| Formatter id | Label | Notes / key settings |
|---|---|---|
| `bootstrap_accordion` | Bootstrap Accordion | `active_default` (default open panel), `open` (always open), `flush`, `icon` (Bootstrap icon classes, comma-separated). Remembers open panel via a `bootstrap_accordion` cookie. Invokes `field_group_accordion_pre_render`. |
| `bootstrap_tab` / `bootstrap_tabs` | Bootstrap Tab / Tabs | Tabbed grouping. |
| `bootstrap_card` | Bootstrap Card | Card wrapper. |
| `bootstrap_modal` | Bootstrap Modal | Renders the group in a modal. |
| `bootstrap_offcanvas` | Bootstrap Offcanvas | Slide-in panel. |
| `bootstrap_popovers` | Bootstrap Popovers | Popover behaviour (JS lib `popover`). |
| `bootstrap_toast` | Bootstrap Toast | Toast notification wrapper. |
| `bootstrap_toggle` | Bootstrap Toggle | Collapse/toggle. |
| `bootstrap_horizontal_form` | Bootstrap Horizontal Form | Horizontal form layout (CSS lib `field_group_horizontal_form`). |
| `bootstrap_floating_labels` | Bootstrap Floating Labels | Floating-label form styling. |
| `bootstrap_grid` | Bootstrap Grid | Grid layout. |
| `bootstrap_multistep` | Bootstrap Multistep | Multistep wizard (JS lib `multistep`). |
| `bootstrap_scrollspy` | Bootstrap ScrollSpy | Scrollspy nav (class `BootstrapScrollspy`). |
| `bootstrap_table` | Bootstrap Table | Vertical/horizontal table rendering. |
| `twig_element` | Twig element | Renders the group's inner content wrapped in an admin-entered inline Twig template. |

Matching render-element classes are in `src/Element/` (e.g. `FieldGroupBootstrapAccordion`,
`FieldGroupBootstrapMultistep`). Libraries: `field_group_bootstrap.libraries.yml` defines
`field_group_boostrap` (tabs CSS + JS), `field_group_horizontal_form`, `multistep`, `popover`.

## Caution: `twig_element` renders admin-supplied Twig
`TwigElement` (`twig_element`) takes a free-text `twig` setting and renders it as an
`inline_template` (`#type => 'inline_template'`, `#template => $this->settings['twig']`), passing
the group's render array + processed object as context. This is Twig executed server-side, so it is
effectively a code/template-injection surface — **but** the value is field-group *display config*,
editable only by users who can administer the entity's form/display (a `restrict access: true`
config permission, i.e. a trusted admin). Not a privilege-boundary crossing on its own; just keep
the "administer … display" permissions restricted to trusted roles and avoid interpolating
untrusted field values into the template.
