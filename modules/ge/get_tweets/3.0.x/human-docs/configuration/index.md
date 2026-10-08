# Configuration

Get Tweets needs two things before it can import anything: **valid X/Twitter API
credentials**, and at least one **feed** telling it what to pull in. Both are set
up on the module's settings form.

## Before you start: register an X/Twitter application

The module talks to the **paid Twitter v1.1 API**, so you need a developer
account with a paid plan and an application registered in the X/Twitter developer
portal. From that application, copy its **Consumer Key** and **Consumer Secret** —
these are the credentials the module authenticates with.

## Store the credentials as secrets

Your Consumer Key and Secret are sensitive — anyone holding them can act against
your paid API quota. **Do not hard‑code them or commit them to your repository.**
Store them as environment variables and reference them from Drupal.

With DDEV, save the values into the project's dotenv file and restart so the
container picks them up:

```bash
ddev dotenv set .ddev/.env --twitter-consumer-key=<your-key> --twitter-consumer-secret=<your-secret>
ddev restart
```

The flags become the environment variables `TWITTER_CONSUMER_KEY` and
`TWITTER_CONSUMER_SECRET`. Keep `.ddev/.env` out of version control. Where the
module or a Key entity supports reading from an environment variable, point it at
these variables rather than pasting the raw secret into configuration that gets
exported.

> **Egress note:** this module makes outbound HTTPS calls to the X/Twitter API.
> If your environment restricts outbound network traffic, allow egress to the
> Twitter/X API endpoints, or the imports will silently fail.

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → Web services → Get Tweets**
   (`/admin/config/services/get-tweets`).

## The settings, field by field

- **Consumer Key** — the API key from your X/Twitter application. This
  authenticates your requests. Enter it here (or, preferably, reference the
  environment variable holding it).
- **Consumer Secret** — the matching secret for your application. Treat it like a
  password; keep it in an environment variable rather than in exported config.
- **Feeds** — one or more sources to import from. Each feed is defined by a
  **hashtag** or a **user name**, so you can, for example, archive everything a
  particular account posts, or collect every tweet using a campaign hashtag. Add
  as many feeds as you need.
- **Delete old tweets** — an option to prune previously imported tweets after a
  period, so the archive doesn't grow without limit. Leave it off to keep
  everything.

Additional per‑feed options control how imported data is mapped — hashtags,
mentions, and images can be stored in separate fields, with images saved both as
the external link and as a local file.

## Save and run the import

Save the form. Imports happen on **cron**, so tweets appear as nodes after the
next cron run (run `drush cron` to trigger one immediately for testing). Check
**Content** and you should see the imported tweets as nodes.

## A note on displaying imported tweets

Tweet text and media come from an external source. Treat them as untrusted input
on display — rely on Drupal's standard text filtering and image handling rather
than printing raw values — and stay within X/Twitter's API terms and rate limits.
