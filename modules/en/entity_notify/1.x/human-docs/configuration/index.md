# Configuration

Entity Notify's settings form is where you decide **what to watch**, **who to
notify**, and **how** the notification is delivered. Open it from the module's
settings in the admin UI, as a user with the **Administer site configuration**
permission.

## Choose which entities and events to watch

Select the entity types Entity Notify should monitor — for example nodes (and,
where offered, specific content types), comments, users, or other entity types on
your site. When an entity of a watched type is **created, edited, or deleted**, the
module sends a notification.

## Choose who gets notified

Entity Notify can send to several kinds of recipient, which you can combine:

- **The site administrator** — user 1.
- **Users in specific roles** — pick one or more roles and everyone in them is
  notified.
- **A custom list of email addresses** — enter the addresses that should receive
  notifications, useful for shared inboxes or people without an account.
- **The node author** — when a new **comment** is posted, notify the author of the
  node that was commented on.

Because notifications can contain entity data, direct them only to inboxes and
people who are allowed to see that data.

## Set up email delivery

Email uses Drupal's standard mail system, so make sure your site can actually send
mail (a configured mail transport / SMTP). Choose the email recipients from the
options above.

## Set up Telegram delivery

To post notifications to a **Telegram** chat:

1. Configure a Telegram **bot** in the **Telegram API** module first — that module
   holds the bot connection. The bot **token is a credential**: keep it out of
   plain, committed configuration by storing it in an environment variable (or a
   Key entity) rather than pasting it into config that ends up in version control.
2. In Entity Notify, enable Telegram delivery and point it at the chat/bot you set
   up.
3. Send notifications only to a **private** Telegram chat, since the messages may
   contain sensitive entity data.

## Save

Save the settings form. Then create a test entity of a watched type and confirm the
notification arrives through the channel(s) you configured.
