# Configuration

User Expire has two ways to expire accounts — **per role** (by inactivity) and **per
user** (by date) — plus optional warning emails. The per‑role rules and email settings
live on the settings form; per‑user dates are set on each account's edit form.

## The settings form

Open **Configuration → People → User expire**
(`/admin/config/people/user-expire`). You need the **administer user expire settings**
permission. Everything here is stored in the `user_expire.settings` config object.

### Per‑role inactivity rules

- **Inactivity period per role** (`user_expire_roles`) — the form shows one field per
  role where you enter a number of seconds of inactivity, after which accounts holding
  that role are blocked. `0` (the default) means that role never expires. A "Time
  reference table" on the form helps you convert days to seconds (for example 90 days =
  7,776,000 seconds). The special **authenticated** role applies to *all* logged‑in
  users, which is a quick way to expire everyone after a period of inactivity.

  "Inactivity" is measured from the user's last login — or, for users who never logged
  in, from when their account was created. Un‑blocking a user refreshes their last‑access
  time so cron won't immediately re‑block them.

### Warning emails

- **Send expiration warnings** (`send_expiration_warnings`, default on) — the master
  switch for warning emails.
- **Frequency** (`frequency`, default `172800` = 2 days) — the minimum interval between
  warning‑email runs, so users aren't emailed too often.
- **Offset** (`offset`, default `604800` = 7 days) — how far *before* expiry to start
  warning users.
- **Warning email subject** (`expiration_warning_mail.subject`) and **body**
  (`expiration_warning_mail.body`) — the templated message. Both accept tokens such as
  `[site:name]`, `[user:display-name]`, and `[site:login-url]`.

Click **Save configuration** to apply. You can also set values from the command line:

```bash
# Expire authenticated users after 90 days of inactivity
drush php:eval '$c=\Drupal::configFactory()->getEditable("user_expire.settings");
  $r=$c->get("user_expire_roles"); $r["authenticated"]=7776000; $c->set("user_expire_roles",$r)->save();'

# Turn warning emails off
drush config:set user_expire.settings send_expiration_warnings 0 -y

# Start warning 14 days out, repeat daily
drush config:set user_expire.settings offset 1209600 -y
drush config:set user_expire.settings frequency 86400 -y
```

## Per‑user expiration dates

A single account's expiration date is **not** stored in config — it's set on the user's
own edit form:

1. Edit the account (you need the **set user expiration** permission).
2. In the **User expiration** section, tick the box and pick a date.
3. Save. That account will be blocked on the chosen date.

To remove an expiration, edit the user and untick the box.

## Permissions

All three are marked *restrict access* — grant them only to trusted staff:

| Permission | Machine name | Gates |
|------------|--------------|-------|
| Set user expiration | `set user expiration` | The "User expiration" section on the user edit form. |
| View expiring users report | `view expiring users report` | The Expiring users report (below). |
| Administer user expire settings | `administer user expire settings` | The settings form above. |

## The Expiring users report

**Reports → Expiring users** (`/admin/reports/expiring-users`) lists every account with a
pending expiration date, so you can see what's coming before cron blocks it.

## How blocking actually happens

Everything runs on **cron**, in this order: send per‑role warning emails, block per‑user
accounts whose date has passed, then block per‑role accounts that have been inactive too
long. Each block sets the account to *blocked*, clears its stored per‑user date, and
writes a log entry — so make sure cron is running, or nothing will expire.

## Building lists and automation

User Expire adds Views integration exposing the expiration date as a field, filter, and
sort — so you can build a user view sorted by upcoming expiration, or filter to accounts
expiring within a date range. It also provides a Rules action, "Set a user expiration
date", available when the contributed **Rules** module is installed.
