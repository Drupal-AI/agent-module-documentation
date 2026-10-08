<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three field formatters

The module **defines no plugin types**; it provides three `@FieldFormatter` plugins
(provider `manage_display`). All three are annotation-based (not attributes) in 3.0.x.

## `title` — `TitleFormatter extends StringFormatter`

- Field types: `string`. Applicable to any string field, but intended for `title` / term `name` /
  comment `subject`.
- `defaultSettings()` = `['tag' => 'h2', 'link_to_entity' => TRUE]`.
- `tag` options: `span`, `div`, `h1`, `h2`, `h3`, `h4`, `h5`.
- `viewElements()` simply wraps each item with `#prefix = "<$tag>"` / `#suffix = "</$tag>"` on top
  of `StringFormatter`'s output, so `link_to_entity` still produces the `<a>` inside the tag.
- Settings summary adds "Display as `<tag>`".
- Config schema `field.formatter.settings.title` extends `field.formatter.settings.string` and
  adds the `tag` string.

```yaml
title:
  type: title
  label: hidden
  settings:
    link_to_entity: false
    tag: h1
```

## `submitted` — `SubmittedFormatter extends AuthorFormatter` (user module)

- Field types: `entity_reference`. Meant for the entity type's **owner** key (`uid`).
- `defaultSettings()` = `['user_picture' => '']` — a **user view mode id**, or `''` for none.
  The settings form lists `- None -` plus every view mode of the reference's target type.
- Settings summary: "User picture view mode: @mode", else "No user picture".
- `viewElements()` calls `AuthorFormatter` then, when `user_picture` is set, renders the account
  through that view mode into `$elements['user_picture']`.
- Config schema `field.formatter.settings.submitted` has one key, `user_picture`.

The single-sentence "Submitted by X on Y" markup is *not* produced by the formatter — see
[../theming/templates.md](../theming/templates.md); `hook_entity_view_alter()` assembles it.

```yaml
uid:
  type: submitted
  label: hidden
  settings:
    user_picture: compact
  weight: -50
  region: content
```

## `in_reply_to` — `InReplyToFormatter extends FormatterBase`

- Field types: `entity_reference`; `isApplicable()` restricts it to **`comment` entity type,
  field name `pid`** only — it will not be offered anywhere else.
- No settings at all (no schema entry needed).
- For each referenced parent comment it renders the parent's `subject` (as `string` with
  `link_to_entity: TRUE`) and `uid` (as core's `author` formatter) into an `in_reply_to` themed
  element → "In reply to *subject* by *author*". New (unsaved) parents are skipped.

## Checking the plugins live

```bash
drush php:eval '$m = \Drupal::service("plugin.manager.field.formatter");
foreach (["title","submitted","in_reply_to"] as $id) {
  $d = $m->getDefinition($id);
  print "$id provider=" . $d["provider"] . " class=" . $d["class"] . "\n";
}'
```

Expect `provider=manage_display` and classes under
`Drupal\manage_display\Plugin\Field\FieldFormatter\`.

## Extending

There is no plugin manager to extend. To customise, subclass a formatter (e.g. `TitleFormatter`)
in your own module and register a new `@FieldFormatter` id, or override
`field.formatter.settings.title` behaviour with `hook_field_formatter_settings_summary_alter()` /
`hook_field_formatter_third_party_settings_form()`.
