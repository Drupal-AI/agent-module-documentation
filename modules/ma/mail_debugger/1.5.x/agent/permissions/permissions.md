# Mail Debugger — permissions

Defined in `mail_debugger.permissions.yml`.

| Permission (label) | Machine name | Grants |
|---|---|---|
| Access Mail Debugger | `access mail_debugger` | Reach both mail-debugger admin pages and send test mail through them |

Both routes require this single permission and nothing else:

| Route | Path | Form |
|---|---|---|
| `mail_debugger.wizard` | `admin/config/development/mail_debugger` | `MailDebuggerForm` — free-text to / subject / body |
| `mail_debugger.user` | `admin/config/development/mail_debugger/user` | `UsermailDebuggerForm` — core user-notification mail to a chosen user |

There is no separate permission per form: granting `access mail_debugger` grants access to both.

Grant via drush:

```
drush role:perm:add <role> 'access mail_debugger'
```
