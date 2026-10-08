# Set up an Entity Pager (Views style)

Entity Pager has **no admin settings page** (`configure: null`). You configure it entirely
inside a View by choosing the **Entity Pager** format. The choice and its options live in the
View's config entity (`views.view.<id>` → `display.<display>.display_options.style`).

## Recipe (UI)

1. Enable `views_ui` if needed. Create a View (*Structure → Views → Add view*).
2. Base it on the entity you page through (e.g. **Content**). Create a **Block** display.
3. Add the entity's **ID** field (e.g. Content: nid) so rows resolve to entities.
4. Set **Items per page = 0** (all) and **Use a pager = off** — the pager needs the full list.
5. In *Format*, choose **Entity Pager** and click **Settings** to set the options below.
6. Add filters/sorts to define which entities are in the sequence and their order.
7. Place the resulting **block** on the entity's canonical page (Block layout, or a block-placement
   module). On an entity whose ID is in the View results, the `< prev / All / next >` pager appears.

The shipped demo `entity_pager_example` View (disabled by default) is a ready example — enable it
and place its `entity_pager_example_block` block.

## Style plugin id

`entity_pager` — `Drupal\entity_pager\Plugin\views\style\EntityPager` (style, non-row, uses fields).

## Style options (config keys under `display_options.style.options`)

| Key | Default | Meaning |
|---|---|---|
| `link_prev` | `'< prev'` | Previous link label (HTML allowed). |
| `link_next` | `'next >'` | Next link label (HTML allowed). |
| `display_all` | `true` | Whether to render the middle "All" link. |
| `link_all_url` | `'<front>'` | "All" link URL. Accepts a path, `<front>`, or a token (e.g. `[node:field_company]`, `[node:edit-url]`). |
| `link_all_text` | `'Home'` | "All" link label (HTML/tokens allowed; an entity-reference token renders the referenced entity title). |
| `display_count` | `true` | Show the "N of M" position counter. |
| `circular_paging` | `false` | Wrap last→first and first→last. |
| `show_disabled_links` | `true` | Show greyed prev/next `<nolink>` links at the ends (only relevant when `circular_paging` is off). |
| `relationship` | `''` | Optional Views relationship id; when set, the pager navigates the related entity instead of the base row entity. |

Config schema: `views.style.entity_pager` (in `config/schema/entity_pager.views.schema.yml`).

## Set it in code / config

Style options are part of the View. To flip an option on a saved View:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_pager');
$display = &$view->getDisplay('default');
$display['display_options']['style']['options']['circular_paging'] = TRUE;
$view->save();
```

Read it back with `drush cget views.view.my_pager` and look under
`display.default.display_options.style`.

## Behaviour notes

- The current entity is auto-detected from the route's `entity:*` parameter (or a request
  `entity` attribute) — you do **not** pass the current id to the View.
- Tokens in `link_all_url` / `link_all_text` are replaced against the current entity
  (`[node:...]`, and entity-reference chains like `[node:field_company]`).
- Links point to each adjacent entity's `canonical` URL, translated to the current language
  when a translation exists.
