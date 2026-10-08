# cleantalk — api

CleanTalk exposes **no public service you call to protect a form** — protection is wired
automatically. There is nothing to invoke from your own module in the normal case; you
configure `cleantalk.settings` (see [../configure/settings.md](../configure/settings.md))
and the module does the rest.

## How checking is wired (automatic)

`cleantalk.module` implements `hook_form_alter()` (`cleantalk_form_alter`) and attaches a
validate handler to each supported form when its `cleantalk_check_*` toggle is on:

| Form | Validate handler |
|---|---|
| User register | `cleantalk_validate_register` |
| Comment | `cleantalk_validate_comment` |
| Contact message | `cleantalk_validate_contact_message` |
| Forum topic | `cleantalk_validate_forum_topic` |
| Node content | `cleantalk_validate_node` |
| Webform | `cleantalk_validate_webform` |

Each handler builds a request and calls the internal
`\Drupal\cleantalk\CleantalkFuncs::_cleantalk_check_spam(...)`, which sends the submission
to the CleanTalk cloud API and, on a spam verdict, sets a form error. **All of this needs a
valid `cleantalk_authkey` and outbound network access to the CleanTalk API** — with no key
the handlers short-circuit and nothing is checked.

## Internal helpers (in `src/CleantalkFuncs.php`, static)

These are mostly internal (`apbct_` / `_cleantalk_` prefixed) and coupled to module state;
the ones you might drive from code or cron:

- `CleantalkFuncs::apbct_sfw_update($access_key)` — refresh the SpamFireWall blocklist from
  the CleanTalk cloud (the settings form calls this on save when SFW is on).
- `CleantalkFuncs::apbct_sfw_send_logs($access_key)` — push accumulated SFW logs to CleanTalk.
- `CleantalkFuncs::cleantalk_get_user_roles()` / `cleantalk_get_user_roles_default()` — role
  lists used by the exclusions UI.

## Retroactive-scan services

`src/Service/` holds classes behind the "Check spam users / comments" admin screens, e.g.
`UserChecker::checkUsers()`, `UserData` (`totalSpammers()`, `getSpammers()`, `deleteAll()`),
`NodeData`. They are used by the module's own controllers, not registered as reusable public
`@service`s, and every method that classifies spam calls the CleanTalk API.

No hooks are invited for other modules (`cleantalk.api.php` does not exist).
