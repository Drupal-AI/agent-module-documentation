<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a prepopulate URL

There is nothing to configure. Enabling the module is the whole setup; you "configure" it by
writing the right query string.

## The rule

The query string mirrors the **render array path** of the element, rooted at `edit`:

```
?edit[<top level key>][<child>][<child>]…=<value>
```

`prepopulate_form_alter()` only attaches itself when the request has an `edit` query parameter,
so a URL without `edit[...]` does nothing at all.

## Field API cheat-sheet (node/add and entity edit forms)

| What you want to fill | Query parameter |
|---|---|
| Node title | `edit[title][widget][0][value]=My title` |
| Body (text with summary) | `edit[body][widget][0][value]=Hello world` |
| Any single-value text field | `edit[field_foo][widget][0][value]=…` |
| Entity reference (autocomplete) | `edit[field_ref][widget][0][target_id]=123` |
| Second delta of a multi-value field | `edit[field_foo][widget][1][value]=…` |
| List field rendered as a `select` | `edit[field_list][widget]=key` |
| Datetime field | `edit[field_when][widget][0][value][date]=2026-01-31` |
| Non-field element (e.g. `mail` on user register) | `edit[mail]=someone@example.com` |

Combine with `&`:

```
/node/add/article?edit[title][widget][0][value]=Hello&edit[body][widget][0][value]=World&edit[field_tags][widget][0][target_id]=7
```

Percent-encode anything unsafe (` ` → `%20`, `&` → `%26`, `#` → `%23`). Square brackets work
unencoded in practice but `%5B` / `%5D` are equivalent.

## Finding the right path when you are unsure

1. Load the form, view source, and read the `name="…"` attribute of the input, e.g.
   `name="field_tags[0][target_id]"`.
2. Prefix the field name with `edit[`, insert `[widget]` after the field name, keep the rest:
   `edit[field_tags][widget][0][target_id]`.
   (`[widget]` is the Field API wrapper element that does not appear in the HTML `name`.)
3. If it still does not fill, the element's `#type` is probably not whitelisted — see
   [../api/populate-service.md](../api/populate-service.md) and
   [../hooks/whitelist-alter.md](../hooks/whitelist-alter.md).

## Gotchas

- **`radios` and `checkboxes` will not be filled** by default — deliberate security decision.
- A value already present on the element (`#value` set, e.g. on an edit form) is **not**
  overwritten; prepopulate only fills empties.
- Elements with `#access: FALSE` are skipped.
- On multi-step forms only the **first** build is populated (`$form_state->isRebuilding()` bails).
- Values are passed through `Html::escape()`.
- The service declares `required_cache_contexts: ['languages:language_interface', 'theme',
  'user.permissions', 'url.query_args']`, so prefilled pages vary correctly by query string.

## Turning a prepopulate URL into a menu link

```php
\Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'title' => 'Add a review',
  'menu_name' => 'main',
  'link' => ['uri' => 'internal:/node/add/article?edit[title][widget][0][value]=Review%3A%20'],
])->save();
```

The query string survives `Url::fromUri()`/`toString()` (brackets come back percent-encoded,
which the module still parses correctly).
