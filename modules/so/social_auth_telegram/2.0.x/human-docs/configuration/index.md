# Configuration

Setting this module up means creating a Telegram bot, telling it which domain your
site uses, and giving Drupal the bot's access token.

## 1. Create a Telegram bot

1. In Telegram, open a chat with **@BotFather**.
2. Send the command `/newbot` and follow the prompts to name your bot.
3. When the bot is created, @BotFather gives you an **access token** — copy it and
   keep it safe. (Telegram's own bot documentation has more detail if you need it.)

## 2. Authorise your site's domain

1. In @BotFather, send the command `/setdomain`.
2. Select your bot and enter your site's domain (for example
   `https://example.com`).

Remember that Telegram treats `www.example.com` and `example.com` as **different
sites**. Choose one canonical form for your site and redirect the other, otherwise
login will fail on whichever version was not authorised.

## 3. Enter the bot token in Drupal

1. Log in as an administrator.
2. Go to **Configuration → Social API settings → User authentication → Telegram**
   (`/admin/config/social-api/social-auth/telegram`).
3. Paste the bot **access token** into the field.
4. Save.

Treat the token as a secret. The most robust approach is to keep it in an
environment variable (surfaced through a Key entity where possible) rather than
committing it to exported configuration.

## 4. Render the login link

Unlike some Social Auth providers, this module surfaces its button through a theme
hook rather than the standard login block. Render the `social_auth_telegram_link`
theme wherever you want the Telegram login control to appear — for example in a
custom block or a preprocess/render array:

```php
return [
  '#theme' => 'social_auth_telegram_link',
  '#info' => [
    'title' => t('Login via telegram'),
  ],
];
```

## Good to know

- **Errors are quiet in this version.** A failed authentication simply redirects
  back to the login form without a visible message, so watch your logs when
  troubleshooting.
- **Account linking:** if a logged-in user authenticates with Telegram, their
  Telegram account is linked to their current profile. If no matching user is found
  for an anonymous visitor, a new account is created.
