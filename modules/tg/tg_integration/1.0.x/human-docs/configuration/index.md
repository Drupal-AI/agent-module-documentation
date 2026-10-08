# Configuration

Before Telegram integration can post anything, you need to connect it to a Telegram
bot and tell it where to post. This is done from the module's settings form.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to the Telegram integration settings form (`tg_integration.settings`).

## Connect your Telegram bot

The module authenticates to Telegram with a **bot token** — the token Telegram
gives you when you create a bot. Enter it on the settings form, along with the
channel or chat you want announcements posted to.

**Keep the bot token secret.** Anyone who has it can post as your bot, so treat it
like a password: don't share it, don't paste it where it might be logged, and don't
commit it to version control.

## What gets posted

When content is published, the module sends an announcement to your Telegram
channel. By default the announcement includes the content's **title** and a **link**
back to the node. A **custom message** field is also available, so you can add your
own wording to the post rather than relying on the title alone.

## Displaying Telegram comments

The module can also pull the comments made on a Telegram post and display them
beneath the corresponding content on your site, so the conversation on Telegram
appears alongside the original.

Bear in mind that these comments are **external input** written by people on
Telegram, not by your editors. The module should sanitise and escape that text when
it is shown, and you should make sure it does, so that untrusted content from
Telegram cannot inject scripts into your pages.

## Save

Save the settings form to apply your configuration. Publish a piece of content to
confirm the announcement reaches your Telegram channel as expected.
