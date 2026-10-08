# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No required Drupal module dependencies for the base module. Individual submodules require the
  modules they integrate with — for example **PostHog Commerce** needs Drupal Commerce, **PostHog
  Webform** needs Webform, and the consent submodules need the COOKiES or Klaro modules.
- A **PostHog account/project** (PostHog Cloud or a self‑hosted instance) with a **project API
  key** and **host**.

## Install with Composer

From the project root:

```bash
composer require drupal/posthog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed. This one package provides the base module and all of its submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/posthog -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en posthog -y
```

## Submodules — enable only what you need

The project ships many optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **PostHog JS Tracking** | `posthog_js` | The client‑side JavaScript SDK (from CDN or local). Tracks page views and browser interactions. |
| **PostHog PHP SDK** | `posthog_php` | Server‑side integration: send events from PHP, identify users on login. |
| **PostHog PHP Events** | `posthog_php_events` | Custom Drupal‑related server‑side events. |
| **PostHog COOKiES** | `posthog_cookies` | Ties PostHog tracking to the COOKiES consent module (supports a cookieless server‑hash mode when consent is denied). |
| **PostHog Klaro** | `posthog_klaro` | Consent integration with the Klaro consent manager. |
| **PostHog Commerce** | `posthog_commerce` | Tracks Drupal Commerce events (cart additions, order placements, purchases). |
| **PostHog Webform** | `posthog_webform` | Tracks Webform submissions and interactions. |
| **PostHog ECA** | `posthog_eca` | PostHog event actions for the ECA (Events‑Conditions‑Actions) module. |
| **PostHog JS Conditional Profiles** | `posthog_js_conditional_profiles` | Conditional client‑side profile handling. |
| **PostHog PHP Error Tracking** | `posthog_php_error_tracking` | Server‑side PHP error/exception capture *(marked TBD on the project page)*. |
| **PostHog Feature Flags** | `posthog_feature_flags` | Feature‑flag support incl. a Condition plugin *(marked TBD)*. |
| **PostHog Dashboards** | `posthog_dashboards` | PostHog dashboards inside the Drupal admin *(marked TBD)*. |

For example, to add client‑side tracking with consent:

```bash
drush en posthog_js posthog_cookies -y
```

## Verify it worked

1. Visit **`/admin/config/services/posthog`** and enter your PostHog host and API key.
2. Enable at least one tracking submodule (for example **PostHog JS Tracking**).
3. Browse the site (with consent granted, if you enabled a consent submodule) and confirm events
   appear in your PostHog project. See [Configuration](../configuration/index.md) for the
   settings and consent details.
