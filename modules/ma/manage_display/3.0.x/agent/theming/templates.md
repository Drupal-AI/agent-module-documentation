<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hooks, templates and the render-time re-assembly

## Theme hooks (`manage_display_theme()`)

| Hook | Template | Variables |
|---|---|---|
| `submitted` | `templates/submitted.html.twig` | `author_name`, `date`, `user_picture`/`author_picture`, `author_attributes`, `entity`, `entity_type` |
| `submitted__comment` | `templates/submitted--comment.html.twig` | as above plus `parent`, `permalink`, `permalink_url` |
| `in_reply_to` | `templates/in-reply-to.html.twig` | `subject`, `uid` (rendered strings) |
| `field__uid` | reuses core node's `field--node--uid.html.twig` | — |
| `field__created` | reuses core node's `field--node--created.html.twig` | — |
| `field__comment__pid` | reuses core node's `field--node--title.html.twig` | — |

The last three borrow core node templates (`path` points at the `node` module) so inline
rendering of `uid`/`created`/`pid` matches core markup on any entity type.

`manage_display_theme_suggestions_submitted()` adds `submitted__<entity_type>` — that is how
comments pick up `submitted--comment.html.twig`.

## Default markup

`submitted.html.twig`:

```twig
<footer>
  {{ author_picture }}
  <div{{ author_attributes }}>
    {% if date %}Submitted by {{ author_name }} on {{ date }}
    {% else %}Submitted by {{ author_name }}{% endif %}
    {{ metadata }}
  </div>
</footer>
```

`in-reply-to.html.twig` is a single `{% trans %}In reply to {{ subject }} by {{ uid }}{% endtrans %}`.

Override either by copying the file into your theme's `templates/` directory — the hook names are
`submitted`, `submitted__comment` and `in_reply_to`, so `submitted--node.html.twig` and
`in-reply-to.html.twig` in a theme both work.

## The re-assembly (`hook_entity_view_alter()`)

This is the part that surprises people. After the display builds each component separately, the
module checks `$build[<owner_key>]['#formatter']`. If it is `submitted` it:

1. Creates `$build['submitted']` with `#theme => 'submitted'`, inheriting the owner component's
   `#weight`, and puts the rendered author into `#author_name` (with `#is_inline = TRUE`).
2. Moves `user_picture` (if the formatter produced one) into `#user_picture`.
3. **Unsets** `$build[<owner_key>]`.
4. If a `created` component exists and its `#field_type` is `created`, moves it into `#date` and
   unsets it — this is why the date disappears from its own slot and joins the sentence.
5. For comments, moves the `pid` component into `#parent` and unsets it.

Consequences:

- Ordering of the sentence is fixed by the template; the `created` component's own weight is
  ignored once absorbed.
- If you want the date rendered **separately**, do not use the `submitted` formatter on `uid` —
  use core's `author` formatter instead and keep `created` as its own component.
- `template_preprocess_submitted()` force-renders `author_name` and `date` into strings (works
  around core issue 2334319), so those variables are markup, not render arrays, in Twig.

## Inline field flag

`_manage_display_preprocess_inline_field()` copies `#is_inline` into an `is_inline` Twig variable
for `field`, `field__node__created` and `field__node__uid`, matching core's inline field templates.

## Comment fix-ups

`manage_display_preprocess_field()` (plus `_manage_display_fix_comment_item()`) restores core
behaviour for saved comments: the `subject` link becomes the comment **permalink** with
`class="permalink" rel="bookmark"`, and the `uid` element gets the comment's owner account so
anonymous commenter names render correctly. It only fires for the formatter pairs
`subject` → `title`/`string` and `uid` → `submitted`/`author`.
