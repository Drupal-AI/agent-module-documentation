# colorbox_inline — data attributes (markup usage)

Colorbox Inline is configured entirely through HTML `data-` attributes on a trigger element.
Enable the module (`drush en colorbox_inline`) and add the attributes — there is nothing else
to set up. The trigger's `data-colorbox-inline` value is a **CSS selector** for another element
already on the same page; clicking the trigger opens that element's markup in a Colorbox modal.

## Minimal example

```html
<a data-colorbox-inline=".user-login" href="#">User Login</a>

<!-- The source content, anywhere on the page. May be hidden. -->
<div class="user-login" style="display:none;">
  ... form markup ...
</div>
```

Clicking "User Login" opens the first element matching `.user-login` inside Colorbox.

## Attributes

| Attribute | Required | Meaning |
|---|---|---|
| `data-colorbox-inline` | yes | CSS selector for the in-page element to show in the modal. A value containing `<` is ignored (guard against passing raw HTML). Only string values are honored. |
| `data-width` | no | Modal width (passed to Colorbox `width`). |
| `data-height` | no | Modal height (passed to Colorbox `height`). |
| `data-class` | no | Extra CSS class added to the Colorbox wrapper (Colorbox `className`). |
| `data-rel` | no | Colorbox `rel` group id — give several triggers the same value to group them for prev/next navigation. |

Attribute names map to jQuery `.data()` camelCase keys internally (`data-colorbox-inline`
→ `colorboxInline`, `data-width` → `width`, etc.).

## Behavior notes

- Global Colorbox options come from `drupalSettings.colorbox` (configured on the parent
  Colorbox module's settings form); the per-link attributes override them.
- If the source element is hidden (`display:none`, i.e. not `:visible`), the module shows it
  while the modal is open and re-hides it on Colorbox `onCleanup`. So keeping source markup
  hidden in normal page flow is the intended pattern.
- Each trigger is processed once via `core/once` (`colorbox-inline-processed`), so it is
  Ajax/BigPipe-safe.
- Authoring in a WYSIWYG body field requires a text format (e.g. Full HTML) that does not
  strip `data-*` attributes.
- For content that must be **fetched over AJAX** rather than already rendered on the page,
  use the separate [`colorbox_load`](https://www.drupal.org/project/colorbox_load) module.
