# content_moderation_notifications — agent start

Sends **emails on content-moderation state transitions**. You define
`content_moderation_notification` config entities (one per workflow + a set of that workflow's
transitions); on a matching transition the module emails the author, whole roles (access-checked),
ad-hoc addresses, and entity-reference user fields — all as **Bcc**, with the site mail as the
visible recipient unless disabled. Subject/body support **tokens and inline Twig**; the body is
filtered through a chosen text format. Depends on core `content_moderation`, `text`, `workflows`
(`token` optional). No Drush commands, no plugin types.

- Set up notifications: config entity, fields, admin UI, `configure` route → [configure/content_moderation_notifications.md](configure/content_moderation_notifications.md)
- The single permission that gates the admin UI → [permissions/content_moderation_notifications.md](permissions/content_moderation_notifications.md)
- Alter recipients / mail data from your module → [hooks/content_moderation_notifications.md](hooks/content_moderation_notifications.md)
- Services, tokens, and how a transition becomes an email → [api/content_moderation_notifications.md](api/content_moderation_notifications.md)
