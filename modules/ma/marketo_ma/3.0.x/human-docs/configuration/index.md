# Configuration

Marketo MA is configured from its main **Marketo MA settings** form (route
`marketo_ma.settings`), reached from the **Configuration** area. Open it as a user
who holds the restricted‑access **administer marketo** permission.

The exact fields depend on which submodules you enabled, but the setup falls into a
few groups.

## 1. Connect to Marketo

- **Munchkin account ID** — the identifier Marketo gives your subscription; required
  for the tracking script.
- **REST API credentials** — for API‑based capture and synchronisation you provide a
  **client ID**, a **client secret**, and your Marketo **REST endpoint** and
  **identity** URLs. These come from a Marketo LaunchPoint service you create in
  Marketo.

See "Store the API credentials safely" below before typing the secret anywhere.

## 2. Munchkin tracking

- Choose whether to add the **Munchkin tracking script** to pages.
- Use the **path** include/exclude filters to control which pages are tracked, and
  the **role** include/exclude filters to control which users are tracked. This is
  where you can, for example, exclude administrators or restrict tracking to
  specific sections.

Remember that Munchkin ties browsing to an identified person once they are known to
Marketo — decide deliberately (and with consent where required) who and what to
track.

## 3. Lead capture

- Capture leads using **Munchkin's JavaScript** or through the **API**.
- API‑based capture can be **synchronous** (sent immediately) or **asynchronous**
  (queued and sent during cron), which spreads the load and avoids slowing down the
  request that triggered it.
- With the **User** submodule, choose which user actions trigger capture —
  **creation**, **update**, and/or **login**.

## 4. Field mapping

Map your Drupal fields to Marketo fields so the right data lands in the right place:

- With **marketo_ma_user**, map **user profile fields** to Marketo fields.
- With **marketo_ma_webform**, map **webform components** to Marketo fields and set a
  custom **LeadSource** per webform.

## Store the API credentials safely

The REST client ID and secret are a live grant over your Marketo database, so keep
them out of the database and out of version control. The recommended pattern is an
environment variable surfaced through a **Key** entity.

With DDEV, store the secret as an environment variable and load it into the
container:

```bash
ddev dotenv set .ddev/.env --marketo-client-secret=YOUR_SECRET_HERE
ddev restart
```

That exposes it inside the container as `MARKETO_CLIENT_SECRET` (keep `.ddev/.env`
out of version control). Confirm it is present *without* printing it:

```bash
ddev exec 'test -n "$MARKETO_CLIENT_SECRET" && echo set'
```

If you use the **Key** module, create a Key backed by that environment variable and
reference it from the Marketo settings, rather than pasting the secret into the form.
Scope the Marketo LaunchPoint service as narrowly as Marketo allows.

## Permissions

At **People → Permissions** (`/admin/people/permissions`), grant **administer
marketo** — a restricted‑access permission — only to trusted administrators, since it
controls the connection to your marketing database and the tracking of your
visitors.

## Privacy checklist

- Add Munchkin tracking to your **privacy notice** and gate it behind **consent**
  where required — it builds an identified profile, not aggregate stats.
- Disclose lead capture on every form that feeds Marketo; personal data leaves the
  site on submission.
- Review your **path and role filters** so you are only tracking what you intend to.
