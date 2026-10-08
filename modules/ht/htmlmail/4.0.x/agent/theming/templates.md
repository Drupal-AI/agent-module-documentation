# htmlmail — theming

Emails are rendered through Twig via the theme hook **`htmlmail`** (registered dynamically in
`htmlmail_theme()` by scanning for `htmlmail*.html.twig` files in the module and the selected
Email theme). The message body is themed at format time in `HtmlMailSystem::format()`.

## Template resolution order

For a message with `$module` and `$key` (the first two args to `MailManager::mail()`), the
first existing file is used:

1. `htmlmail--{module}--{key}.html.twig`
2. `htmlmail--{module}.html.twig`
3. `htmlmail.html.twig`

For each name, HTML Mail looks first in the **selected Email theme's** `templates/` directory,
then in the module's own `templates/`. Suggestions are added in
`htmlmail_theme_suggestions_htmlmail_alter()` as `htmlmail__{module}` and `htmlmail__{module}__{key}`
(underscores; `--` in filenames maps to `__` in suggestion ids).

## Override a template

Copy `modules/contrib/htmlmail/templates/htmlmail.html.twig` into your Email theme's
`templates/` directory (or name it `htmlmail--user--password_reset.html.twig` etc.), then set
`htmlmail.settings:theme` to that theme and rebuild cache (`drush cr`). Templates are cached.

Ships with: `templates/htmlmail.html.twig` (default), `templates/htmlmail--htmlmail.html.twig`,
`templates/htmlmail--user--password_reset.html.twig`.

## Variables available in the template

Set in `template_preprocess_htmlmail()` and documented on the settings form:

- `message.body` — formatted body; also `message.module`, `message.key`, `message.subject`,
  `message.to`, `message.from`, `message.headers`, `message.language`, `message.params`,
  `message.message_id` (`"{module}_{key}"`).
- `debug` — bool; when TRUE the default template appends customization/debug info.
- `theme`, `theme_path`, `theme_url` — selected Email theme name and its paths.
- `module_path` — the htmlmail module `templates` path.
- `module_template` / `message_template` — the `htmlmail--{module}.html.twig` and
  `htmlmail--{module}--{key}.html.twig` names, plus `*_exists` booleans and `theme_html_exists`.
- `pre_formatted_params` — `print_r` of subject+body, shown in debug output.

## Add/modify variables from another module

Implement `MODULENAME_preprocess_htmlmail(&$variables)` (a `hook_preprocess_HOOK`) to inject or
change template variables.

## Echo integration

If the **Echo** module is enabled and a theme is selected, `format()` calls `echo_themed_page()`
to render the body as a fully-themed webpage before any post-filter runs.
