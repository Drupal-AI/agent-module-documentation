<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: `arguments.settings`

Source: `src/Form/ArgumentSettingsForm.php`, install defaults
`config/install/arguments.settings.yml`. Route `argument.settings` at
`/admin/structure/argument/settings` (permission `administer argument entities`), also linked in
the admin menu under Structure → "Arguments" (`arguments.links.menu.yml`). **No `config/schema/`
directory ships**, so `provides_config_schema` is false.

## Config object `arguments.settings`

The values are nested under a top-level `arguments:` key:

```yaml
arguments:
  max_argument_name_length: '256'
  max_argument_text_length: '512'
  revisions_default: true
  arguments_node_types: {}
```

- `arguments.max_argument_name_length` — advisory max title length (the `name` base field itself
  is hard-capped at 80).
- `arguments.max_argument_text_length` — enforced in `ArgumentForm::validateForm()`: if the body
  `strlen` exceeds this, a form error is set.
- `arguments.revisions_default` — when true, the edit form's "create new revision" checkbox is
  pre-checked and disabled for users without `allow to omit creation of new argument revisions`.
- `arguments.arguments_node_types` — a `checkboxes` map of `node_type => enabled`. The
  Argumentation block only renders on nodes whose type is enabled here.

## Settings form

`ArgumentSettingsForm` extends `ConfigFormBase`; `getEditableConfigNames()` returns
`['arguments.settings']`, form id `arguments`. It builds number fields for the two length limits,
a `checkboxes` of all node types (loaded from `node_type` storage) for `arguments_node_types`,
and a `revisions_default` checkbox. On submit it writes the four keys and calls
`Cache::invalidateTags(['argument_list', 'rufi_block'])`.

## Operating it

1. `composer require drupal/arguments` (pulls `drupal/vote`); `drush en arguments -y`.
2. Visit `/admin/structure/argument/settings`, tick the content types that should accept
   arguments, set length limits and default revisioning.
3. Grant permissions (add/edit/delete/view + revision perms) at `/admin/people/permissions`.
4. Place the "Argumentation" block (category RulesFinder) on the node context — see
   [../block/argumentation.md](../block/argumentation.md).
