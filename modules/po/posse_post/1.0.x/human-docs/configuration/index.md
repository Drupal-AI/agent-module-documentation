# Configuration

POSSE Post is configured under **Configuration → Web services → POSSE Post**. There are two
parts: global settings, and one **social account** per platform you want to syndicate to. Unlike
most modules, its **credentials are not entered on a form** — they are read from environment
variables, so they stay out of the database and out of version control.

## The master switch: `SEND_CROSSPOSTS`

Nothing is actually sent to social networks unless the `SEND_CROSSPOSTS` environment variable is
set to `1`. This is deliberate: it lets you run the same code on development and staging without
accidentally posting. Set `SEND_CROSSPOSTS=1` **only in your production environment**.

With DDEV you can set environment variables like this:

```bash
ddev dotenv set .ddev/.env --send-crossposts=1
ddev restart
```

(Keep `.ddev/.env` out of version control.)

## Add a social account

On the **Social Accounts** page, add an account for each platform you want to crosspost to
(Bluesky, Mastodon, Facebook, Instagram, LinkedIn). Each account's form shows you the **exact
environment variable names** you need to set for that platform's credentials — obtain the values
by following the per‑platform setup guides in the module's documentation, then set those
variables in your environment.

> **Treat every platform token as a secret.** A social token can post as your account. Set the
> values as environment variables (with DDEV, `ddev dotenv set .ddev/.env --<var>=<value>` then
> `ddev restart`), never in exported configuration or the repository. All platform traffic goes
> out over HTTPS to each network's API, so expect outbound (egress) requests when crossposts are
> sent. If you have installed `vlucas/phpdotenv`, you can instead keep these variables in a
> project‑root `.env` file.

## Per‑account posting options

For each account you can tune how the crosspost is built:

- **Field mapping** — which node fields supply the crosspost's content.
- **Format string** — a template that shapes the text of the post.
- **Character‑limit truncation** — trims the text to the platform's maximum length.
- **URL appending** — adds the canonical link back to your site.
- **CamelCase hashtags** — optionally generated from the node's taxonomy terms.

## Global settings and status

The global settings cover behaviour shared across accounts. Each crosspost's **status** is
tracked as *pending*, *published*, or *failed*, and from the admin UI you can **retry** a failed
crosspost or **publish** a pending one immediately rather than waiting for cron.

## How sending happens

When you publish a node, POSSE Post queues a crosspost for each configured account. Queued items
are processed on the next **cron** run (or immediately from the UI) — but only when
`SEND_CROSSPOSTS=1`. For host‑specific credential storage (for example Pantheon Secrets
Manager), see the Hosting section of the module's documentation.
