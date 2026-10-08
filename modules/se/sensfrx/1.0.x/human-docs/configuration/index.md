# Configuration

Configuring SensFRX is three steps: connect your SensFRX account, choose which
activities to protect, and set the policies that decide what happens at each risk
level.

## 1. Connect your account (Setup)

Immediately after you enable the module you are redirected to **Administration →
SensFRX → Setup**. There:

1. Enter the **email** you used when signing up on the SensFRX portal — use the
   same address so the accounts link.
2. Provide your **Property ID** and **Property Secret Key** from your SensFRX
   account, which authenticate the connection between Drupal and SensFRX.
3. Once verified, the connection is created and your dashboard becomes available.

Store the Property Secret Key securely — as an environment variable — rather than
leaving it in plain configuration.

## 2. Review the dashboard

After a successful connection you land on **Administration → SensFRX → Dashboard**,
where you can view activity, risk scores, device intelligence, and recent events as
SensFRX evaluates traffic on your site.

## 3. Choose protected activities and policies

Configure **which activities you want to protect** — for example registrations,
logins, profile updates, comments, and (with Drupal Commerce) orders — and set your
**fraud‑prevention policies**: **Allow**, **Block**, or **Review**, based on the
risk score SensFRX returns for each event. This is where you decide how aggressive
the protection is and where you'd rather review borderline cases by hand.

## Webhooks

SensFRX communicates decisions back to your site through webhook callbacks at
`/sensfrx/webhook` and `/sensfrx/transaction_webhook`. On a site without Drupal
Commerce Payment the shipped code can fail to register its routes at all.
