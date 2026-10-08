# Configure the Views Conditional field

Views Conditional adds no admin settings form and no config entity. All configuration is per
field, inside a view. The handler is the Views field `views_conditional_field`, listed in the
"Add fields" dialog as **Views: Views Conditional** (group *Views*, help "Output data based
off of certain criteria.").

## Add it

1. Edit a view → **Fields** → **Add**.
2. Add the fields you want to test FIRST. Set each source field to **Exclude from display**
   so only the conditional output is shown.
3. Add **Views: Views Conditional** (near the bottom of the field list). It has no query, so
   it can only read fields **rendered before it** — place it AFTER every field it references.

## Field option settings

Configured in the field's settings form (`buildOptionsForm`); stored in the view config,
schema `views.field.views_conditional_field`:

| Option | Widget | Meaning |
|---|---|---|
| `if` | select | Which earlier field to test (only fields above this one are listed) |
| `condition` | select | The comparison operator (see below) |
| `equalto` | textfield | Value to compare against; accepts replacement tokens |
| `then` | textarea | Output when the condition is TRUE; accepts replacement tokens |
| `then_translate` | checkbox | Translate the Then text before token substitution (default on) |
| `or` | textarea | Output when the condition is FALSE (optional); accepts tokens |
| `or_translate` | checkbox | Translate the Or text before token substitution (default on) |
| `strip_tags` | checkbox | Strip HTML tags from the output (default off) |

Validation requires `if`, `condition`, and (except for the empty operators) `equalto`.

## Operators (`condition` values)

`eq` Equal to · `neq` NOT equal to · `gt` Greater than · `gte` Greater than or equals ·
`lt` Less than · `lte` Less than or equals · `em` Empty · `nem` NOT empty ·
`cn` Contains · `ncn` Does NOT contain · `leq` Length Equal to · `lneq` Length NOT equal to ·
`lgt` Length Greater than · `llt` Length Less than.

The tested field's rendered value has HTML tags stripped (except `<img><video><iframe><audio>`)
before comparison. `contains`/`does not contain` are case-insensitive (`mb_stripos`); length
operators use `mb_strlen`.

## Replacement tokens

Usable in `equalto`, `then`, and `or`:

- `{{ field_machine_name }}` — the rendered value of any field placed ABOVE this one. The
  settings form lists the available field names under "Replacement Variables".
- `DATE_UNIX` — current request time as a UNIX timestamp.
- `DATE_STAMP` — current request time in the site's default date format.
- To output literal brackets, use `%5D` for `[` and `%5E` for `]`.

## Notes

- The field is not click-sortable (`clickSortable()` returns FALSE).
- `then_translate`/`or_translate` translate with context `views_conditional:view:{view_id}`,
  applied before replacements so dynamic values don't create endless translation strings.
