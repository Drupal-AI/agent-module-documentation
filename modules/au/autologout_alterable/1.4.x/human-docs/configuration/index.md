# Configuration

Open the settings form at **Configuration → People → Autologout Alterable**
(`/admin/config/people/autologout_alterable`); you need the **Administer
autologout_alterable** permission. The module works with its defaults, so treat
everything here as tuning.

## Core timeout settings

- **Enabled** *(default on)* — the master switch for the whole module.
- **Session timeout** *(default 1800 seconds)* — the base inactivity period after
  which a user is logged out. This is the main setting most sites change.
- **Max session timeout** *(default 172800)* — the ceiling a user may choose when
  setting their own per-user threshold (see below).
- **Max session length** *(default none)* — a hard cap on total session length.
  Once reached, the session cannot be extended even by staying active or clicking
  "stay signed in".
- **Ignore user activity** *(default off)* — when on, users are logged out at the
  timeout regardless of whether they were active.
- **Use individual logout threshold** *(default off)* — lets users set their own
  timeout on their profile (bounded by *Max session timeout*).
- **Use infinite session for privileged users** *(default off)* — when on, holders
  of the "infinite session timeout" permission are never logged out for
  inactivity.
- **Include destination** *(default on)* — append the current page as a
  `destination` to the post-logout redirect.
- **Role logout** *(default off)* — enable per-role timeouts (configured per role,
  see below).
- **Use highest role timeout** *(default off)* — when a user has several matching
  roles, use the longest of their role timeouts.
- **Use cron** *(default on)* — let cron plus a queue worker expire sessions
  server-side, so a user is logged out even if they closed the tab.
- **Log to watchdog** *(default on)* — record autologout events in the site log.
- **Allowlisted IP addresses** — a comma-separated list of IPs that are exempt
  from autologout.

## Which interactions count as activity

A details section lets you toggle, individually, whether **mouse move**, **touch
move**, **click**, **key press**, and **scroll** each count as activity in the
browser. All are on by default. Turn some off if, for example, you do not want
passive mouse movement to keep a session alive.

## The warning dialog

- **Show dialog** *(default on)* — show a countdown warning before logout.
- **Dialog limit** *(default 60)* — how many seconds before expiry the dialog
  appears.
- **Dialog width** *(default 450)* — the dialog's width in pixels.
- **Countdown format** *(default `%hours%:%mins%:%secs%`)* — the countdown display,
  using the tokens `%days%`, `%hours%`, `%mins%`, `%secs%`.
- **Dialog text** — the title, message, and button labels for the "stay signed in"
  dialog, with a separate set of strings for the case where the session can no
  longer be extended, plus a "you have been logged out" dialog title and message.
- **Post-logout messages** — the message shown after an inactivity logout versus an
  induced (forced) logout, each with a message type such as *status* or *warning*.

All of these strings are translatable, so you can localise the dialog per
language.

## Per-role timeouts

When **Role logout** is on, each role gets its own small config object with an
**Enabled** flag and a **Session timeout**. This lets you, for example, give
administrators a short timeout and editors a longer one. If a user has multiple
matching roles, **Use highest role timeout** decides whether the longest wins.

## Per-user threshold

When **Use individual logout threshold** is on, a "Your current logout threshold"
field appears on the user edit form. A user can set their own threshold if they
have the **Change own autologout_alterable threshold** permission and are editing
their own account; an administrator with **Administer autologout_alterable** can
set it for anyone. The value is validated against **Max session timeout**.

## Permissions

- **Administer autologout_alterable** — access this settings form and edit any
  user's logout threshold.
- **Change own autologout_alterable threshold** — set only one's *own* threshold
  on the user edit form (only meaningful when individual thresholds are enabled).
- **Autologout_alterable infinite session timeout** — the holder is never logged
  out for inactivity *by this module* (only effective when *Use infinite session
  for privileged users* is on). Grant it to accounts that legitimately need no
  idle timeout, remembering their sessions then rely on other controls to end.

## Setting values from Drush

There are no dedicated Drush commands. You can set any option with core config
commands, for example:

```bash
drush config:set autologout_alterable.settings session_timeout 900
```
