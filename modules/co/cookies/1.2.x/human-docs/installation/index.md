# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — you place the consent banner as a block.
- Core's **Configuration Translation** module (`config_translation`) — COOKiES is
  fully translatable, so this is a dependency.
- The **`jfeltkamp/cookiesjsr`** JavaScript library (`^1.0.12`) — the front-end
  consent library the module renders.

Both core modules are enabled automatically as dependencies. The `cookiesjsr`
library is a Composer package (see below); by default the module loads it from a
CDN, but you can switch to a locally installed copy in the settings.

## Install with Composer

From the project root:

```bash
composer require drupal/cookies -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `cookiesjsr`
library and update any shared dependencies as needed.

> **Loading the library locally:** if you set COOKiES to load `cookiesjsr` locally
> rather than from the CDN, the library must live at `/libraries/cookiesjsr`. With
> Composer this is normally handled for you when the project is set up to install
> libraries into `/libraries`; otherwise place the library there manually.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookies -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookies -y
```

After enabling, place the **COOKiES UI** block via Block layout and review the
settings — see [Configuration](../configuration/index.md).

## Integration submodules — enable one per third-party tool

COOKiES is designed so each popular service is a thin bridge submodule. Enable
only the ones matching the tools your site actually uses. Each depends on both
`cookies` and the tool's own Drupal module (for example `cookies_ga` needs the
Google Analytics module), and ships a ready-made service definition:

| Submodule | Machine name | Gates |
|-----------|--------------|-------|
| Google Analytics | `cookies_ga` | Google Analytics |
| Google Tag (gtag) | `cookies_gtag` | Google Tag / gtag.js |
| Matomo | `cookies_matomo` | Matomo analytics |
| Facebook Pixel | `cookies_facebook_pixel` | Facebook Pixel |
| Instagram | `cookies_instagram` | Instagram media embeds |
| Twitter/X media | `cookies_twitter_media` | Twitter/X media embeds |
| Video | `cookies_video` | Embedded YouTube/Vimeo (placeholder overlay until consent) |
| reCAPTCHA | `cookies_recaptcha` | Google reCAPTCHA |
| IVW | `cookies_ivw` | IVW tracking |
| Asset Injector | `cookies_asset_injector` | Arbitrary injected CSS/JS snippets |
| Filter | `cookies_filter` | Content behind a text-format filter |

Enable one like any module:

```bash
drush en cookies_ga -y
```

Each requires the base COOKiES module, which is already present once you have
installed it above. For a tool that doesn't have a bridge, copy one of these
submodules as a template, or define a custom service — see
[Configuration](../configuration/index.md).
