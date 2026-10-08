# Configuration

Setup has two halves: prepare a Google service account on the Google side, then tell
Drupal about it. Take your time with the Google steps — most problems come from the
service account not being shared onto the calendar you want to read.

## 1. Create a Google Cloud project and service account

1. Go to the [Google Cloud console](https://console.developers.google.com/projectcreate)
   and create a project.
2. In the project, open **APIs & Services** and enable the **Google Calendar API**.
3. Create a **service account** in the project, then create a **key** for it and
   download the **JSON** credentials file. Note the service account's **email
   address** (shown on the *Service account details* page) — you'll need it.

## 2. Share your calendar with the service account

Open the Google Calendar you want to import from, find **Share with specific people
or groups**, and add the **service account email address** as a person the calendar
is shared with. Without this, the service account cannot see the calendar's events.

## 3. Configure the module in Drupal

1. Go to **Configuration → Google Calendar Service → Settings**
   (`/admin/config/google-calendar-service/settings`).
2. **Upload the service‑account JSON** key file you downloaded.
3. In the **Google User Email** field, enter the **service account e‑mail address**
   (this is the service account, *not* your personal Google email).
4. Save the form.

## 4. Add a calendar and import events

1. Go to `/calendar/add`.
2. **Name** — a label for the Calendar entity in Drupal.
3. **Google Calendar ID** — the ID of the calendar to read (for a personal calendar
   this is typically the owning Google account's email address).
4. Save, then go to `/calendar`, and under **Operations** for your calendar click
   **Import Events**. Importing can take a little while; afterward the events show up
   under that calendar.

## Storing the service‑account key securely

The JSON key file is a real secret — anyone with it can act as the service account.

- Keep the file **outside the web root** and **out of version control**.
- Restrict the service account to only the Calendar API and only the calendars it
  needs (scope the delegation minimally).
- If the key is ever exposed, **rotate it** in the Google Cloud console.
