# Configuration

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → Web services → Guest suite**
   (`/admin/config/services/guest-suite`).

## Enter your API access token

The main setting is the **access token** the module uses to authenticate to the
Guest Suite REST API. Paste in the token from your Guest Suite account. The module
calls the Guest Suite endpoints over HTTPS.

### Keep the token out of public config

Because the token is stored in configuration (`guest_suite.settings`), keep your
configuration exports out of any publicly readable repository. Following this
project's conventions, prefer storing the token in an environment variable and
surfacing it through a **Key** entity rather than committing the raw value. With
DDEV:

```bash
ddev dotenv set .ddev/.env --guest-suite-token=YOUR_TOKEN_HERE
ddev restart
```

(Never commit `.ddev/.env`.)

## Importing reviews

Once the token is set, reviews can be brought in two ways:

- **Automatically on cron.** Guest suite enqueues fetch and import jobs (into
  separate queues) so reviews sync in the background without creating duplicates.
  You can import all reviews or just the latest ones.
- **Manually.** Trigger an import from the review entity collection page in the
  admin UI when you want to pull the newest reviews on demand.

The module also pulls per‑establishment statistics from the API, so it works for
both single‑ and multi‑establishment accounts.

## Displaying reviews and ratings

- **Review entities** — each review is a `guest_suite_review` content entity, so you
  can build **Views** listings of reviews and ratings and place them anywhere.
- **Establishment block** — a provided block displays all the information for one
  selected establishment.
- **Aggregate tokens** — two tokens expose site‑wide figures for use in blocks or
  templates:
  - `guest_suite_average_rate` — the average review rating.
  - `guest_suite_reviews_total_number` — the total number of reviews.

## Permissions

- **Administer site configuration** — reach the settings form above.
- **Access guest suite review overview** — a dedicated permission that controls who
  can see the review overview page. Grant it to the roles that manage reviews.
