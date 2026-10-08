<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: name formats, pattern tokens, settings & list formats

## Admin routes (all gated by core `administer site configuration`)
- `/admin/config/regional/name/settings` — global settings form (route `name.settings`).
- `/admin/config/regional/name` — list of `name_format` entities (`name.name_format_list`);
  add at `/admin/config/regional/name/add`, edit/delete at `.../manage/{id}`.
- `/admin/config/regional/name/list` — `name_list_format` entities (join several names).

## `name.settings` config object
Keys (see `config/install/name.settings.yml`, schema `name.settings`):
- `sep1` (default `' '`), `sep2` (default `', '`), `sep3` (default `''`) — the three
  separators referenced by pattern tokens `i`, `j`, `k`.
- `component_required_marker` (default `'*'`) — marker shown on required components.
- `user_preferred` (default `''`) — machine name of the Name field that overrides a user's
  login/display name (set from the field settings form on a User name field, not this form).

```
drush cget name.settings sep2                 # read a separator
drush cset name.settings component_required_marker '†' -y
```

## `name_format` config entity
Config prefix `name_format`; exported keys: `id, uuid, label, status, langcode, locked,
pattern`. The `pattern` is the whole engine. Ships (in `config/install`): `default`, `full`,
`family`, `given`, `formal`, `short_full`. `default` and its pattern:
`((((t+ig)+im)+if)+is)+jc` which renders `Mr. John Peter Smith Jr., PhD`.

```
drush cget name.name_format.default pattern    # -> ((((t+ig)+im)+if)+is)+jc
drush cget name.name_format.family pattern      # -> f
```

Create one in code:
```php
\Drupal\name\Entity\NameFormat::create([
  'id' => 'my_fmt', 'label' => 'Surname first', 'pattern' => 'f, g',
])->save();
```
`locked: true` (as on `default`) blocks deletion via the UI.

## Pattern token letters
Lowercase components: `t` title · `g` given · `m` middle · `f` family · `c` credentials ·
`s` generational suffix · `p` preferred (falls back to given) · `q` preferred · `a`
alternative value.
First-letter: `v` preferred · `w` preferred-or-given · `x` given · `y` middle · `z` family ·
`A` alternative.
Initials: `I` given+family · `J` given+middle+family · `K` given · `M` given+middle.
Conditionals (pick one of two components): `e`/`E` given-or-family (given/family preferred),
`d`/`D` preferred-or-family.
Separators: `i` = sep1, `j` = sep2, `k` = sep3.
Modifiers (apply to the *next* token): `L` lowercase · `U` uppercase · `F` ucfirst ·
`G` ucfirst all words · `T` trim · `S` make safe · `B` first word · `b` last word.
`\` escapes the next character so it is output literally.

### The `+` operator and parentheses
`+` is a **conditional join**: in `a+b` the piece is only emitted when its neighbours are
present, so separators collapse around empty components (no leading/trailing/double
separators). Parentheses group pieces, e.g. `(t+ig)` = title, then sep1 then given, but the
sep1+given only appear if given exists. This is why `((((t+ig)+im)+if)+is)+jc` degrades
gracefully for names missing a title, middle, suffix, or credentials.

## `name_list_format` config entity
Config prefix `name_list_format`. Keys: `delimiter`, `and` (last-delimiter type),
`delimiter_precedes_last`, `el_al_min` (reduce to "et al." past N names), `el_al_first`
(how many to show first). Used by the formatter/`formatList()` to render author lists like
`Smith, Jones and Doe` or `Smith et al.`.

## Markup modes (formatter / parser `markup` setting)
`none`, `raw` (unescaped), `simple` (component CSS classes), `microdata` (itemprop), `rdfa`.
