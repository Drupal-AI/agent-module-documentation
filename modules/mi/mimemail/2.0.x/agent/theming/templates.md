# Theming emails

Theme hook `mimemail_message` renders every HTML message. Default template:
`templates/mimemail-message.html.twig` (a full `<!DOCTYPE html>` document — keep the
`<html>/<head>/<body>` tags if you override it).

## Available variables
`attributes`, `key` (mail key), `module` (sending module machine name), `css` (gathered
stylesheet text), `recipient`, `subject`, `body`, `params`, `langcode`.

## Overriding (theme suggestions)
Copy the template into your theme and rename to target more specific messages. Precedence
(most specific wins), e.g. for core user `password_reset`:
1. `mimemail-message--user--password-reset.html.twig`
2. `mimemail-message--user.html.twig`
3. `mimemail-message.html.twig` (default)

Suggestions are provided by `MimemailHooks::themeSuggestionsMimemailMessage()`
(`mimemail_message__MODULE`, `mimemail_message__MODULE__KEY`);
`templatePreprocessMimemailMessage()` converts underscores to hyphens in `module`/`key`.

## CSS
With `sitestyle` on (and no `mail.css` in the default theme), the theme's stylesheets are
gathered into `css` and inlined into `style=""` attributes so email clients render them.
Place a `mail.css` in your default theme directory to control email styles explicitly (its
presence disables the sitestyle gathering).
