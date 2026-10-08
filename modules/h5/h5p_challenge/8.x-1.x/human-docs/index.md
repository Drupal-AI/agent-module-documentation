# H5P Challenge — manual setup guide

**H5P Challenge** (`h5p_challenge`) turns any piece of H5P content into a
shareable, code-joined competition. It attaches a "challenge" action beneath your
rendered H5P content: anyone can start a challenge for that content, share the
generated join code, and then participants play the same H5P activity and have
their scores recorded on a leaderboard. It builds on the
[H5P](https://www.drupal.org/project/h5p) module.

The flow is simple for end users. Someone starts a challenge (protected by Google
reCAPTCHA to stop bots, and confirmed by an email to the creator). Participants
join with the challenge code, play the H5P content in its normal iframe, and the
module records their xAPI results into its own tables — mirroring the way core
H5P stores results. Everyone can view a challenge's leaderboard, logged-in users
can review their own challenges, and administrators get a report of all
challenges. Cron handles cleanup and the "challenge ended" notifications, so
**cron should run hourly**.

A few things to plan for. Challenge creation depends on **Google reCAPTCHA**, so
you'll need reCAPTCHA site and secret keys. Result and "challenge ended" emails
go out as plain text by default; if you want richer emails you can optionally add
the Mail System and Mime Mail modules. An optional **REST submodule**
(`h5p_challenge_rest`) exposes read-only endpoints for challenge and points data
if you need to consume results from another application.

The gameplay JSON endpoints are deliberately open to anonymous users (gameplay
happens inside the H5P iframe) and expect a `token` parameter. The module is under active development, is
**not covered by Drupal's security advisory policy**, and requires **PHP 8.1**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally the REST submodule), and set cron to run hourly.
2. [Configuration](configuration/index.md) — reCAPTCHA keys, challenge durations,
   notification options, and optional attachment emails.

## Where it lives in the admin menu

The settings form is at **Configuration → System → H5P Challenge**
(`/admin/config/system/h5p_challenge`). The report of all challenges is at
**Reports → H5P Challenge** (`/admin/reports/h5p_challenge`).

## How to use it

1. Make sure the H5P module is installed and H5P content exists on the site.
2. On any rendered H5P content, use the **challenge** action to start a challenge
   (you'll pass the reCAPTCHA check, and the creator receives an email).
3. Share the generated **challenge code** with participants.
4. Participants join with the code and play the H5P content; their scores are
   recorded automatically.
5. View the leaderboard at `/h5p_challenge/{challenge}/results` (with a CSV export
   at `/h5p_challenge/{challenge}/results/csv`). Logged-in users see their own
   challenges at `/h5p_challenge/mine`.
6. A challenge can be ended early (`/h5p_challenge/{challenge}/end`) or deleted
   (`/h5p_challenge/{challenge}/delete`); cron also ends challenges when their
   duration is up and sends the "challenge ended" notice.
