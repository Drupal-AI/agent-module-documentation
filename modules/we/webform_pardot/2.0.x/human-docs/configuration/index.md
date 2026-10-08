# Configuration

There is no site-wide settings page. You configure Webform Pardot per webform, by adding its
handler and (optionally) mapping fields. You can add the handler to as many webforms as you
like, each with its own Pardot endpoint.

## Add the Pardot handler to a webform

1. Edit the webform you want to send to Pardot and go to
   **Settings → Emails / Handlers**
   (`/admin/structure/webform/manage/{webform}/handlers`).
2. Click **Add handler** and choose **"Submit data to Pardot"**.
3. Fill in the handler settings:

   | Setting | Required | What to enter |
   |---|---|---|
   | **Pardot URL** (`pardot_url`) | Yes | Your Pardot **Form Handler** endpoint. It is validated as a URL, so paste the full `https://…` address. |
   | **Field mapping** (`pardot_fields_mapping`) | No | One `webform_key\|pardot_key` per line, mapping a Drupal webform element key to the Pardot field name. Any key you don't map is sent through unchanged. |

4. Save the handler.

Only one Pardot handler can be added per webform (the handler is single-cardinality).

### Field mapping syntax

Each line maps one field: the webform element key on the left, the Pardot field name on the
right, separated by a pipe. For example:

```
email|email
first_name|FirstName
company|Company
```

You can also drill into **complex/composite** element values using dot or bracket paths, for
example `person.name|name` or `person[name]|name`.

## How submissions reach Pardot

1. When a visitor submits the webform, the handler creates a `pardot_submission` log entity
   with status **queued** and adds it to the cron queue. The visitor's submission completes
   immediately — nothing is sent inline.
2. On the next **cron** run, the queue worker loads the submission, remaps the data per your
   mapping, and POSTs it to your Pardot URL as a standard form post over a verified HTTPS
   connection.
3. The Pardot response is inspected and the log entity's status is set to **processed** or
   **error**:
   - A response body containing **"field is required"** is recorded as an error (usually
     meaning that Pardot field is required but you didn't send it — make it required on the
     webform or add it to the mapping).
   - A **5xx** status is recorded as a Pardot server error; other non-success statuses as a
     generic error.
   - The status code and a short (≤500-character) log are stored on the entity.

Because delivery is on cron, make sure cron runs regularly on your site.

## Review Pardot submissions

- Go to **Structure → Webforms → Pardot submissions**, or navigate directly to
  `/admin/structure/webform/pardot_submissions`, to see every submission with its status and
  log — a useful audit trail and the first place to look when a lead didn't arrive.
- You can **delete** stored submission log entities from there.
- Both viewing and deleting require the **View pardot submission** permission — grant it to the
  roles who manage lead delivery.

## Programmatic use

The `webform_pardot.pardot_handler` service exposes `submitDataToPardot()` for triggering a
send from your own code, and you can enqueue a submission manually. Those are developer-facing —
see the [`agent/`](../../agent/start.md) docs (`api/handler.md`).
