A developer utility that stores reusable, translatable email message templates as config entities and sends them through a manager service that replaces variables and optionally logs each send.

---

Email Messages gives site builders and developers a central place to author notification emails. Each message is a `email_message` configuration entity holding a subject and a rich-text body (a `text_format` field), authored at `/admin/structure/email-message` and translatable through core config translation. The body supports `@variable` placeholders that the `email_messages.manager` service replaces at send time via `FormattableMarkup`, so tokens are escaped as they are substituted. The manager renders the body in the site's front-end theme, hands it to core's mail system through `hook_mail()` (an HTML `notification` mail key), and — when a message has "Log the message" enabled — writes a `email_message_log` content entity recording the recipient, the resolved message, the language and the sender. A bundled view and list builder expose those logs at `/admin/structure/email-message-logs`. It ships no UI for actually triggering sends; other modules call `EmailMessageManager::getMessage()` and `mailMessage()` from their own code. Depends only on core `text`; supports Drupal 9, 10 and 11.

---

- Centralise notification email copy in one admin screen instead of hard-coding strings in code.
- Author an email subject and rich-text (basic_html) body per message as a config entity.
- Provide translatable email templates via core configuration translation.
- Use `@variable` placeholders in the body and subject that get replaced at send time.
- Load a prepared message by machine name with `EmailMessageManager::getMessage($id, $tokens, $langcode)`.
- Send a prepared message to a recipient with `EmailMessageManager::mailMessage()`.
- Pass render arrays as token values and have them rendered before substitution.
- Render email bodies in the site's default front-end theme rather than the admin theme.
- Send messages as HTML email through core's mail manager and `hook_mail()`.
- Load a message in a specific language for multilingual notifications.
- Optionally log every send of a given message to a `email_message_log` entity.
- Record recipient email, rendered message, message reference, language and author for each logged send.
- Attach extra field values to a log record via the `log_message_values` param.
- Browse sent-message logs in a bundled view at `/admin/structure/email-message-logs`.
- Filter the log view by recipient email, author, or referenced message.
- Manage log entities (view/edit/delete) through the generated admin routes.
- Add custom base-field data to log entities via Field UI on the log entity type.
- Build order/registration/account notification flows in a custom module on top of these templates.
- Let editors reword transactional emails without a code deploy.
- Keep an audit trail of which notification went to which address and when.
- Reuse one template across several code paths that each supply different tokens.
- Separate email content authoring (site builders) from sending logic (developers).
- Ship default messages as config in a module's `config/install`.
- Extend log filtering in custom views using the `email_message` Views filter plugin.
