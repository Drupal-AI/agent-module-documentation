# Configuration

PostHog's base settings live at **Configuration → Web services → PostHog settings**
(`/admin/config/services/posthog`). They connect Drupal to your PostHog project and control how
visitors are identified. The individual tracking behaviours come from the submodules you enable
(see [Installation](../installation/index.md)).

## Open the settings form

1. Log in as a user with permission to administer the site's services configuration.
2. Go to **Configuration → Web services → PostHog settings**, or navigate directly to
   `/admin/config/services/posthog`.

## PostHog host

The **host** is the address of your PostHog instance — PostHog Cloud (for example
`https://app.posthog.com` or the EU host) or the URL of your self‑hosted PostHog. Events are sent
here, so make sure it matches the project whose API key you use below.

## API key

The **project API key** authenticates Drupal to your PostHog project. Enter the key from your
PostHog project settings.

> **Treat the API key as a secret.** Rather than committing it to exported configuration and
> version control, store the value in an environment variable (with DDEV,
> `ddev dotenv set .ddev/.env --posthog-api-key=…` then `ddev restart`) and reference it — for
> example through a **Key** entity where supported — so the raw key stays out of the database
> export and the repository.

## User identification

Choose how PostHog identifies the people it tracks. You can identify authenticated users by their
**Drupal user ID**, **email**, or **username**, and configure which additional **user
properties** to send. Be conservative here — sending an email or username to an analytics service
is personal data, so only enable it if you genuinely need it and have disclosed it.

## Anonymous user tracking

An option lets you also create person profiles for **anonymous** visitors, not just logged‑in
users. This gives you fuller analytics but means you are profiling everyone who visits, so weigh
it against your privacy obligations and pair it with consent (below).

## Consent and privacy

Because this module loads a third‑party tracker and sends behavioural data to PostHog, gate
client‑side tracking behind user **consent**:

- Enable **PostHog COOKiES** (`posthog_cookies`) to integrate with the COOKiES consent module —
  it even supports a cookieless server‑hash mode for anonymous tracking when consent is denied.
- Or enable **PostHog Klaro** (`posthog_klaro`) to integrate with the Klaro consent manager.

Whichever you choose, disclose the tracking in your site's privacy policy and avoid capturing PII
you don't need.

## Save

Click **Save configuration**. Once the host and API key are set and a tracking submodule is
enabled, events begin flowing to your PostHog project (subject to consent).
