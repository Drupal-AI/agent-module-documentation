# Configuration

H5P Challenge's settings live at **Configuration → System → H5P Challenge**
(`/admin/config/system/h5p_challenge`). You'll need the **Access administration
pages** permission to open it (this is an admin route). Settings are stored in
the `h5p_challenge.config` configuration object.

## The settings

- **reCAPTCHA site key** and **reCAPTCHA secret key** — the Google reCAPTCHA
  credentials for your site. Challenge creation is verified server-side against
  `https://www.google.com/recaptcha/api/siteverify`, so both keys must be set
  for people to be able to start challenges. Get them from the Google reCAPTCHA
  admin console.
- **Challenge durations** — how long a challenge stays open before it ends
  automatically. Cron ends challenges whose time is up and sends the "challenge
  ended" notice, so this works hand-in-hand with your cron schedule.
- **Notification / email options** — the settings that control the emails sent
  when a challenge is created and when it ends.

Click **Save configuration** when you're done.

## Make sure cron runs hourly

Two things depend on cron: ending challenges when their duration expires, and
sending the "challenge ended" notification, along with general cleanup. Configure
a real system cron to run **at least hourly** so these happen on time.

## Optional: richer / attachment emails

By default the module sends plain-text emails. If you want attachments or
HTML-formatted email:

1. Install the [Mail System](https://www.drupal.org/project/mailsystem) and
   [Mime Mail](https://www.drupal.org/project/mimemail) modules.
2. In Mail System, set the H5P Challenge mail formatter to **Mime Mail Mailer**.
3. Optionally target the `challenge_ended` mail key specifically.

## The reports page

A list of all challenges is available at **Reports → H5P Challenge**
(`/admin/reports/h5p_challenge`), gated by the same **Access administration
pages** permission.

## Gameplay endpoints

The gameplay endpoints are intentionally reachable by anonymous users (play
happens inside the H5P iframe) and expect a `token` parameter.
