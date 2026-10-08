# Mechanism: decorated link builder + auto-flag after login

## Service override

`Drupal\flag_anon\FlagAnonServiceProvider::alter()` reassigns the class of Flag's
`flag.link_builder` service to `Drupal\flag_anon\FlagAnonLinkBuilder` (extending
`Drupal\flag\FlagLinkBuilder`) and injects `current_user` and `module_handler`.

`FlagAnonLinkBuilder::build($entity_type_id, $entity_id, $flag_id)`:
1. Loads the flag; if its `flag_anon.enabled` third-party setting is truthy **and** the
   current user is anonymous, it computes the action (`flag`/`unflag`) and checks
   `$flag->actionAccess($action, $currentUser, $entity)`.
2. If access is **not** allowed, it returns `buildAnonMessage()` — a `#theme =>
   flag_anon_message` render array (cache contexts `user.roles:anonymous`,
   `languages:language_interface`). Otherwise it falls back to the parent's normal link.

`buildAnonMessage()` builds the `@login` / `@register` placeholder links, runs
`hook_flag_anon_message_placeholders_alter()`, and interpolates them into the configured
`message` with `FormattableMarkup`. With `label_display: original` it keeps the flag's short
text as the label and renders the message hidden in a popin (attaching the `flag_anon/message`
library); with `custom` it replaces the label outright. When `popup` is set it attaches
`core/drupal.dialog.ajax` and adds `use-ajax` + `data-dialog-options` to the links.

## Auto-flag after authentication

The login/register links carry a query parameter built by
`FlagAnonLinkBuilder::setUrlRouteParams()`:

```
?flag_anon=<flag_id>-<entity_id>&destination=<current path>
```

- Param name: `FlagAnonLinkBuilder::$flagGetParam` = `"flag_anon"`.
- Delimiter between flag id and entity id: `$flagGetParamDelimiter` = `"-"`.

`flag_anon_form_user_login_form_alter()` and `flag_anon_form_user_register_form_alter()`
append `flag_anon_set_entity_flagged()` as a submit handler. After a successful login/register
it reads the `flag_anon` query param, splits it into `[flag_id, entity_id]`, loads the flag
and entity, and calls `\Drupal::service('flag')->flag($flag, $entity)` — so the action the
anonymous user originally attempted is completed automatically once they have an account.

## Theme hook

`flag_anon_theme()` registers `flag_anon_message` with variables `label`, `message`,
`attributes`, `label_attributes`, `flag`, `flaggable` (template
`templates/flag-anon-message.html.twig`; assets in `css/` and `js/`, library `flag_anon/message`).
