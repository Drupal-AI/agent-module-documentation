# Configuration

There is no central settings page. You turn uniqueness on where the field (or
title) is defined, and the options are stored with that field or content type.

## Make a field unique

The **Unique field settings** fieldset appears on a field's settings form
(*Structure → Content types → your type → Manage fields → Edit* for the field),
but only when the field is:

- **single-cardinality** (set to store one value, not multiple), and
- one of these types: text (`string`, `string_long`, `text`), list (text),
  email, entity reference, path, URI, link, integer, decimal, or color.

If a field is later changed to allow multiple values, the fieldset disappears and
uniqueness no longer applies.

Tick **Unique** and, optionally, the sub-options below, then save the field.

## Make a content type's title unique

To stop editors creating two nodes of the same type with the same title, open
*Structure → Content types → Add/Edit* for that type and use the **Unique title
settings** fieldset. It offers the same options and applies them to the node
title.

## The options, one by one

- **Unique** — the master switch. When off, the whole uniqueness block is cleared
  from the field or content type on save.
- **Per language** — only forbid duplicates *within the same language*. Handy on
  multilingual sites where the same value is legitimately reused across
  translations. Leave it off to forbid duplicates regardless of language.
- **Case sensitive** — when on, "Acme" and "acme" are treated as **different**
  values (an exact, case-sensitive match). When off (the default), they are
  treated as the **same** value and would collide.
- **Use AJAX** — add live validation as the editor types. Instead of only finding
  out at submit time, they get an inline error or warning shortly after they stop
  typing (the check is throttled, so it does not fire on every keystroke).
- **Don't enforce (warn only)** — when on, a duplicate value shows a **warning**
  but still lets the editor save. When off (the default), a duplicate is a hard
  form error that blocks the save.
- **Message** — a custom **error** message shown when a duplicate blocks the save.
  You can include the placeholder `%link` (a link straight to the conflicting
  content) and `%label` (the field's label).
- **Warning message** — a custom message shown when **Don't enforce** is on. It
  supports the same `%link` and `%label` placeholders.

## Where it is stored (and scripting it)

Your choices are saved as third-party settings on the field's config entity
(`field.field.<entity>.<bundle>.<field>`) or, for titles, on the content type
(`node.type.<bundle>`), so they export and deploy like any other configuration.

To set it from the command line — for example, make an existing Article field
unique and case-sensitive:

```bash
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_code");
  $fc->setThirdPartySetting("unique_field_ajax", "unique", 1);
  $fc->setThirdPartySetting("unique_field_ajax", "case_sensitive", 1);
  $fc->save();
'
```

## How the check behaves

When a value is entered, the module looks for another entity of the same bundle
that already uses it (excluding the content being edited), optionally narrowed by
language, using an exact or case-insensitive comparison depending on your **Case
sensitive** choice. If a match is found and enforcement is on, the save is
blocked; if **Don't enforce** is on, the editor sees a warning and can continue.
It also works inside inline entity forms and media library upload forms.
