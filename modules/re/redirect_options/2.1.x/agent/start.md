<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Options — agent orientation

- `redirect_options.install`: `hook_install` creates the `type_of_redirect` vocabulary + terms
  (Template, Server); `hook_schema` defines table `redirect_options(source PK, type)`.
- `redirect_options.module`: `hook_form_alter` targets forms whose `#attributes.class` contains
  `redirect-form`; adds a `redirect_type` select from the vocabulary. On the edit form it reads
  the current value from the `redirect` table by rid (`$path_args[6]`). A prepended submit
  handler stores the type into the redirect title value and upserts into `redirect_options`.

Security review (sound): NOT an open redirect — it stores a classification term, never a
user-controlled redirect target that gets followed. DB access uses parameterized
`condition()`/`upsert()->fields()`. Depends on `redirect`. Note: the help route name and the
`$path_args[6]` index are brittle but not security issues.
