# Configuration

The **Settings** tab controls what the indicator shows and how it behaves
site-wide. This page walks through each option on the form, then explains the
recommended pattern for giving **each environment its own colour and name** and
the **Environment Switcher** tab for hopping between environments.

## Open the Settings tab

1. Go to **Configuration → Development → Environment Indicator**
   (`/admin/config/development/environment-indicator`).
2. You land on the **Settings** tab. (The **Environment Switcher** tab sits beside
   it — see the end of this page.)

![The Environment Indicator Settings page](../images/settings.png)

The page opens with a reminder that the indicator's visibility depends on the
viewer's permissions: the **`access environment indicator`** permission must be
enabled for a role before its users see the bar (see
[Installation](../installation/index.md)).

## The version identifier

The indicator can display a **version identifier** next to the environment name —
a release number, a git SHA, or a deployment identifier — so you know exactly
which build you are looking at. You choose where that value comes from.

1. **Source of version identifier to display** — pick the primary source from the
   dropdown:
   - **Environment Indicator Current Release** *(default)* — reads the
     `environment_indicator.current_release` state value. You set it at deploy
     time, for example:
     `drush state:set environment_indicator.current_release v1.2.44`.
   - **Deployment Identifier** — Drupal core's deployment identifier, typically set
     in `settings.php` or by your deployment process. It is a string that
     identifies the particular code or configuration version currently deployed.
   - **Drupal Version** — displays the current Drupal core version.
   - **None** — no version identifier is displayed.
2. **Fallback source of version identifier to display** — pick a fallback source so
   version information is always available even if the primary source is empty. The
   choices are the same as above. Note that choosing **None** for the *primary*
   source disallows a fallback.

## Show favicon

Tick **Show favicon** to add a favicon tinted with the environment colours
whenever the indicator is shown. This makes the browser tab itself distinguishable
between environments — handy when you have several tabs open across dev, staging,
and production. The box is ticked by default.

## Toolbar integration (deprecated)

The form also shows a **Toolbar (Deprecated)** checkbox under *Toolbar integration
(Deprecated)*. This older way of tinting the admin toolbar is deprecated and will
be removed in a future release. The form notes that you should instead enable the
**Environment Indicator - Toolbar Integration** (`environment_indicator_toolbar`)
module to get toolbar tinting and to remove this deprecated setting early. Leave it
alone unless you are specifically migrating away from it.

## Save

Click **Save configuration** at the bottom to store your choices.

## Important: define the colour and name per environment

The Settings form controls *behaviour*, but it does not, on its own, give each of
your environments a different colour. The recommended pattern — and the whole point
of the module — is to **pin each environment's name and colours in that
environment's `settings.php`**, so every deployed copy shows its own unambiguous
indicator.

Add an override like this to the `settings.php` of each environment, changing the
values per copy:

```php
// Production settings.php
$config['environment_indicator.indicator']['name'] = 'Production';
$config['environment_indicator.indicator']['bg_color'] = '#cc0000';
$config['environment_indicator.indicator']['fg_color'] = '#ffffff';
```

```php
// Local / development settings.php
$config['environment_indicator.indicator']['name'] = 'Development';
$config['environment_indicator.indicator']['bg_color'] = '#307b24';
$config['environment_indicator.indicator']['fg_color'] = '#ffffff';
```

- **`name`** — the label shown in the bar (and the browser tab hint).
- **`bg_color`** — the background colour of the strip.
- **`fg_color`** — the text (foreground) colour. Choose a pair with good contrast so
  the label stays readable.

Because this lives in each environment's own `settings.php`, production reliably
shows red, local reliably shows green, and there is no risk of the wrong colour
being deployed as shared configuration.

## The Environment Switcher tab

The second tab, **Environment Switcher**, lets you define entries that link between
your environments. Each switcher you create with a URL becomes an item in a
cross-environment **dropdown**, so a user can jump from, say, the page they are on
in staging to the equivalent environment elsewhere. Each switcher entry carries its
own name, description, URL, and foreground/background colours, and — being standard
configuration — can be exported and deployed like any other config.

To add one: open the **Environment Switcher** tab, add an entry, and fill in the
environment's name, its URL, and the colours you want its link to use. Save, and the
dropdown of environment links appears alongside the indicator for users who have
permission to see it.
