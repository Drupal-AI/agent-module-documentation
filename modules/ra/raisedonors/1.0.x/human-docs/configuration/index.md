# Configuration

Open the settings form at **Configuration → RaiseDonors**
(`/admin/config/raisedonors`). You need the **administer raisedonors module settings**
permission. The recommended order is: start in Test mode, store the API token in a
Key, test the connection, set the webhook token, choose a sync schedule, then switch
to Live.

## 1. Start in Test mode

Select **Test** mode while you set up the integration, so you can verify everything
before it acts on live data.

## 2. Store the API token in a Key

The module reads the RaiseDonors API token through the **Key** module rather than a
plain config field. Create a Key that holds your RaiseDonors API token, then select
that Key from the dropdown on the RaiseDonors settings form.

Back the Key with an environment variable so the secret never lands in the codebase or
exported configuration. On DDEV, the built‑in dotenv helper keeps it out of the repo:

```bash
ddev dotenv set .ddev/.env --raisedonors-api-token='your-token'
ddev restart
```

(`.ddev/.env` must stay out of version control.) Then create a Key that uses the
environment‑variable provider pointing at that variable, and choose it on the form.

## 3. Test the connection

Click **Test API Connection** to confirm the token and settings are correct before
going further.

## 4. Configure the webhook security token

RaiseDonors can notify your site in real time via webhook endpoints:

- `https://your-site.example/raisedonors/webhook/donor-created`
- `https://your-site.example/raisedonors/webhook/donor-updated`
- `https://your-site.example/raisedonors/webhook/donor-deleted`

These URLs must be fully qualified and reachable from the internet (replace the host
with your real domain). To secure them, create a **webhook security token** in your
RaiseDonors account and enter the **same** token in the module's settings form. The
module validates that token on incoming webhook requests, so only RaiseDonors can
trigger them.

## 5. Choose a synchronization schedule

- **Automatic sync frequency** — Never, Daily, Weekly, or Monthly. Scheduled syncs run
  during Drupal's **cron**, so make sure cron is configured and running.
- **Sync Donors Now** — a button that runs an immediate full synchronization: it
  connects to RaiseDonors, retrieves all donors in batches, creates or updates a Drupal
  user for each, shows a progress bar, and reports a summary when done.

## 6. Switch to Live

Once the connection test passes and you are happy with the setup, switch from **Test**
to **Live** mode to activate the integration against real donor data.

## Reviewing donors

Synced donors appear in the donor management view at **`/admin/donors`**, and the
module records detailed sync statistics and logs. Because donor records are personal
data, restrict who can reach the settings form and the donor view.
