# Configuration

Configuring Google Calendar Entity is two steps: set the global options
(including your API key) once, then create a calendar entity for each Google
Calendar you want to display.

## 1. Global settings

Go to `/admin/config/gcal_entity/config` (permission: **Administer gcal entity
entities**). The main fields are:

- **Google API key** — a Calendar‑API‑enabled key from Google. This is the
  credential the module uses to fetch events.
- **API key storage** (`api_storage_key`) — choose where the key is kept:
  - **config** (default) — stored in `gcal_entity.settings`, which means it can be
    included in exported configuration.
  - **state** — stored in Drupal's state (the database), which is **not** exported
    with config. **This is the safer choice** — the key is stored in plaintext
    either way, so keeping it out of config exports reduces the risk of leaking it
    into version control.
- **Start / end** — date strings that bound the range of events fetched.
- **Max events** — the maximum number of events to display.
- **Timezone** — must be a valid timezone identifier.
- **Date and time formats** — how event dates and times are formatted in the
  agenda.
- **Cache time** — how long (in seconds) fetched events are cached. The default is
  **300**; setting it to `0` disables caching, which is **not recommended** because
  every page view then hits the Google API.
- **Link texts** and **no‑events text** — the labels shown for event links and the
  message shown when a calendar has no events.

The form validates your input (the timezone must be a real identifier, the dates
must parse, and so on). Click **Save configuration** when done.

> **Keep the API key secret.** It is stored in plaintext and there is no
> Key‑module integration. Prefer **state** storage, keep config exports private,
> and never commit the key to version control. With DDEV you can hold the value in
> an environment variable (`ddev dotenv set .ddev/.env --google-api-key=<value>`,
> then `ddev restart`).

## 2. Create a calendar

1. Go to **Add GCal entity** (under the site's content/structure, per the entity
   type).
2. Enter the calendar's **ID** — an email‑format address such as
   `xxxxx@group.calendar.google.com`. Remember the calendar must be **public**.
3. **Publish** the entity.

To embed the agenda, add an **entity‑reference field** to a content type that
points at your GCal entity, and the events render in the agenda list format.
Events are rendered through Twig templates you can copy into your theme to
customise.
